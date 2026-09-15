package com.startupstack.app.modules.requests.controller;

import com.startupstack.app.modules.requests.dto.UsageRequestRequest;
import com.startupstack.app.modules.requests.dto.UsageRequestResponse;
import com.startupstack.app.modules.requests.dto.UsageRequestStatusRequest;
import com.startupstack.app.modules.requests.service.UsageRequestService;
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
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/api/usage-requests")
public class UsageRequestController {

    private final UsageRequestService usageRequestService;

    public UsageRequestController(UsageRequestService usageRequestService) {
        this.usageRequestService = usageRequestService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<UsageRequestResponse>>> getAll(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String requester,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(usageRequestService.findAll(status, requester, pageable)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<UsageRequestResponse>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(usageRequestService.findById(id)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<UsageRequestResponse>> create(@Valid @RequestBody UsageRequestRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(usageRequestService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<UsageRequestResponse>> update(
            @PathVariable UUID id,
            @Valid @RequestBody UsageRequestRequest request) {
        return ResponseEntity.ok(ApiResponse.success(usageRequestService.update(id, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        usageRequestService.delete(id);
        return ResponseEntity.ok(ApiResponse.error("Usage request deleted successfully"));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/{id}/status")
    public ResponseEntity<ApiResponse<UsageRequestResponse>> updateStatus(
            @PathVariable UUID id,
            @Valid @RequestBody UsageRequestStatusRequest request) {
        return ResponseEntity.ok(ApiResponse.success(usageRequestService.updateStatus(id, request.getStatus())));
    }
}
