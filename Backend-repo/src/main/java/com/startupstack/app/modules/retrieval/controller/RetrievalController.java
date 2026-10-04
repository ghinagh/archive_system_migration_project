package com.startupstack.app.modules.retrieval.controller;

import com.startupstack.app.modules.retrieval.dto.RetrievalCodeOption;
import com.startupstack.app.modules.retrieval.dto.RetrievalFieldOption;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchRequest;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchResponse;
import com.startupstack.app.modules.retrieval.dto.RetrievalUserFieldState;
import com.startupstack.app.modules.retrieval.service.RetrievalScope;
import com.startupstack.app.modules.retrieval.service.RetrievalService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * The three legacy sort_form retrieval screens — "الاسترجاع البياني لبنك المعلومات" (scope=BANK, the
 * default), "استرجاع الملفات الاضافية" (scope=ADDITIONAL_FILES) and "استـرجـاع الصحف والمجلات"
 * (scope=PERIODICALS); see {@link RetrievalScope}. Migrated
 * equivalent of the legacy sort_from.frm query builder and its frm_result hand-off.
 */
@RestController
@RequestMapping("/api/retrieval")
public class RetrievalController {

    private final RetrievalService service;

    public RetrievalController(RetrievalService service) {
        this.service = service;
    }

    @Permission(PermissionConstants.PERM_VIEW)
    @GetMapping("/fields")
    public ResponseEntity<ApiResponse<List<RetrievalFieldOption>>> listFields(@RequestParam(defaultValue = "BANK") RetrievalScope scope) {
        return ResponseEntity.ok(ApiResponse.success(service.listFields(scope)));
    }

    @Permission(PermissionConstants.PERM_VIEW)
    @GetMapping("/lookup-values")
    public ResponseEntity<ApiResponse<List<String>>> lookupValues(
            @RequestParam(defaultValue = "BANK") RetrievalScope scope,
            @RequestParam String fieldKey,
            @RequestParam(required = false) String term) {
        return ResponseEntity.ok(ApiResponse.success(service.lookupValues(scope, fieldKey, term)));
    }

    /** Legacy c_getcond for a coded condition — names with the code each one resolves to. */
    @Permission(PermissionConstants.PERM_VIEW)
    @GetMapping("/lookup-codes")
    public ResponseEntity<ApiResponse<List<RetrievalCodeOption>>> lookupCodes(
            @RequestParam(defaultValue = "BANK") RetrievalScope scope,
            @RequestParam String fieldKey,
            @RequestParam(required = false) String term) {
        return ResponseEntity.ok(ApiResponse.success(service.lookupCodes(scope, fieldKey, term)));
    }

    @Permission(PermissionConstants.PERM_VIEW)
    @PostMapping("/search")
    public ResponseEntity<ApiResponse<RetrievalSearchResponse>> search(
            @RequestParam(defaultValue = "BANK") RetrievalScope scope,
            @Valid @RequestBody RetrievalSearchRequest request) {
        return ResponseEntity.ok(ApiResponse.success(service.search(scope, request)));
    }

    /** Legacy sort_from.frm Form_Load's BNKOUT2 query — this user's persisted display/order marks. */
    @Permission(PermissionConstants.PERM_VIEW)
    @GetMapping("/my-field-state")
    public ResponseEntity<ApiResponse<List<RetrievalUserFieldState>>> myFieldState(@RequestParam(defaultValue = "BANK") RetrievalScope scope) {
        return ResponseEntity.ok(ApiResponse.success(service.myFieldState(scope)));
    }

    /** Legacy DBList2_DblClick. */
    @Permission(PermissionConstants.PERM_VIEW)
    @PostMapping("/my-field-state/{fieldKey}/toggle-display")
    public ResponseEntity<ApiResponse<RetrievalUserFieldState>> toggleDisplay(
            @RequestParam(defaultValue = "BANK") RetrievalScope scope, @PathVariable String fieldKey) {
        return ResponseEntity.ok(ApiResponse.success(service.toggleDisplay(scope, fieldKey)));
    }

    /** Legacy DBList2_KeyDown (F10). */
    @Permission(PermissionConstants.PERM_VIEW)
    @PostMapping("/my-field-state/{fieldKey}/toggle-order")
    public ResponseEntity<ApiResponse<RetrievalUserFieldState>> toggleOrder(
            @RequestParam(defaultValue = "BANK") RetrievalScope scope, @PathVariable String fieldKey) {
        return ResponseEntity.ok(ApiResponse.success(service.toggleOrder(scope, fieldKey)));
    }

    /** Legacy Command3_Click ("تعليم حقول العرض"). */
    @Permission(PermissionConstants.PERM_VIEW)
    @PostMapping("/my-field-state/mark-category")
    public ResponseEntity<ApiResponse<List<RetrievalUserFieldState>>> markCategoryForDisplay(
            @RequestParam(defaultValue = "BANK") RetrievalScope scope,
            @RequestParam String category) {
        return ResponseEntity.ok(ApiResponse.success(service.markCategoryForDisplay(scope, category)));
    }

    /** Legacy DBList2_77 (F2) — global per-field "#" marker, not per-user. */
    @Permission(PermissionConstants.PERM_VIEW)
    @PostMapping("/fields/{fieldKey}/toggle-hash-mark")
    public ResponseEntity<ApiResponse<RetrievalFieldOption>> toggleHashMark(
            @RequestParam(defaultValue = "BANK") RetrievalScope scope, @PathVariable String fieldKey) {
        return ResponseEntity.ok(ApiResponse.success(service.toggleHashMark(scope, fieldKey)));
    }
}
