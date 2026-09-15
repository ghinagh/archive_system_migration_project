package com.startupstack.app.shared.media;

import com.startupstack.app.shared.exception.BusinessException;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Server-side replacement for the legacy new_vdpreview.frm's three parallel fulfilment
 * mechanisms, which all assumed direct filesystem access from the librarian's desktop:
 * Command9 "start" (VideoEdit ActiveX re-encode) → {@link #reencode}, Command4 "newstart"
 * (ffmpeg stream-copy shell-out) → {@link #streamCopyTrim}, Command19 "test" (dry-run file
 * check) → {@link #checkPlayable}. The legacy "كليب" checkbox (merge several clips into one
 * output) is {@link #mergeConcat}.
 */
@Service
public class FfmpegService {

    private static final long TIMEOUT_SECONDS = 300;

    /** Command9 "start" — full re-encode of the [in, in+duration) range. */
    public void reencode(String source, String destination, BigDecimal inSeconds, BigDecimal durationSeconds) {
        run(buildTrimArgs(source, destination, inSeconds, durationSeconds, false));
    }

    /** Command4 "newstart" — stream-copy trim of the [in, in+duration) range, no re-encode. */
    public void streamCopyTrim(String source, String destination, BigDecimal inSeconds, BigDecimal durationSeconds) {
        run(buildTrimArgs(source, destination, inSeconds, durationSeconds, true));
    }

    /**
     * Legacy Command5 "ارسل الى EDLC" (USER_INTERFACE1.frm:4095-4405) encodes each delivery
     * clip to DV PAL before handing it to the edit suite:
     * {@code ffmpeg -ss <in> -i <src> -acodec pcm_s16le -s 720x576 -vcodec dvvideo -t <dur>}.
     * The profile is not incidental — 720x576 DV with 16-bit PCM audio is what the receiving
     * system ingests, so it is reproduced exactly rather than substituted with a modern codec.
     */
    public void encodeDvPal(String source, String destination, BigDecimal inSeconds, BigDecimal durationSeconds) {
        List<String> args = new ArrayList<>();
        args.add("ffmpeg");
        args.add("-y");
        if (inSeconds != null) {
            args.add("-ss");
            args.add(inSeconds.toPlainString());
        }
        args.add("-i");
        args.add(source);
        args.add("-acodec");
        args.add("pcm_s16le");
        args.add("-s");
        args.add("720x576");
        args.add("-vcodec");
        args.add("dvvideo");
        if (durationSeconds != null) {
            args.add("-t");
            args.add(durationSeconds.toPlainString());
        }
        args.add(destination);
        run(args);
    }

    /**
     * Legacy Command5's poster frame — {@code ffmpeg -ss 00:00:02 -i <clip> -frames:v 1 <png>}.
     * Grabbed two seconds in rather than at zero, which on tape material is usually black.
     */
    public void extractPoster(String source, String destination, int atSeconds) {
        run(List.of("ffmpeg", "-y", "-ss", String.valueOf(atSeconds), "-i", source,
                "-frames:v", "1", destination));
    }

    /** The legacy "كليب" option — concatenates several already-produced clips into one output file. */
    public void mergeConcat(List<String> sources, String destination) {
        Path listFile;
        try {
            listFile = Files.createTempFile("ffmpeg-concat-", ".txt");
            StringBuilder sb = new StringBuilder();
            for (String s : sources) {
                sb.append("file '").append(s.replace("'", "'\\''")).append("'\n");
            }
            Files.writeString(listFile, sb.toString());
        } catch (IOException e) {
            throw new BusinessException("Failed to prepare merge list: " + e.getMessage());
        }
        try {
            run(List.of("ffmpeg", "-y", "-f", "concat", "-safe", "0", "-i", listFile.toString(), "-c", "copy", destination));
        } finally {
            try {
                Files.deleteIfExists(listFile);
            } catch (IOException ignored) {
                // best-effort cleanup of the temp concat list
            }
        }
    }

    /** Command19 "test" — verifies the source file exists and is a decodable media file, without producing anything. */
    public boolean checkPlayable(String source) {
        if (!Files.exists(Path.of(source))) {
            return false;
        }
        try {
            Process process = new ProcessBuilder("ffprobe", "-v", "error", "-show_entries", "format=duration",
                    "-of", "default=noprint_wrappers=1:nokey=1", source)
                    .redirectErrorStream(true)
                    .start();
            boolean finished = process.waitFor(30, TimeUnit.SECONDS);
            return finished && process.exitValue() == 0;
        } catch (IOException | InterruptedException e) {
            if (e instanceof InterruptedException) {
                Thread.currentThread().interrupt();
            }
            return false;
        }
    }

    private List<String> buildTrimArgs(String source, String destination, BigDecimal inSeconds,
                                        BigDecimal durationSeconds, boolean streamCopy) {
        List<String> args = new ArrayList<>();
        args.add("ffmpeg");
        args.add("-y");
        if (inSeconds != null) {
            args.add("-ss");
            args.add(inSeconds.toPlainString());
        }
        args.add("-i");
        args.add(source);
        if (durationSeconds != null) {
            args.add("-t");
            args.add(durationSeconds.toPlainString());
        }
        if (streamCopy) {
            args.add("-c");
            args.add("copy");
        } else {
            args.add("-c:v");
            args.add("libx264");
            args.add("-c:a");
            args.add("aac");
        }
        args.add(destination);
        return args;
    }

    private void run(List<String> command) {
        try {
            Files.createDirectories(Path.of(command.get(command.size() - 1)).getParent());
            Process process = new ProcessBuilder(command).redirectErrorStream(true).start();
            boolean finished = process.waitFor(TIMEOUT_SECONDS, TimeUnit.SECONDS);
            if (!finished) {
                process.destroyForcibly();
                throw new BusinessException("ffmpeg timed out after " + TIMEOUT_SECONDS + " seconds");
            }
            if (process.exitValue() != 0) {
                throw new BusinessException("ffmpeg exited with code " + process.exitValue());
            }
        } catch (IOException e) {
            throw new BusinessException("Failed to run ffmpeg: " + e.getMessage());
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new BusinessException("ffmpeg process was interrupted");
        }
    }
}
