package com.startupstack.app.modules.admin.controller;

import com.startupstack.app.modules.admin.dto.BackupResponse;
import com.startupstack.app.modules.admin.dto.MediaRangeRequest;
import com.startupstack.app.modules.admin.dto.MediaRangeResponse;
import com.startupstack.app.modules.admin.dto.TempSchemaRequest;
import com.startupstack.app.modules.admin.dto.TempSchemaResponse;
import com.startupstack.app.modules.admin.service.AdminService;
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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    // --- Temp schema ---

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping("/temp-schema")
    public ResponseEntity<ApiResponse<List<TempSchemaResponse>>> getTempSchema() {
        return ResponseEntity.ok(ApiResponse.success(adminService.getAllTempSchema()));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping("/temp-schema")
    public ResponseEntity<ApiResponse<TempSchemaResponse>> createTempSchema(
            @Valid @RequestBody TempSchemaRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(adminService.createTempSchema(request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @DeleteMapping("/temp-schema/{fieldName}")
    public ResponseEntity<ApiResponse<Void>> deleteTempSchema(@PathVariable String fieldName) {
        adminService.deleteTempSchema(fieldName);
        return ResponseEntity.ok(ApiResponse.error("Temp schema field deleted successfully"));
    }

    // --- Media ranges ---

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping("/media-ranges")
    public ResponseEntity<ApiResponse<List<MediaRangeResponse>>> getMediaRanges() {
        return ResponseEntity.ok(ApiResponse.success(adminService.getAllMediaRanges()));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping("/media-ranges")
    public ResponseEntity<ApiResponse<MediaRangeResponse>> createMediaRange(
            @Valid @RequestBody MediaRangeRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(adminService.createMediaRange(request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @PutMapping("/media-ranges/{id}")
    public ResponseEntity<ApiResponse<MediaRangeResponse>> updateMediaRange(
            @PathVariable Integer id,
            @Valid @RequestBody MediaRangeRequest request) {
        return ResponseEntity.ok(ApiResponse.success(adminService.updateMediaRange(id, request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @DeleteMapping("/media-ranges/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteMediaRange(@PathVariable Integer id) {
        adminService.deleteMediaRange(id);
        return ResponseEntity.ok(ApiResponse.error("Media range deleted successfully"));
    }

    // --- Database backup ---

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping("/backup")
    public ResponseEntity<ApiResponse<BackupResponse>> createBackup() {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(adminService.createBackup()));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping("/backup")
    public ResponseEntity<ApiResponse<List<BackupResponse>>> listBackups() {
        return ResponseEntity.ok(ApiResponse.success(adminService.listBackups()));
    }
}
