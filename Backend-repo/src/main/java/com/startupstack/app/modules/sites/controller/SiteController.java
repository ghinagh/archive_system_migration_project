package com.startupstack.app.modules.sites.controller;

import com.startupstack.app.modules.sites.dto.SiteRequest;
import com.startupstack.app.modules.sites.dto.SiteResponse;
import com.startupstack.app.modules.sites.service.SiteService;
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
@RequestMapping("/api/sites")
public class SiteController {

    private final SiteService siteService;

    public SiteController(SiteService siteService) {
        this.siteService = siteService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<SiteResponse>>> getAll(
            @RequestParam(required = false) String level,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Integer wilyaNo,
            @RequestParam(required = false) Boolean includeNames,
            @RequestParam(required = false) Boolean includeFormInfo,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                siteService.findAll(level, status, wilyaNo, includeNames, includeFormInfo, pageable)));
    }

    @GetMapping("/{siteNo}")
    public ResponseEntity<ApiResponse<SiteResponse>> getById(@PathVariable String siteNo) {
        return ResponseEntity.ok(ApiResponse.success(siteService.findById(siteNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<SiteResponse>> create(@Valid @RequestBody SiteRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(siteService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{siteNo}")
    public ResponseEntity<ApiResponse<SiteResponse>> update(
            @PathVariable String siteNo,
            @Valid @RequestBody SiteRequest request) {
        return ResponseEntity.ok(ApiResponse.success(siteService.update(siteNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{siteNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String siteNo) {
        siteService.delete(siteNo);
        return ResponseEntity.ok(ApiResponse.error("Site deleted successfully"));
    }
}
