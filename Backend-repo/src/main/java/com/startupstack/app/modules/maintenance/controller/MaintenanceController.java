package com.startupstack.app.modules.maintenance.controller;

import com.startupstack.app.modules.maintenance.dto.CopyToArchiveRequest;
import com.startupstack.app.modules.maintenance.dto.CopyToArchiveResponse;
import com.startupstack.app.modules.maintenance.dto.FileLinkRequest;
import com.startupstack.app.modules.maintenance.dto.FileLinkResponse;
import com.startupstack.app.modules.maintenance.dto.RenumberRequest;
import com.startupstack.app.modules.maintenance.service.MaintenanceService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

/**
 * Admin-only data-maintenance utilities migrated from the legacy VB6
 * {@code correct.frm} / {@code corect1.frm} screens. Bundles three unrelated
 * sub-resources under one controller, mirroring {@code AdminController}'s
 * temp-schema + media-ranges bundling pattern.
 */
@RestController
@RequestMapping("/api/maintenance")
public class MaintenanceController {

    private final MaintenanceService maintenanceService;

    public MaintenanceController(MaintenanceService maintenanceService) {
        this.maintenanceService = maintenanceService;
    }

    // --- 1. Renumber a catalogue record's app number ---

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping("/renumber")
    public ResponseEntity<ApiResponse<Void>> renumber(@Valid @RequestBody RenumberRequest request) {
        maintenanceService.renumberAppNo(request);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // --- 2. Copy a media file into the archive ---

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping("/copy-to-archive")
    public ResponseEntity<ApiResponse<CopyToArchiveResponse>> copyToArchive(
            @Valid @RequestBody CopyToArchiveRequest request) {
        return ResponseEntity.ok(ApiResponse.success(maintenanceService.copyToArchive(request)));
    }

    // --- 3. Link a file to a catalogue record ---

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping("/file-links")
    public ResponseEntity<ApiResponse<FileLinkResponse>> linkFile(@Valid @RequestBody FileLinkRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(maintenanceService.linkFile(request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping("/file-links/{appNo}")
    public ResponseEntity<ApiResponse<List<FileLinkResponse>>> getFileLinks(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(maintenanceService.getLinksForAppNo(appNo)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @DeleteMapping("/file-links/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteFileLink(@PathVariable UUID id) {
        maintenanceService.deleteLink(id);
        return ResponseEntity.ok(ApiResponse.error("File link deleted successfully"));
    }
}
