package com.startupstack.app.modules.catalogue.controller;

import com.startupstack.app.modules.catalogue.dto.TmpFileAddRequest;
import com.startupstack.app.modules.catalogue.dto.TmpFileAddResponse;
import com.startupstack.app.modules.catalogue.service.TmpFileAddService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/temp-files")
public class TmpFileAddController {

    private final TmpFileAddService tmpFileAddService;

    public TmpFileAddController(TmpFileAddService tmpFileAddService) {
        this.tmpFileAddService = tmpFileAddService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<TmpFileAddResponse>>> getAll(
            @RequestParam(required = false) String fadNo,
            @RequestParam(required = false) String userNo,
            @RequestParam(required = false) Integer finalStatus) {
        return ResponseEntity.ok(ApiResponse.success(
                tmpFileAddService.findAll(fadNo, userNo, finalStatus)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<TmpFileAddResponse>> create(
            @Valid @RequestBody TmpFileAddRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(tmpFileAddService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/{no}/{ser}/finalize")
    public ResponseEntity<ApiResponse<TmpFileAddResponse>> finalize(
            @PathVariable String no,
            @PathVariable Double ser) {
        return ResponseEntity.ok(ApiResponse.success(tmpFileAddService.finalize(no, ser)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{no}/{ser}")
    public ResponseEntity<ApiResponse<Void>> delete(
            @PathVariable String no,
            @PathVariable Double ser) {
        tmpFileAddService.delete(no, ser);
        return ResponseEntity.ok(ApiResponse.error("Temp file deleted successfully"));
    }
}
