package com.startupstack.app.modules.catalogue.controller;

import com.startupstack.app.modules.catalogue.dto.Main2Request;
import com.startupstack.app.modules.catalogue.dto.Main2Response;
import com.startupstack.app.modules.catalogue.service.Main2Service;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/catalogue")
public class Main2Controller {

    private final Main2Service main2Service;

    public Main2Controller(Main2Service main2Service) {
        this.main2Service = main2Service;
    }

    @GetMapping("/extended")
    public ResponseEntity<ApiResponse<Page<Main2Response>>> getAll(Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(main2Service.findAll(pageable)));
    }

    @GetMapping("/{appNo}/extended")
    public ResponseEntity<ApiResponse<Main2Response>> getById(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(main2Service.findById(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{appNo}/extended")
    public ResponseEntity<ApiResponse<Main2Response>> create(
            @PathVariable String appNo,
            @Valid @RequestBody Main2Request request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(main2Service.create(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{appNo}/extended")
    public ResponseEntity<ApiResponse<Main2Response>> update(
            @PathVariable String appNo,
            @Valid @RequestBody Main2Request request) {
        return ResponseEntity.ok(ApiResponse.success(main2Service.update(appNo, request)));
    }
}
