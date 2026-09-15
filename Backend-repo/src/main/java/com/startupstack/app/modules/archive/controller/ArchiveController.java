package com.startupstack.app.modules.archive.controller;

import com.startupstack.app.modules.archive.dto.BatchChartRequest;
import com.startupstack.app.modules.archive.dto.ChartOperationRequest;
import com.startupstack.app.modules.archive.dto.ChartOperationResponse;
import com.startupstack.app.modules.archive.dto.ChartRequest;
import com.startupstack.app.modules.archive.dto.ChartResponse;
import com.startupstack.app.modules.archive.service.ArchiveService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/archive/charts")
public class ArchiveController {

    private final ArchiveService archiveService;

    public ArchiveController(ArchiveService archiveService) {
        this.archiveService = archiveService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<ChartResponse>>> getAllCharts(
            @RequestParam(required = false) String title,
            @RequestParam(required = false) String source,
            @RequestParam(required = false) Double type,
            @RequestParam(required = false) String subjectCode,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                archiveService.findAllCharts(title, source, type, subjectCode, pageable)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<ChartResponse>> getChartById(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.success(archiveService.findChartById(id)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<ChartResponse>> createChart(@Valid @RequestBody ChartRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(archiveService.createChart(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<ChartResponse>> updateChart(
            @PathVariable Integer id,
            @Valid @RequestBody ChartRequest request) {
        return ResponseEntity.ok(ApiResponse.success(archiveService.updateChart(id, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteChart(@PathVariable Integer id) {
        archiveService.deleteChart(id);
        return ResponseEntity.ok(ApiResponse.error("Chart deleted successfully"));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/batch")
    public ResponseEntity<ApiResponse<List<String>>> createBatch(@Valid @RequestBody BatchChartRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(archiveService.createBatch(request)));
    }

    @GetMapping("/{id}/operations")
    public ResponseEntity<ApiResponse<Page<ChartOperationResponse>>> getOperations(
            @PathVariable Integer id,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(archiveService.findOperationsByChart(id, pageable)));
    }

    @GetMapping("/{id}/operations/{operationId}")
    public ResponseEntity<ApiResponse<ChartOperationResponse>> getOperation(
            @PathVariable Integer id,
            @PathVariable Integer operationId) {
        return ResponseEntity.ok(ApiResponse.success(archiveService.findOperationById(id, operationId)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{id}/operations")
    public ResponseEntity<ApiResponse<ChartOperationResponse>> createOperation(
            @PathVariable Integer id,
            @Valid @RequestBody ChartOperationRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(archiveService.createOperation(id, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{id}/operations/{operationId}")
    public ResponseEntity<ApiResponse<ChartOperationResponse>> updateOperation(
            @PathVariable Integer id,
            @PathVariable Integer operationId,
            @Valid @RequestBody ChartOperationRequest request) {
        return ResponseEntity.ok(ApiResponse.success(archiveService.updateOperation(id, operationId, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{id}/operations/{operationId}")
    public ResponseEntity<ApiResponse<Void>> deleteOperation(
            @PathVariable Integer id,
            @PathVariable Integer operationId) {
        archiveService.deleteOperation(id, operationId);
        return ResponseEntity.ok(ApiResponse.error("Operation deleted successfully"));
    }
}
