package com.startupstack.app.modules.retrieval.controller;

import com.startupstack.app.modules.retrieval.dto.RetrievalFieldOption;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchRequest;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchResponse;
import com.startupstack.app.modules.retrieval.service.RetrievalService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * The graphical retrieval screen (استمارة الاسترجاع البياني لبنك المعلومات) — migrated
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
    public ResponseEntity<ApiResponse<List<RetrievalFieldOption>>> listFields() {
        return ResponseEntity.ok(ApiResponse.success(service.listFields()));
    }

    @Permission(PermissionConstants.PERM_VIEW)
    @GetMapping("/lookup-values")
    public ResponseEntity<ApiResponse<List<String>>> lookupValues(
            @RequestParam String fieldKey,
            @RequestParam(required = false) String term) {
        return ResponseEntity.ok(ApiResponse.success(service.lookupValues(fieldKey, term)));
    }

    @Permission(PermissionConstants.PERM_VIEW)
    @PostMapping("/search")
    public ResponseEntity<ApiResponse<RetrievalSearchResponse>> search(
            @Valid @RequestBody RetrievalSearchRequest request) {
        return ResponseEntity.ok(ApiResponse.success(service.search(request)));
    }
}
