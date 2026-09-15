package com.startupstack.app.modules.staff.controller;

import com.startupstack.app.modules.staff.dto.StaffRequest;
import com.startupstack.app.modules.staff.dto.StaffResponse;
import com.startupstack.app.modules.staff.service.StaffService;
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

@RestController
@RequestMapping("/api/staff")
public class StaffController {

    private final StaffService staffService;

    public StaffController(StaffService staffService) {
        this.staffService = staffService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<StaffResponse>>> getAll(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String entity,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(staffService.findAll(name, entity, pageable)));
    }

    @GetMapping("/{prsNo}")
    public ResponseEntity<ApiResponse<StaffResponse>> getById(@PathVariable String prsNo) {
        return ResponseEntity.ok(ApiResponse.success(staffService.findById(prsNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<StaffResponse>> create(@Valid @RequestBody StaffRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(staffService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{prsNo}")
    public ResponseEntity<ApiResponse<StaffResponse>> update(
            @PathVariable String prsNo,
            @Valid @RequestBody StaffRequest request) {
        return ResponseEntity.ok(ApiResponse.success(staffService.update(prsNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{prsNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String prsNo) {
        staffService.delete(prsNo);
        return ResponseEntity.ok(ApiResponse.error("Staff member deleted successfully"));
    }
}
