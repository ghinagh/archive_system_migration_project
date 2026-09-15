package com.startupstack.app.modules.media.controller;

import com.startupstack.app.modules.media.dto.MediaResolveResponse;
import com.startupstack.app.shared.media.MediaService;
import com.startupstack.app.shared.media.StockTier;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.file.Files;

@RestController
@RequestMapping("/api/media")
public class MediaController {

    private final MediaService mediaService;

    public MediaController(MediaService mediaService) {
        this.mediaService = mediaService;
    }

    /**
     * @param tier which storage tier to resolve — LOW (the preview proxy) by default, matching
     *             the legacy player; HIGH for the broadcast master ffmpeg cuts from
     * @param ext  the record's own extension (DIGIT.DIG_TYP for LOW, DIG_TYP_HIGH for HIGH)
     */
    @GetMapping("/resolve/{stockNo}")
    public ResponseEntity<ApiResponse<MediaResolveResponse>> resolve(
            @PathVariable String stockNo,
            @RequestParam(required = false, defaultValue = "LOW") StockTier tier,
            @RequestParam(required = false) String ext) {
        String path = mediaService.resolveStockPath(stockNo, tier, ext);
        boolean exists = mediaService.fileExists(stockNo, tier, ext);
        return ResponseEntity.ok(ApiResponse.success(new MediaResolveResponse(path, exists)));
    }

    @GetMapping("/file/{stockNo}")
    public ResponseEntity<Resource> download(
            @PathVariable String stockNo,
            @RequestParam(required = false, defaultValue = "LOW") StockTier tier,
            @RequestParam(required = false) String ext) {
        Resource resource = mediaService.loadAsResource(stockNo, tier, ext);
        if (resource == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        String contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
        try {
            String detected = Files.probeContentType(resource.getFile().toPath());
            if (detected != null) {
                contentType = detected;
            }
        } catch (IOException ignored) {}

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }

    /**
     * Serves a non-video asset — a scan, photo, private document or audio wave — addressed by
     * its {@code DIGIT.DIG_DIG_NO} and routed by {@code DIG_TYP1}, reproducing legacy
     * datagrid1_DblClick's branch for those four classes. Video ({@code 04}) is not served
     * here; it goes through {@code /file/{stockNo}} against the tape volumes.
     *
     * <p>Served {@code inline} rather than as an attachment so the browser can render an image
     * or PDF in place, which is the web analogue of legacy's {@code OpenDoc} shell-out.
     */
    @GetMapping("/asset/{digitNo}")
    public ResponseEntity<Resource> asset(
            @PathVariable String digitNo,
            @RequestParam String type1,
            @RequestParam(required = false) String ext) {
        if (!mediaService.isNonVideoAssetClass(type1)) {
            return ResponseEntity.badRequest().build();
        }
        Resource resource = mediaService.loadAssetAsResource(digitNo, type1, ext);
        if (resource == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        String contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
        try {
            String detected = Files.probeContentType(resource.getFile().toPath());
            if (detected != null) {
                contentType = detected;
            }
        } catch (IOException ignored) {}

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "inline; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }
}
