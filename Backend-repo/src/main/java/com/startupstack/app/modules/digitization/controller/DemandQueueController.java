package com.startupstack.app.modules.digitization.controller;

import com.startupstack.app.modules.digitization.dto.DeliveryJobStatus;
import com.startupstack.app.modules.digitization.dto.DemandQueueCheckRequest;
import com.startupstack.app.modules.digitization.dto.DemandQueueContext;
import com.startupstack.app.modules.digitization.dto.DemandQueuePathRequest;
import com.startupstack.app.modules.digitization.dto.DemandQueueProcessRequest;
import com.startupstack.app.modules.digitization.dto.DemandQueueUser;
import com.startupstack.app.modules.digitization.dto.DemandResponse;
import com.startupstack.app.modules.digitization.service.DemandQueueService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

/** "طلبيات الفيديو" order queue — new_vdpreview.frm. Job progress is polled on /demands/jobs/{id}. */
@RestController
@RequestMapping("/api/digitization/demand-queue")
public class DemandQueueController {

    private final DemandQueueService demandQueueService;

    public DemandQueueController(DemandQueueService demandQueueService) {
        this.demandQueueService = demandQueueService;
    }

    @GetMapping("/context")
    public ResponseEntity<ApiResponse<DemandQueueContext>> context() {
        return ResponseEntity.ok(ApiResponse.success(demandQueueService.context()));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<DemandResponse>>> search(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateTo,
            @RequestParam(defaultValue = "false") boolean done,
            @RequestParam(defaultValue = "false") boolean notDone,
            @RequestParam(required = false) String text,
            @RequestParam(required = false) String demandNo,
            @RequestParam(required = false) String userNo,
            @RequestParam(required = false) String stock) {
        return ResponseEntity.ok(ApiResponse.success(
                demandQueueService.search(dateFrom, dateTo, done, notDone, text, demandNo, userNo, stock)));
    }

    @GetMapping("/users")
    public ResponseEntity<ApiResponse<List<DemandQueueUser>>> users(@RequestParam(required = false) String prefix) {
        return ResponseEntity.ok(ApiResponse.success(demandQueueService.users(prefix)));
    }

    @GetMapping("/path-options")
    public ResponseEntity<ApiResponse<List<String>>> pathOptions() {
        return ResponseEntity.ok(ApiResponse.success(demandQueueService.pathOptions()));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/checked")
    public ResponseEntity<ApiResponse<Void>> setChecked(@Valid @RequestBody DemandQueueCheckRequest request) {
        demandQueueService.setChecked(request.getIds(), request.getChecked());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/path")
    public ResponseEntity<ApiResponse<Void>> assignPath(@Valid @RequestBody DemandQueuePathRequest request) {
        demandQueueService.assignPath(request.getIds(), request.getBasePath());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PostMapping("/process")
    public ResponseEntity<ApiResponse<DeliveryJobStatus>> process(@Valid @RequestBody DemandQueueProcessRequest request) {
        return ResponseEntity.accepted().body(ApiResponse.success(demandQueueService.process(request)));
    }
}
