package com.startupstack.app.shared.media;

import com.startupstack.app.modules.admin.entity.RanjpathEntity;
import com.startupstack.app.modules.admin.repository.RanjpathRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class MediaService {

    private final MediaProperties properties;
    private final RanjpathRepository ranjpathRepository;

    public MediaService(MediaProperties properties, RanjpathRepository ranjpathRepository) {
        this.properties = properties;
        this.ranjpathRepository = ranjpathRepository;
    }

    /** Legacy's fallback when a DIGIT row carries no extension (USER_INTERFACE1.frm:4841-4852). */
    private static final String DEFAULT_EXTENSION = "avi";

    /**
     * @deprecated states no tier, so it silently assumes the low-res proxy and the single
     *     globally-configured extension. Use {@link #resolveStockPath(String, StockTier, String)}
     *     and pass the record's own {@code DIG_TYP} / {@code DIG_TYP_HIGH}.
     */
    @Deprecated
    public String resolveStockPath(String stockNo) {
        return resolveStockPath(stockNo, StockTier.LOW, null);
    }

    /**
     * Resolves the full filesystem path for a stock number within one storage tier.
     *
     * <p>Faithful to legacy {@code low_stock_path} / {@code high_stock_path}
     * (USER_INTERFACE1.frm:6602-6621, :6448-6466) on three points the previous implementation
     * got wrong:
     * <ul>
     *   <li>the candidate range must match the requested tier's {@code rjp_typ};</li>
     *   <li>the bounds test is <em>strictly</em> exclusive — legacy writes
     *       {@code rjp_nofrom < stock And stock < rjp_noto}, so a stock number sitting exactly
     *       on a boundary deliberately falls through to the base path;</li>
     *   <li>the extension is the record's own ({@code DIG_TYP} for LOW, {@code DIG_TYP_HIGH}
     *       for HIGH), defaulting to {@code avi} — not one global setting for the whole
     *       archive.</li>
     * </ul>
     *
     * @param extension the record's extension, with or without a leading dot; {@code null} or
     *                  blank falls back to the configured extension, then to {@code avi}
     */
    public String resolveStockPath(String stockNo, StockTier tier, String extension) {
        String trimmed = stockNo == null ? "" : stockNo.trim();
        String suffix = resolveExtension(extension);
        try {
            int num = Integer.parseInt(trimmed);

            List<RanjpathEntity> dbRanges = ranjpathRepository.findAll();
            if (!dbRanges.isEmpty()) {
                for (RanjpathEntity range : dbRanges) {
                    if (range.getRjpTyp() == null || range.getRjpTyp() != tier.rjpTyp()) {
                        continue;
                    }
                    int from = parseRangeValue(range.getRjpNoFrom());
                    int to   = parseRangeValue(range.getRjpNoTo());
                    if (num > from && num < to) {
                        return onDisk(range.getRjpPath().trim() + "/" + trimmed + suffix);
                    }
                }
            } else {
                for (MediaProperties.VolumeRange range : properties.getVolumes()) {
                    if (range.getTier() != tier.rjpTyp()) {
                        continue;
                    }
                    if (num > range.getFrom() && num < range.getTo()) {
                        return onDisk(range.getPath() + "/" + trimmed + suffix);
                    }
                }
            }
        } catch (NumberFormatException ignored) {
            // non-numeric stock numbers fall through to the base path
        }
        return onDisk(properties.getBasePath() + "/" + trimmed + suffix);
    }

    /** Normalises a bare or dotted extension to a dotted suffix, or "" when nothing is configured. */
    private String resolveExtension(String extension) {
        String chosen = extension == null || extension.isBlank() ? null : extension.trim();
        if (chosen == null) {
            String configured = properties.getExtension();
            chosen = configured == null || configured.isBlank() ? DEFAULT_EXTENSION : configured.trim();
        }
        if (chosen.isEmpty()) {
            return "";
        }
        return chosen.startsWith(".") ? chosen : "." + chosen;
    }

    /**
     * @deprecated states no tier. Retained so callers outside the archive-search cockpit keep
     *     their previous behaviour; give them an explicit {@link StockTier} when their own
     *     screen is migrated.
     */
    @Deprecated
    public boolean fileExists(String stockNo) {
        return fileExists(stockNo, StockTier.LOW, null);
    }

    /** @deprecated states no tier — see {@link #fileExists(String)}. */
    @Deprecated
    public String copyToArchive(String stockNo) {
        return copyToArchive(stockNo, StockTier.LOW, null);
    }

    public boolean fileExists(String stockNo, StockTier tier, String extension) {
        Path path = Paths.get(resolveStockPath(stockNo, tier, extension));
        return Files.exists(path) && Files.isRegularFile(path);
    }

    public Resource loadAsResource(String stockNo, StockTier tier, String extension) {
        return asReadableResource(Paths.get(resolveStockPath(stockNo, tier, extension)));
    }

    /**
     * True when {@code type1} names a non-video asset class that lives under the picture root
     * rather than on the tape volumes. Legacy branches on exactly this before deciding whether
     * to touch the media player at all (USER_INTERFACE1.frm:4858).
     */
    public boolean isNonVideoAssetClass(String type1) {
        return type1 != null && properties.getAssetClassFolders().containsKey(type1.trim());
    }

    /**
     * Resolves a non-video asset's path from its DIGIT row.
     *
     * <p>Reproduces legacy {@code datagrid1_DblClick} (:4858-4880), which routes on
     * {@code DIG_TYP1}: {@code 01} → scan, {@code 03} → photos, {@code 05} → private (all
     * opened externally via OpenDoc), {@code 02} → waves (played as audio). Everything else,
     * {@code 04} included, is video and belongs to
     * {@link #resolveStockPath(String, StockTier, String)} instead.
     *
     * <p>All four classes share the same 2/2 fan-out over {@code DIG_DIG_NO} —
     * {@code Mid$(V_REC,1,2) & "\" & Mid$(V_REC,3,2) & "\"} at :4873 — which keeps directory
     * sizes manageable on the archive volume. Asset ids shorter than four characters have no
     * fan-out to build, so they sit directly in the class folder.
     *
     * @throws BusinessException if {@code type1} is not a non-video class
     */
    public String resolveAssetPath(String digitNo, String type1, String extension) {
        String folder = type1 == null ? null : properties.getAssetClassFolders().get(type1.trim());
        if (folder == null) {
            throw new BusinessException("Not a non-video asset class: " + type1);
        }
        String trimmed = digitNo == null ? "" : digitNo.trim();
        return onDisk(stripTrailingSlash(properties.getPicturePath())
                + "/" + folder
                + fanOut(trimmed)
                + "/" + trimmed + resolveExtension(extension));
    }

    /** Legacy's two-level fan-out: the first two characters, then the next two. */
    private String fanOut(String digitNo) {
        if (digitNo.length() < 4) {
            return "";
        }
        return "/" + digitNo.substring(0, 2) + "/" + digitNo.substring(2, 4);
    }

    private String stripTrailingSlash(String path) {
        String p = path == null ? "" : path.trim();
        return p.endsWith("/") || p.endsWith("\\") ? p.substring(0, p.length() - 1) : p;
    }

    public boolean assetExists(String digitNo, String type1, String extension) {
        Path path = Paths.get(resolveAssetPath(digitNo, type1, extension));
        return Files.exists(path) && Files.isRegularFile(path);
    }

    public Resource loadAssetAsResource(String digitNo, String type1, String extension) {
        return asReadableResource(Paths.get(resolveAssetPath(digitNo, type1, extension)));
    }

    /**
     * Extracts a filesystem-safe extension from an uploaded filename, matching legacy's
     * {@code datagrid1_KeyPress} (Form6.frm:3580-3585) — grabs the trailing extension and drops
     * the dot — but derived correctly for any length rather than legacy's fixed 4-character
     * offset, and validated so a hostile filename can never influence the destination path.
     *
     * @throws BusinessException if the filename has no extension, or the extension is not a
     *     plain alphanumeric token that fits {@code DIGIT.DIG_TYP} ({@code char(4)})
     */
    public String extractExtension(String originalFilename) {
        if (originalFilename == null || originalFilename.isBlank()) {
            throw new BusinessException("Selected file has no name");
        }
        String name = Paths.get(originalFilename).getFileName().toString();
        int dot = name.lastIndexOf('.');
        if (dot < 0 || dot == name.length() - 1) {
            throw new BusinessException("Selected file has no extension");
        }
        String ext = name.substring(dot + 1);
        if (!ext.matches("[A-Za-z0-9]{1,4}")) {
            throw new BusinessException("Unsupported file extension: " + ext);
        }
        return ext.toLowerCase();
    }

    /**
     * Writes an uploaded non-video asset to its legacy fan-out destination and returns the
     * resolved path. Reproduces {@code datagrid1_KeyPress}'s {@code FileCopy}
     * (Form6.frm:3611-3624): the destination is never trusted from the client — it is entirely
     * derived from the server-generated {@code digitNo}, the validated {@code type1} class
     * folder and the server-derived extension, then defensively re-checked to still sit inside
     * {@code picturePath} before anything touches disk.
     *
     * @throws BusinessException if {@code type1} is not a non-video class, the resolved path
     *     escapes the configured picture root, or a file already exists at the destination
     *     (legacy's "هذا الملف مدخل سابقا" duplicate guard, Form6.frm:3613-3614)
     */
    public String writeAssetFile(MultipartFile file, String digitNo, String type1, String extension) {
        if (!isNonVideoAssetClass(type1)) {
            throw new BusinessException("Not a non-video asset class: " + type1);
        }
        String resolved = resolveAssetPath(digitNo, type1, extension);
        Path target = Paths.get(resolved).normalize();
        Path root = Paths.get(properties.getPicturePath()).normalize();
        if (!target.startsWith(root)) {
            throw new BusinessException("Resolved destination escapes the configured media root");
        }
        if (Files.exists(target)) {
            throw new BusinessException("A file already exists for digit number " + digitNo);
        }
        try {
            Files.createDirectories(target.getParent());
            file.transferTo(target);
            return target.toString();
        } catch (IOException e) {
            throw new BusinessException("Failed to store uploaded file: " + e.getMessage());
        }
    }

    /**
     * Best-effort cleanup of a partially-written asset when the database write that should
     * follow it fails. A plain {@code @Transactional} only rolls back the database side — it
     * cannot undo a filesystem write, so callers that write the file before persisting the row
     * must call this explicitly on failure (see {@code DigitizationService.uploadDigitFile}).
     */
    public void deleteQuietly(String path) {
        if (path == null) {
            return;
        }
        try {
            Files.deleteIfExists(Paths.get(path));
        } catch (IOException ignored) {
            // best-effort — an orphaned file with no DB row is safe; the reverse is not
        }
    }

    /**
     * Legacy ran on Windows, where {@code 000003.avi} opens {@code 000003.AVI}: when the exact
     * name is missing, the same name in another letter case is used instead. Returns the input
     * unchanged when nothing matches, so "not found" still behaves as before.
     */
    String onDisk(String candidate) {
        Path path = Paths.get(candidate);
        if (Files.exists(path)) {
            return candidate;
        }
        Path dir = path.getParent();
        if (dir == null || !Files.isDirectory(dir)) {
            return candidate;
        }
        String name = path.getFileName().toString();
        try (var files = Files.list(dir)) {
            return files.filter(f -> f.getFileName().toString().equalsIgnoreCase(name))
                    .findFirst().map(Path::toString).orElse(candidate);
        } catch (IOException e) {
            return candidate;
        }
    }

    /** Extensions a browser's video/audio element plays as-is; anything else gets an MP4 preview. */
    private static final java.util.Set<String> BROWSER_PLAYABLE =
            java.util.Set.of("mp4", "m4v", "webm", "ogv", "ogg", "mp3", "wav", "m4a", "aac");

    /**
     * The file the in-app player should receive. Legacy previewed AVI/MPG in the Windows media
     * control; browsers cannot decode those containers, so a non-playable file is converted
     * once with ffmpeg into an H.264/AAC MP4 under {@code <archive-path>/preview} and reused.
     * Same timeline, so in/out marks keep their meaning; downloads and cuts still use the original.
     *
     * @return the playable resource, or {@code null} when the source file does not exist
     */
    public Resource loadPreviewResource(String stockNo, StockTier tier, String extension) {
        Resource source = loadAsResource(stockNo, tier, extension);
        if (source == null) {
            return null;
        }
        try {
            Path src = source.getFile().toPath();
            String name = src.getFileName().toString();
            int dot = name.lastIndexOf('.');
            String ext = dot < 0 ? "" : name.substring(dot + 1).toLowerCase();
            if (BROWSER_PLAYABLE.contains(ext)) {
                return source;
            }
            Path dir = Paths.get(properties.getArchivePath(), "preview");
            Files.createDirectories(dir);
            Path out = dir.resolve(name + "." + Files.getLastModifiedTime(src).toMillis() + ".mp4");
            synchronized (this) {
                if (!Files.exists(out)) {
                    Path tmp = dir.resolve(out.getFileName() + ".part.mp4");
                    Process proc = new ProcessBuilder("ffmpeg", "-y", "-loglevel", "error", "-i", src.toString(),
                            "-c:v", "libx264", "-preset", "veryfast", "-crf", "28", "-vf", "scale=-2:'min(480,ih)'",
                            "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "128k", "-movflags", "+faststart", tmp.toString())
                            .redirectErrorStream(true).redirectOutput(ProcessBuilder.Redirect.DISCARD).start();
                    if (proc.waitFor() != 0 || !Files.exists(tmp)) {
                        Files.deleteIfExists(tmp);
                        throw new BusinessException("Could not prepare a playable preview for " + name);
                    }
                    Files.move(tmp, out, StandardCopyOption.REPLACE_EXISTING);
                }
            }
            return new FileSystemResource(out);
        } catch (IOException e) {
            throw new BusinessException("Could not prepare a playable preview: " + e.getMessage());
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new BusinessException("Preview preparation was interrupted");
        }
    }

    /** Returns the resource only when it is a real, readable file — otherwise {@code null}. */
    Resource asReadableResource(Path path) {
        FileSystemResource resource = new FileSystemResource(path);
        if (!resource.exists() || !resource.isFile()) {
            return null;
        }
        return resource;
    }

    /**
     * Copies the file resolved for {@code stockNo} into the configured archive
     * directory (creating it if missing), as {@code <archive-path>/<stockNo><extension>}.
     *
     * @return the destination path as a string
     * @throws BusinessException if the source file does not exist
     */
    public String copyToArchive(String stockNo, StockTier tier, String extension) {
        Path source = Paths.get(resolveStockPath(stockNo, tier, extension));
        if (!Files.exists(source) || !Files.isRegularFile(source)) {
            throw new BusinessException("Source file not found for stock number: " + stockNo);
        }

        try {
            Path archiveDir = Paths.get(properties.getArchivePath());
            Files.createDirectories(archiveDir);

            String trimmed = stockNo == null ? "" : stockNo.trim();
            Path destination = archiveDir.resolve(trimmed + resolveExtension(extension));

            Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
            return destination.toString();
        } catch (IOException e) {
            throw new BusinessException("Failed to copy file to archive: " + e.getMessage());
        }
    }

    /**
     * Resolves (and creates, if missing) a destination path in the archive directory for the
     * given base name — used by the demand-fulfilment mechanisms that produce a named clip
     * rather than a stock-number-keyed whole-file copy.
     */
    public String archivePathFor(String name) {
        try {
            Path archiveDir = Paths.get(properties.getArchivePath());
            Files.createDirectories(archiveDir);
            return archiveDir.resolve(name + properties.getExtension()).toString();
        } catch (IOException e) {
            throw new BusinessException("Failed to prepare archive destination: " + e.getMessage());
        }
    }

    /**
     * The archive directory (created if missing) — where the "طلبيات الفيديو" queue writes the
     * files legacy wrote to the folder picked in its Save dialog.
     */
    public Path archiveDirectory() {
        try {
            Path archiveDir = Paths.get(properties.getArchivePath());
            Files.createDirectories(archiveDir);
            return archiveDir;
        } catch (IOException e) {
            throw new BusinessException("Failed to prepare archive destination: " + e.getMessage());
        }
    }

    /**
     * Legacy Command5's output name:
     * {@code "ARCHIVE_" + box_user_no + "_" + d-M-yyyy + "_" + HHMMSS + ext}, written into
     * {@code box_user_path}. Day and month are deliberately <em>not</em> zero-padded — legacy
     * builds them with {@code Trim(Str(Day(Date)))} — while the time component is.
     *
     * @return the destination path, with the per-user directory created
     */
    public String edlcOutputPathFor(String userNo, LocalDateTime at, String extension) {
        String name = "ARCHIVE_" + (userNo == null ? "" : userNo.trim())
                + "_" + at.getDayOfMonth() + "-" + at.getMonthValue() + "-" + at.getYear()
                + "_" + at.format(DateTimeFormatter.ofPattern("HHmmss"))
                + resolveExtension(extension);
        return userOutputDir(userNo).resolve(name).toString();
    }

    /** Swaps a clip's extension for {@code .png}, for Command5's sibling poster frame. */
    public String posterPathFor(String clipPath) {
        int dot = clipPath.lastIndexOf('.');
        int sep = Math.max(clipPath.lastIndexOf('/'), clipPath.lastIndexOf('\\'));
        return (dot > sep ? clipPath.substring(0, dot) : clipPath) + ".png";
    }

    private Path userOutputDir(String userNo) {
        try {
            Path dir = Paths.get(properties.getUserOutputPath())
                    .resolve(userNo == null || userNo.isBlank() ? "shared" : userNo.trim());
            Files.createDirectories(dir);
            return dir;
        } catch (IOException e) {
            throw new BusinessException("Failed to prepare the output directory: " + e.getMessage());
        }
    }

    /**
     * Legacy Command14's final name — {@code <sanitised desc> Clip <ser>.<ext>} — including its
     * collision handling: when that name is taken it retries as {@code 1_<name>},
     * {@code 2_<name>}… until one is free (:3440-3460). The description is sanitised by the
     * caller (see FilenameSanitiser) before it reaches here.
     */
    public String archiveClipPathFor(String description, Integer serial, String extension) {
        try {
            Path archiveDir = Paths.get(properties.getArchivePath());
            Files.createDirectories(archiveDir);

            String base = (description == null ? "" : description.trim())
                    + " Clip " + (serial == null ? "" : serial.toString());
            String suffix = resolveExtension(extension);

            Path candidate = archiveDir.resolve(base + suffix);
            int k = 1;
            while (Files.exists(candidate)) {
                candidate = archiveDir.resolve(k + "_" + base + suffix);
                k++;
            }
            return candidate.toString();
        } catch (IOException e) {
            throw new BusinessException("Failed to prepare the clip destination: " + e.getMessage());
        }
    }

    private int parseRangeValue(String value) {
        if (value == null) return 0;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
