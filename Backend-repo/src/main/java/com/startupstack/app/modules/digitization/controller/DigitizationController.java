package com.startupstack.app.modules.digitization.controller;

import com.startupstack.app.modules.digitization.dto.AddSceneRequest;
import com.startupstack.app.modules.digitization.dto.DemandBulkFulfilRequest;
import com.startupstack.app.modules.digitization.dto.DemandBulkStatusRequest;
import com.startupstack.app.modules.digitization.dto.DemandFulfilRequest;
import com.startupstack.app.modules.digitization.dto.DemandPathRequest;
import com.startupstack.app.modules.digitization.dto.DemandRequest;
import com.startupstack.app.modules.digitization.dto.DemandResponse;
import com.startupstack.app.modules.digitization.dto.DemandStatsResponse;
import com.startupstack.app.modules.digitization.dto.DemandTestRequest;
import com.startupstack.app.modules.digitization.dto.DemandTestResult;
import com.startupstack.app.modules.digitization.dto.DeliveryJobRequest;
import com.startupstack.app.modules.digitization.dto.DeliveryJobStatus;
import com.startupstack.app.modules.digitization.dto.DigitRequest;
import com.startupstack.app.modules.digitization.dto.DigitResponse;
import com.startupstack.app.modules.digitization.dto.LogUsageRequestBatch;
import com.startupstack.app.modules.digitization.dto.ManageResultRequest;
import com.startupstack.app.modules.digitization.dto.ResultRequest;
import com.startupstack.app.modules.digitization.dto.ResultResponse;
import com.startupstack.app.modules.digitization.service.DigitizationService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.format.annotation.DateTimeFormat;
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

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/digitization")
public class DigitizationController {

    private final DigitizationService digitizationService;

    public DigitizationController(DigitizationService digitizationService) {
        this.digitizationService = digitizationService;
    }

    @GetMapping("/records")
    public ResponseEntity<ApiResponse<Page<DigitResponse>>> getAllRecords(
            @RequestParam(required = false) String docNo,
            @RequestParam(required = false) String type,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.findAllRecords(docNo, type, pageable)));
    }

    @GetMapping("/records/lookup")
    public ResponseEntity<ApiResponse<DigitResponse>> getRecordById(
            @RequestParam String docNo,
            @RequestParam Integer serial) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.findRecordById(docNo, serial)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/records")
    public ResponseEntity<ApiResponse<DigitResponse>> createRecord(
            @Valid @RequestBody DigitRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(digitizationService.createRecord(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/records")
    public ResponseEntity<ApiResponse<DigitResponse>> updateRecord(
            @RequestParam String docNo,
            @RequestParam Integer serial,
            @Valid @RequestBody DigitRequest request) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.updateRecord(docNo, serial, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/records")
    public ResponseEntity<ApiResponse<Void>> deleteRecord(
            @RequestParam String docNo,
            @RequestParam Integer serial) {
        digitizationService.deleteRecord(docNo, serial);
        return ResponseEntity.ok(ApiResponse.error("Digit record deleted successfully"));
    }

    @GetMapping("/demands")
    public ResponseEntity<ApiResponse<Page<DemandResponse>>> getAllDemands(
            @RequestParam(required = false) String userNo,
            @RequestParam(required = false) String machineNo,
            @RequestParam(required = false) String demandNo,
            @RequestParam(required = false) String machineStock,
            @RequestParam(required = false) Boolean fulfilled,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTo,
            @RequestParam(required = false) String search,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.findAllDemands(
                userNo, machineNo, demandNo, machineStock, fulfilled, dateFrom, dateTo, search, pageable)));
    }

    @GetMapping("/demands/stats")
    public ResponseEntity<ApiResponse<DemandStatsResponse>> getDemandStats(
            @RequestParam(required = false) String userNo,
            @RequestParam(required = false) String machineNo,
            @RequestParam(required = false) String demandNo,
            @RequestParam(required = false) String machineStock,
            @RequestParam(required = false) Boolean fulfilled,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTo,
            @RequestParam(required = false) String search) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.getDemandStats(
                userNo, machineNo, demandNo, machineStock, fulfilled, dateFrom, dateTo, search)));
    }

    @GetMapping("/demands/{id}")
    public ResponseEntity<ApiResponse<DemandResponse>> getDemandById(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.findDemandById(id)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/demands")
    public ResponseEntity<ApiResponse<DemandResponse>> createDemand(
            @Valid @RequestBody DemandRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(digitizationService.createDemand(request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/demands/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteDemand(@PathVariable Integer id) {
        digitizationService.deleteDemand(id);
        return ResponseEntity.ok(ApiResponse.error("Demand deleted successfully"));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/demands/scenes")
    public ResponseEntity<ApiResponse<DemandResponse>> addScene(
            @Valid @RequestBody AddSceneRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(digitizationService.addScene(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/demands/{id}/path")
    public ResponseEntity<ApiResponse<DemandResponse>> reassignPath(
            @PathVariable Integer id,
            @Valid @RequestBody DemandPathRequest request) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.reassignPath(id, request.getPath())));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/demands/bulk-status")
    public ResponseEntity<ApiResponse<Void>> bulkSetFulfilled(
            @Valid @RequestBody DemandBulkStatusRequest request) {
        // `checked` carries the raw legacy dmd_chek value and wins when present, so the
        // archive-search cockpit can write the de-selected state (0) that `fulfilled` cannot.
        if (request.getChecked() != null) {
            digitizationService.bulkSetChecked(request.getIds(), request.getChecked());
        } else if (request.getFulfilled() != null) {
            digitizationService.bulkSetFulfilled(request.getIds(), request.getFulfilled());
        } else {
            throw new BusinessException("Either 'checked' or 'fulfilled' must be supplied");
        }
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PostMapping("/demands/{id}/fulfil")
    public ResponseEntity<ApiResponse<DemandResponse>> fulfilDemand(
            @PathVariable Integer id,
            @Valid @RequestBody(required = false) DemandFulfilRequest request) {
        String mechanism = request == null ? "COPY" : request.getMechanism();
        return ResponseEntity.ok(ApiResponse.success(digitizationService.fulfilDemand(id, mechanism)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PostMapping("/demands/bulk-fulfil")
    public ResponseEntity<ApiResponse<Void>> bulkFulfil(
            @Valid @RequestBody DemandBulkFulfilRequest request) {
        digitizationService.bulkFulfil(request.getIds(), request.getMechanism(), request.isMergeClip());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PostMapping("/demands/test")
    public ResponseEntity<ApiResponse<List<DemandTestResult>>> testDemands(
            @Valid @RequestBody DemandTestRequest request) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.testDemands(request.getIds())));
    }

    /**
     * Legacy Command5 "ارسل الى EDLC" — DV PAL transcode, poster frame, status write-back and
     * the external hand-off, over every queued row in the selection.
     *
     * <p>Returns a job handle rather than the finished result: legacy blocked its window on
     * {@code WaitForSingleObject(..., INFINITE)} for the length of the transcode, which an
     * HTTP request cannot do. Poll {@code /demands/jobs/{jobId}} for progress and outcome.
     */
    @Permission(PermissionConstants.PERM_UPDATE)
    @PostMapping("/demands/send-to-edlc")
    public ResponseEntity<ApiResponse<DeliveryJobStatus>> sendToEdlc(
            @Valid @RequestBody DeliveryJobRequest request) {
        return ResponseEntity.accepted()
                .body(ApiResponse.success(digitizationService.startSendToEdlc(request.getIds())));
    }

    /** Legacy Command14 "تنفيد" — stream-copy each queued clip. Same job/polling shape as above. */
    @Permission(PermissionConstants.PERM_UPDATE)
    @PostMapping("/demands/extract-clips")
    public ResponseEntity<ApiResponse<DeliveryJobStatus>> extractClips(
            @Valid @RequestBody DeliveryJobRequest request) {
        return ResponseEntity.accepted()
                .body(ApiResponse.success(digitizationService.startExtractClips(request.getIds())));
    }

    /** Progress and outcome of a delivery batch — drives the queue's progress indicator. */
    @GetMapping("/demands/jobs/{jobId}")
    public ResponseEntity<ApiResponse<DeliveryJobStatus>> getDeliveryJob(@PathVariable String jobId) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.getDeliveryJob(jobId)));
    }

    @GetMapping("/results")
    public ResponseEntity<ApiResponse<Page<ResultResponse>>> getAllResults(
            @RequestParam(required = false) String digitNo,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String type1,
            @RequestParam(required = false) String resultNo,
            @RequestParam(required = false) String person,
            @RequestParam(required = false) String cote,
            @RequestParam(required = false) String permit,
            @RequestParam(required = false) String subject,
            @RequestParam(required = false) String title,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTo,
            // legacy: "... order by RES_dte" (tmp_dmd_result, f_result.frm Command1_Click) — no
            // explicit direction in the legacy SQL means ascending.
            @PageableDefault(sort = "date", direction = Sort.Direction.ASC) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.findAllResults(
                digitNo, type, type1, resultNo, person, cote, permit, subject, title, dateFrom, dateTo, pageable)));
    }

    @GetMapping("/results/{id}")
    public ResponseEntity<ApiResponse<ResultResponse>> getResultById(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.findResultById(id)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/results")
    public ResponseEntity<ApiResponse<ResultResponse>> createResult(
            @Valid @RequestBody ResultRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(digitizationService.createResult(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/results/{id}")
    public ResponseEntity<ApiResponse<ResultResponse>> updateResult(
            @PathVariable Integer id,
            @Valid @RequestBody ResultRequest request) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.updateResult(id, request)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/results/log-usage")
    public ResponseEntity<ApiResponse<List<ResultResponse>>> logUsageRequest(
            @Valid @RequestBody LogUsageRequestBatch request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(digitizationService.logUsageRequest(request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/results/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteResult(@PathVariable Integer id) {
        digitizationService.deleteResult(id);
        return ResponseEntity.ok(ApiResponse.error("Result deleted successfully"));
    }

    /** "معالجة طلبات معينة" Frame2 تعديل (Command9) — legacy upd_result1 keys on رقم الطلب
     *  (res_no), not a single row's id; updates every row sharing that request number. */
    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/results/by-number/{resultNo}")
    public ResponseEntity<ApiResponse<List<ResultResponse>>> updateResultByResultNo(
            @PathVariable String resultNo,
            @RequestBody ManageResultRequest request) {
        return ResponseEntity.ok(ApiResponse.success(digitizationService.updateResultByResultNo(resultNo, request)));
    }

    /** "معالجة طلبات معينة" Frame2 الغاء الطلب (Command6) — legacy del_result keys on رقم
     *  الطلب (res_no); deletes every row sharing it. */
    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/results/by-number/{resultNo}")
    public ResponseEntity<ApiResponse<Void>> deleteResultByResultNo(@PathVariable String resultNo) {
        digitizationService.deleteResultByResultNo(resultNo);
        return ResponseEntity.ok(ApiResponse.error("Result deleted successfully"));
    }
}
