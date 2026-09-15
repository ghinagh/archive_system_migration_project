package com.startupstack.app.modules.sites.controller;

import com.startupstack.app.modules.sites.dto.PositionRequest;
import com.startupstack.app.modules.sites.dto.PositionResponse;
import com.startupstack.app.modules.sites.service.PositionService;
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
@RequestMapping("/api/positions")
public class PositionController {

    private final PositionService positionService;

    public PositionController(PositionService positionService) {
        this.positionService = positionService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<PositionResponse>>> getAll(
            @RequestParam(required = false) String name,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(positionService.findAll(name, pageable)));
    }

    /**
     * Positions attached to a form entry, keyed by {@code SUB_TYP || SUB_NO} — the migrated
     * form of legacy {@code proc_pos}, reached by F2 over the form lookup on the archive
     * search screen (USER_INTERFACE1.frm:5156-5168).
     */
    @GetMapping("/by-form/{formCode}")
    public ResponseEntity<ApiResponse<List<PositionResponse>>> getByFormCode(@PathVariable String formCode) {
        return ResponseEntity.ok(ApiResponse.success(positionService.findByFormCode(formCode)));
    }

    @GetMapping("/{posNo}")
    public ResponseEntity<ApiResponse<PositionResponse>> getById(@PathVariable String posNo) {
        return ResponseEntity.ok(ApiResponse.success(positionService.findById(posNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<PositionResponse>> create(@Valid @RequestBody PositionRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(positionService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{posNo}")
    public ResponseEntity<ApiResponse<PositionResponse>> update(
            @PathVariable String posNo,
            @Valid @RequestBody PositionRequest request) {
        return ResponseEntity.ok(ApiResponse.success(positionService.update(posNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{posNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String posNo) {
        positionService.delete(posNo);
        return ResponseEntity.ok(ApiResponse.error("Position deleted successfully"));
    }
}
