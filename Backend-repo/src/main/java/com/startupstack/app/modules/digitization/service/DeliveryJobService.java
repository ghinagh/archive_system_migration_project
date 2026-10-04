package com.startupstack.app.modules.digitization.service;

import com.startupstack.app.modules.digitization.dto.DeliveryJobStatus;
import com.startupstack.app.modules.digitization.entity.DemandEntity;
import com.startupstack.app.modules.digitization.repository.DemandRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.media.FfmpegService;
import com.startupstack.app.shared.media.MediaService;
import com.startupstack.app.shared.media.StockTier;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.InvalidPathException;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Runs the archive screen's two batch deliveries.
 *
 * <p>Both legacy handlers share a shape: walk the request queue, act only on rows with
 * {@code dmd_chek = 1}, run ffmpeg per row, mark the row {@code dmd_chek = 2}, and collect the
 * stock numbers that failed so they can be reported together at the end. They differ in what
 * ffmpeg does and where the output lands:
 *
 * <ul>
 *   <li><b>Command5 "ارسل الى EDLC"</b> (:4095-4405) re-encodes to DV PAL, grabs a poster
 *       frame, writes into the user's output folder, records the executing user, and registers
 *       the file with the external EDLC system.</li>
 *   <li><b>Command14 "تنفيد"</b> (:3219-3467) stream-copies (no re-encode) into a
 *       user-chosen folder, naming each output {@code <desc> Clip <ser>.<ext>}.</li>
 * </ul>
 *
 * <p>Two deliberate departures from legacy, both forced by the platform rather than chosen:
 * legacy blocked its UI for the duration of the batch, which no HTTP request can do, so the
 * work runs on a background executor and the client polls {@link #getStatus}; and legacy
 * Command14 wrote to a folder picked in a Save dialog, which a browser cannot offer, so
 * output lands in the server-side archive directory and is then offered for download.
 */
@Service
public class DeliveryJobService {

    private static final Logger log = LoggerFactory.getLogger(DeliveryJobService.class);

    /** Legacy grabs Command5's poster frame at 00:00:02. */
    private static final int POSTER_FRAME_SECOND = 2;

    private final DemandRepository demandRepository;
    private final MediaService mediaService;
    private final FfmpegService ffmpegService;
    private final EdlcGateway edlcGateway;

    /**
     * Live job state. In-memory because a job is only meaningful to the session that started
     * it and dies with the process that runs it; a restart mid-batch leaves the demand rows
     * as the durable record of what completed.
     */
    private final Map<String, DeliveryJobStatus> jobs = new ConcurrentHashMap<>();

    public DeliveryJobService(DemandRepository demandRepository,
                              MediaService mediaService,
                              FfmpegService ffmpegService,
                              EdlcGateway edlcGateway) {
        this.demandRepository = demandRepository;
        this.mediaService = mediaService;
        this.ffmpegService = ffmpegService;
        this.edlcGateway = edlcGateway;
    }

    public DeliveryJobStatus getStatus(String jobId) {
        DeliveryJobStatus status = jobs.get(jobId);
        if (status == null) {
            throw new ResourceNotFoundException("Delivery job not found: " + jobId);
        }
        return status;
    }

    /** Registers a job up front so the caller gets an id it can poll immediately. */
    public DeliveryJobStatus start(List<Integer> ids) {
        DeliveryJobStatus status = new DeliveryJobStatus();
        status.setJobId(UUID.randomUUID().toString());
        status.setTotal(ids == null ? 0 : ids.size());
        jobs.put(status.getJobId(), status);
        return status;
    }

    /** Command5 — DV PAL transcode, poster frame, status writes, EDLC hand-off. */
    @Async("mediaJobExecutor")
    public void runSendToEdlc(String jobId, List<Integer> ids, String executingUserNo, String executingUserName) {
        run(jobId, ids, (entity, status) -> {
            LocalDateTime now = LocalDateTime.now();
            String destination = mediaService.edlcOutputPathFor(executingUserNo, now, extensionOf(entity));
            BigDecimal in = entity.getInputSize();
            BigDecimal duration = entity.getOutputSize();

            ffmpegService.encodeDvPal(sourceFor(entity), destination, in, duration);
            // Best-effort: a missing poster must not void a delivered clip.
            try {
                ffmpegService.extractPoster(destination, mediaService.posterPathFor(destination), POSTER_FRAME_SECOND);
            } catch (RuntimeException e) {
                log.warn("Poster frame failed for demand {}: {}", entity.getId(), e.getMessage());
            }

            // Legacy upd_demand1 + upd_dmd_user_do.
            entity.setChecked(2);
            entity.setExecutedByUserNo(executingUserNo);

            if (edlcGateway.registerDeliveredFile(
                    fileNameOf(destination), entity.getDescription(),
                    timecodeOf(duration), executingUserName)) {
                status.setHandedOffToEdlc(status.getHandedOffToEdlc() + 1);
            }
            return destination;
        });
    }

    /** Command14 — stream-copy trim into "<desc> Clip <ser>.<ext>". */
    @Async("mediaJobExecutor")
    public void runExtractClips(String jobId, List<Integer> ids) {
        run(jobId, ids, (entity, status) -> {
            String destination = mediaService.archiveClipPathFor(
                    entity.getDescription(), entity.getSerial(), extensionOf(entity));
            ffmpegService.streamCopyTrim(sourceFor(entity), destination,
                    entity.getInputSize(), entity.getOutputSize());
            entity.setChecked(2);
            return destination;
        });
    }

    /** What one row's delivery does; returns the produced file's path. */
    @FunctionalInterface
    private interface DeliveryStep {
        String apply(DemandEntity entity, DeliveryJobStatus status);
    }

    /**
     * The shared loop. Each row is committed on its own so a failure late in the batch cannot
     * undo the clips already delivered — legacy likewise executed its status update per item,
     * inside a handler that swallowed errors and carried on.
     */
    private void run(String jobId, List<Integer> ids, DeliveryStep step) {
        DeliveryJobStatus status = jobs.get(jobId);
        if (status == null) {
            return;
        }
        try {
            List<DemandEntity> entities = demandRepository.findAllById(ids);
            // Legacy `If m_chek = 1` — only queued rows are delivered; fulfilled or
            // de-selected rows are silently skipped.
            List<DemandEntity> queued = entities.stream()
                    .filter(e -> e.getChecked() != null && e.getChecked() == 1)
                    .toList();

            status.setTotal(queued.size());
            if (queued.isEmpty()) {
                status.setNothingSelected(true);
                status.setState(DeliveryJobStatus.State.COMPLETED);
                return;
            }

            for (DemandEntity entity : queued) {
                status.setCurrentTitle(entity.getDescription());
                try {
                    String output = deliverOne(entity, status, step);
                    status.getOutputPaths().add(output);
                    status.setSucceeded(status.getSucceeded() + 1);
                } catch (RuntimeException e) {
                    log.warn("Delivery failed for demand {} (stock {}): {}",
                            entity.getId(), entity.getMachineStock(), e.getMessage());
                    status.getFailedStockNumbers().add(
                            entity.getMachineStock() == null ? String.valueOf(entity.getId())
                                                             : entity.getMachineStock().trim());
                }
                status.setProcessed(status.getProcessed() + 1);
            }
            status.setCurrentTitle(null);
            status.setState(DeliveryJobStatus.State.COMPLETED);
        } catch (RuntimeException e) {
            log.error("Delivery job {} failed", jobId, e);
            status.setErrorMessage(e.getMessage());
            status.setState(DeliveryJobStatus.State.FAILED);
        }
    }

    /**
     * One row's delivery. Deliberately not annotated {@code @Transactional}: it is called from
     * {@link #run} on the same bean, so the proxy would be bypassed and the annotation would
     * be silently inert. The single {@code save} below carries its own transaction from Spring
     * Data, which is exactly the granularity wanted here — one committed row per delivered
     * clip, so a later failure cannot roll back earlier successes.
     */
    private String deliverOne(DemandEntity entity, DeliveryJobStatus status, DeliveryStep step) {
        String output = step.apply(entity, status);
        // dmd_path is the source the clip was cut from; legacy (upd_demand1 / upd_dmd_user_do)
        // never rewrites it, so only the status columns set by the step are persisted.
        demandRepository.save(entity);
        return output;
    }

    // ---------------------------------------------------------------------------------------
    // "طلبيات الفيديو" queue — new_vdpreview.frm Command9 "start", Command4 "newstart",
    // Command5 "copy". Rows arrive in grid order; only dmd_chek = 1 rows are processed.
    // Output names are built from the Save-dialog name exactly as legacy builds them, inside
    // the server archive directory. One deliberate difference: legacy's On Error Resume Next
    // let a failed save/copy still be marked dmd_chek = 2; here a row is only marked done
    // when its output was actually produced, and is otherwise reported as not executed.
    // ---------------------------------------------------------------------------------------

    @Async("mediaJobExecutor")
    public void runQueueProcess(String jobId, List<Integer> orderedIds, String mechanism,
                                boolean clip, String outputName) {
        DeliveryJobStatus status = jobs.get(jobId);
        if (status == null) {
            return;
        }
        try {
            Map<Integer, DemandEntity> byId = new HashMap<>();
            for (DemandEntity e : demandRepository.findAllById(orderedIds)) {
                byId.put(e.getId(), e);
            }
            List<DemandEntity> rows = orderedIds.stream().map(byId::get).filter(Objects::nonNull).toList();
            long queued = rows.stream().filter(DeliveryJobService::isQueued).count();
            status.setTotal((int) queued);
            if (queued == 0) {
                status.setNothingSelected(true);
                status.setState(DeliveryJobStatus.State.COMPLETED);
                return;
            }

            String base = mediaService.archiveDirectory().resolve(outputName.trim()).toString();
            switch (mechanism) {
                case "COPY" -> queueCopy(rows, clip, base, status);
                case "NEWSTART" -> queueNewstart(rows, clip, base, status);
                case "START" -> queueStart(rows, clip, base, status);
                default -> throw new IllegalArgumentException("Unknown mechanism: " + mechanism);
            }
            status.setCurrentTitle(null);
            status.setState(DeliveryJobStatus.State.COMPLETED);
        } catch (RuntimeException e) {
            log.error("Queue job {} failed", jobId, e);
            status.setErrorMessage(e.getMessage());
            status.setState(DeliveryJobStatus.State.FAILED);
        }
    }

    /** Command5 "copy" (:2171-2261). */
    private void queueCopy(List<DemandEntity> rows, boolean clip, String base, DeliveryJobStatus status) {
        for (DemandEntity row : rows) {
            String path = trimmed(row.getPath());
            String ext = lastChars(path, 4);
            String target;
            if (clip) {
                // Legacy uses an undeclared `i` here, so the index is always "0"; the collision
                // loop then yields base_0, base_1_0, base_2_0 ...
                target = base + "_0" + ext;
                for (int k = 1; exists(target); k++) {
                    target = base + "_" + k + "_0" + ext;
                }
            } else {
                target = base + trimmed(row.getDescription()) + " Clip " + row.getSerial() + ext;
            }
            if (!isQueued(row)) {
                continue;
            }
            status.setCurrentTitle(trimmed(row.getDescription()));
            boolean durationOk = !(".avi".equals(ext) || ".AVI".equals(ext)) || ffmpegService.checkPlayable(path);
            boolean done = false;
            if (durationOk && exists(path)) {
                try {
                    Files.copy(Path.of(path), Path.of(target), StandardCopyOption.REPLACE_EXISTING);
                    done = Files.size(Path.of(path)) != 0;
                } catch (IOException | RuntimeException e) {
                    log.warn("Queue copy failed for demand {}: {}", row.getId(), e.getMessage());
                }
            }
            finishRow(row, done, target, status);
        }
    }

    /** Command4 "newstart" (:1959-2170). */
    private void queueNewstart(List<DemandEntity> rows, boolean clip, String base, DeliveryJobStatus status) {
        int i = 1;
        for (DemandEntity row : rows) {
            String path = trimmed(row.getPath());
            String ext = lastChars(path, 4);
            String target = base + "_" + i + ext;
            if (clip) {
                for (int k = 1; exists(target); k++) {
                    target = base + "_" + k + "_" + i + ext;
                }
            }
            if (!isQueued(row)) {
                continue;
            }
            if (!exists(path)) {
                finishRow(row, false, null, status);
                continue;
            }
            i++;
            status.setCurrentTitle(trimmed(row.getDescription()));
            try {
                ffmpegService.legacyNewstart(path, target, row.getInputSize(), row.getOutputSize());
            } catch (RuntimeException e) {
                log.warn("Queue newstart failed for demand {}: {}", row.getId(), e.getMessage());
            }
            if (!exists(target)) {
                finishRow(row, false, null, status);
                continue;
            }
            String output = target;
            if (!clip) {
                String desc = trimmed(row.getDescription());
                String dest = base + desc + " Clip " + row.getSerial() + ext;
                for (int k = 1; exists(dest); k++) {
                    dest = base + k + "_" + desc + " Clip " + row.getSerial() + ext;
                }
                try {
                    Files.move(Path.of(target), Path.of(dest));
                    output = dest;
                } catch (IOException e) {
                    log.warn("Queue newstart rename failed for demand {}: {}", row.getId(), e.getMessage());
                }
            }
            finishRow(row, true, output, status);
        }
    }

    /** Command9 "start" (:2408-2750); with كليب every scene is merged into {@code <name>.avi}. */
    private void queueStart(List<DemandEntity> rows, boolean clip, String base, DeliveryJobStatus status) {
        List<DemandEntity> clipRows = new ArrayList<>();
        for (DemandEntity row : rows) {
            if (!isQueued(row)) {
                continue;
            }
            String path = trimmed(row.getPath());
            if (!exists(path) || !ffmpegService.checkPlayable(path)) {
                finishRow(row, false, null, status);
                continue;
            }
            status.setCurrentTitle(trimmed(row.getDescription()));
            if (clip) {
                clipRows.add(row);
                continue;
            }
            String target = base + trimmed(row.getDescription()) + " Clip " + row.getSerial() + ".avi";
            boolean done = false;
            try {
                ffmpegService.legacyStartEncode(path, target, row.getInputSize(), row.getOutputSize());
                done = true;
            } catch (RuntimeException e) {
                log.warn("Queue start failed for demand {}: {}", row.getId(), e.getMessage());
            }
            finishRow(row, done, target, status);
        }
        if (clipRows.isEmpty()) {
            return;
        }
        status.setCurrentTitle("دمج كل المشاهد");
        String merged = base + ".avi";
        List<String> parts = new ArrayList<>();
        boolean done = false;
        try {
            for (DemandEntity row : clipRows) {
                String part = Files.createTempFile("queue-start-", ".avi").toString();
                parts.add(part);
                ffmpegService.legacyStartEncode(trimmed(row.getPath()), part, row.getInputSize(), row.getOutputSize());
            }
            ffmpegService.mergeConcat(parts, merged);
            done = true;
        } catch (IOException | RuntimeException e) {
            log.warn("Queue start merge failed: {}", e.getMessage());
        } finally {
            parts.forEach(mediaService::deleteQuietly);
        }
        for (DemandEntity row : clipRows) {
            finishRow(row, done, merged, status);
        }
    }

    /** Legacy upd_demand1 … dmd_chek = 2 on success; the stock number joins m_txt_no on failure. */
    private void finishRow(DemandEntity row, boolean done, String output, DeliveryJobStatus status) {
        if (done) {
            row.setChecked(2);
            demandRepository.save(row);
            status.setSucceeded(status.getSucceeded() + 1);
            if (output != null && !status.getOutputPaths().contains(output)) {
                status.getOutputPaths().add(output);
            }
        } else {
            status.getFailedStockNumbers().add(
                    row.getMachineStock() == null ? String.valueOf(row.getId()) : row.getMachineStock().trim());
        }
        status.setProcessed(status.getProcessed() + 1);
    }

    private static boolean isQueued(DemandEntity e) {
        return e.getChecked() != null && e.getChecked() == 1;
    }

    private static String trimmed(String value) {
        return value == null ? "" : value.trim();
    }

    /** Legacy {@code Mid(V_PATH, Len(V_PATH) - 3, 4)}. */
    private static String lastChars(String value, int n) {
        return value.length() >= n ? value.substring(value.length() - n) : value;
    }

    private static boolean exists(String path) {
        if (path == null || path.isBlank()) {
            return false;
        }
        try {
            return Files.isRegularFile(Path.of(path));
        } catch (InvalidPathException e) {
            return false;
        }
    }

    /** Legacy feeds ffmpeg the demand's own dmd_path, already resolved against the master. */
    private String sourceFor(DemandEntity entity) {
        String stored = entity.getPath();
        if (stored != null && !stored.isBlank()) {
            return stored.trim();
        }
        return mediaService.resolveStockPath(entity.getMachineStock(), StockTier.HIGH, null);
    }

    /** Carries the source's extension onto the output, as legacy's V_EXT does. */
    private String extensionOf(DemandEntity entity) {
        String path = entity.getPath();
        if (path == null) {
            return null;
        }
        int dot = path.lastIndexOf('.');
        int sep = Math.max(path.lastIndexOf('/'), path.lastIndexOf('\\'));
        return dot > sep ? path.substring(dot + 1).trim() : null;
    }

    private String fileNameOf(String path) {
        int sep = Math.max(path.lastIndexOf('/'), path.lastIndexOf('\\'));
        return sep >= 0 ? path.substring(sep + 1) : path;
    }

    /** Legacy time_code3 — the clip's duration as HH:MM:SS. */
    private String timecodeOf(BigDecimal durationSeconds) {
        long total = durationSeconds == null ? 0L : durationSeconds.longValue();
        return String.format("%02d:%02d:%02d", total / 3600, (total % 3600) / 60, total % 60);
    }
}
