package com.startupstack.app.modules.catalogue.controller;

import com.startupstack.app.modules.catalogue.dto.AbstractRequest;
import com.startupstack.app.modules.catalogue.dto.AnalysisTextRequest;
import com.startupstack.app.modules.catalogue.dto.AnalysisTextResponse;
import com.startupstack.app.modules.catalogue.service.AnalysisPageService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/** Form2.frm (التحليل): the descriptor/relation text and the document abstract. */
@RestController
@RequestMapping("/api/catalogue/{appNo}")
public class AnalysisPageController {

    private final AnalysisPageService service;

    public AnalysisPageController(AnalysisPageService service) {
        this.service = service;
    }

    @GetMapping("/analysis-text")
    public ResponseEntity<ApiResponse<AnalysisTextResponse>> getText(
            @PathVariable String appNo, @RequestParam String serNo, @RequestParam String relNo) {
        return ResponseEntity.ok(ApiResponse.success(service.getText(appNo, serNo, relNo)));
    }

    /** frm_result F5 (serh_text5): the whole text of the document. */
    @GetMapping("/analysis-text/all")
    public ResponseEntity<ApiResponse<AnalysisTextResponse>> getAllText(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(service.getAllText(appNo)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/analysis-text")
    public ResponseEntity<ApiResponse<AnalysisTextResponse>> saveText(
            @PathVariable String appNo, @Valid @RequestBody AnalysisTextRequest request) {
        return ResponseEntity.ok(ApiResponse.success(
                service.saveText(appNo, request.serNo(), request.relNo(), request.descNo(), request.text())));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/abstract")
    public ResponseEntity<ApiResponse<Void>> saveAbstract(
            @PathVariable String appNo, @Valid @RequestBody AbstractRequest request) {
        service.saveAbstract(appNo, request.result());
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
