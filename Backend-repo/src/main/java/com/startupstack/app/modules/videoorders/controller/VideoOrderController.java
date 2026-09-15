package com.startupstack.app.modules.videoorders.controller;

import com.startupstack.app.modules.videoorders.dto.VideoOrderRequest;
import com.startupstack.app.modules.videoorders.dto.VideoOrderResponse;
import com.startupstack.app.modules.videoorders.dto.VideoOrderStatusRequest;
import com.startupstack.app.modules.videoorders.service.VideoOrderService;
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
@RequestMapping("/api/video-orders")
public class VideoOrderController {

    private final VideoOrderService videoOrderService;

    public VideoOrderController(VideoOrderService videoOrderService) {
        this.videoOrderService = videoOrderService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<VideoOrderResponse>>> getAll(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String stockNo,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(videoOrderService.findAll(status, stockNo, pageable)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<VideoOrderResponse>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(videoOrderService.findById(id)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<VideoOrderResponse>> create(@Valid @RequestBody VideoOrderRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(videoOrderService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<VideoOrderResponse>> update(
            @PathVariable UUID id,
            @Valid @RequestBody VideoOrderRequest request) {
        return ResponseEntity.ok(ApiResponse.success(videoOrderService.update(id, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        videoOrderService.delete(id);
        return ResponseEntity.ok(ApiResponse.error("Video order deleted successfully"));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/{id}/status")
    public ResponseEntity<ApiResponse<VideoOrderResponse>> updateStatus(
            @PathVariable UUID id,
            @Valid @RequestBody VideoOrderStatusRequest request) {
        return ResponseEntity.ok(ApiResponse.success(videoOrderService.updateStatus(id, request.getStatus())));
    }
}
