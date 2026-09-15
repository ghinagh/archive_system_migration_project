package com.startupstack.app.modules.transactions.controller;

import com.startupstack.app.modules.transactions.dto.TransRequest;
import com.startupstack.app.modules.transactions.dto.TransResponse;
import com.startupstack.app.modules.transactions.service.TransService;
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
@RequestMapping("/api")
public class TransController {

    private final TransService transService;

    public TransController(TransService transService) {
        this.transService = transService;
    }

    @GetMapping("/transactions")
    public ResponseEntity<ApiResponse<Page<TransResponse>>> getAll(
            @RequestParam(required = false) Double periodicalId,
            @RequestParam(required = false) Double year,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(transService.findAll(periodicalId, year, pageable)));
    }

    @GetMapping("/transactions/{opno}/{no}")
    public ResponseEntity<ApiResponse<TransResponse>> getById(
            @PathVariable Double opno,
            @PathVariable Double no) {
        return ResponseEntity.ok(ApiResponse.success(transService.findById(opno, no)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/transactions")
    public ResponseEntity<ApiResponse<TransResponse>> create(@Valid @RequestBody TransRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(transService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/transactions/{opno}/{no}")
    public ResponseEntity<ApiResponse<TransResponse>> update(
            @PathVariable Double opno,
            @PathVariable Double no,
            @Valid @RequestBody TransRequest request) {
        return ResponseEntity.ok(ApiResponse.success(transService.update(opno, no, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/transactions/{opno}/{no}")
    public ResponseEntity<ApiResponse<Void>> delete(
            @PathVariable Double opno,
            @PathVariable Double no) {
        transService.delete(opno, no);
        return ResponseEntity.ok(ApiResponse.error("Transaction deleted successfully"));
    }

    @GetMapping("/periodicals/{periodicalId}/transactions")
    public ResponseEntity<ApiResponse<Page<TransResponse>>> getByPeriodical(
            @PathVariable Double periodicalId,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(transService.findByPeriodical(periodicalId, pageable)));
    }
}
