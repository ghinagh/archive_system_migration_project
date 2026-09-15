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

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
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
        entity.setPath(output);
        demandRepository.save(entity);
        return output;
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
