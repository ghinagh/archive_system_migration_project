package com.startupstack.app.modules.paysform.controller;

import com.startupstack.app.modules.paysform.dto.PaysFormResponse;
import com.startupstack.app.modules.paysform.service.PaysFormService;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Legacy PERIOD1.frm مكان الصدور 1/2 (PER_GEO1/PER_GEO) DBCombo lookup source
 * ("select * from pays_form order by sub_name", ListField=SUB_NAME, BoundColumn=SUB_NO).
 * Read-only: rows are populated directly in the pays_form table, not through this API.
 */
@RestController
@RequestMapping("/api/pays-form")
public class PaysFormController {

    private final PaysFormService paysFormService;

    public PaysFormController(PaysFormService paysFormService) {
        this.paysFormService = paysFormService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<PaysFormResponse>>> getAll(
            @RequestParam(required = false) String name,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(paysFormService.findAll(name, pageable)));
    }

    @GetMapping("/{formNo}")
    public ResponseEntity<ApiResponse<PaysFormResponse>> getById(@PathVariable String formNo) {
        return ResponseEntity.ok(ApiResponse.success(paysFormService.findById(formNo)));
    }
}
