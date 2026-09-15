package com.startupstack.app.modules.retrievalfields.controller;

import com.startupstack.app.modules.retrievalfields.dto.RetrievalFieldRequest;
import com.startupstack.app.modules.retrievalfields.dto.RetrievalFieldResponse;
import com.startupstack.app.modules.retrievalfields.service.RetrievalFieldService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

/**
 * Admin CRUD for retrieval fields — migrated equivalent of the legacy
 * "retrieval field builder / management" menu items. Entries created here
 * are merged additively into each domain's advanced-search allowlist.
 */
@RestController
@RequestMapping("/api/retrieval-fields")
public class RetrievalFieldController {

    private final RetrievalFieldService service;

    public RetrievalFieldController(RetrievalFieldService service) {
        this.service = service;
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping
    public ResponseEntity<ApiResponse<List<RetrievalFieldResponse>>> getAll(
            @RequestParam(required = false) String module) {
        return ResponseEntity.ok(ApiResponse.success(service.getAll(module)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping
    public ResponseEntity<ApiResponse<RetrievalFieldResponse>> create(
            @Valid @RequestBody RetrievalFieldRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(service.create(request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<RetrievalFieldResponse>> update(
            @PathVariable UUID id,
            @Valid @RequestBody RetrievalFieldRequest request) {
        return ResponseEntity.ok(ApiResponse.success(service.update(id, request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.ok(ApiResponse.error("Retrieval field deleted successfully"));
    }
}
