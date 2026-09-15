package com.startupstack.app.modules.reports.controller;

import com.startupstack.app.modules.reports.dto.CategoryRequest;
import com.startupstack.app.modules.reports.dto.CategoryResponse;
import com.startupstack.app.modules.reports.dto.Pout1Request;
import com.startupstack.app.modules.reports.dto.Pout1Response;
import com.startupstack.app.modules.reports.dto.ReportTemplateRequest;
import com.startupstack.app.modules.reports.dto.ReportTemplateResponse;
import com.startupstack.app.modules.reports.dto.TemplateExecutionResponse;
import com.startupstack.app.modules.reports.dto.UserOutputRequest;
import com.startupstack.app.modules.reports.dto.UserOutputResponse;
import com.startupstack.app.modules.reports.service.Pout1Service;
import com.startupstack.app.modules.reports.service.ReportGeneratorService;
import com.startupstack.app.modules.reports.service.ReportService;
import com.startupstack.app.modules.reports.service.TemplateExecutionService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/reports")
public class ReportController {

    private final ReportService            reportService;
    private final ReportGeneratorService   reportGeneratorService;
    private final TemplateExecutionService templateExecutionService;
    private final Pout1Service             pout1Service;

    public ReportController(ReportService reportService,
                            ReportGeneratorService reportGeneratorService,
                            TemplateExecutionService templateExecutionService,
                            Pout1Service pout1Service) {
        this.reportService             = reportService;
        this.reportGeneratorService    = reportGeneratorService;
        this.templateExecutionService  = templateExecutionService;
        this.pout1Service              = pout1Service;
    }

    @GetMapping("/generate/{reportType}")
    public ResponseEntity<byte[]> generateReport(
            @PathVariable String reportType,
            @RequestParam Map<String, String> queryParams) {

        Map<String, Object> params = new HashMap<>(queryParams);
        byte[] pdf = reportGeneratorService.generateReport(reportType, params);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDisposition(
                ContentDisposition.inline()
                        .filename(reportType + ".pdf")
                        .build());
        headers.setContentLength(pdf.length);

        return new ResponseEntity<>(pdf, headers, HttpStatus.OK);
    }

    @GetMapping("/execute/{templateNum}")
    public ResponseEntity<ApiResponse<TemplateExecutionResponse>> executeTemplate(
            @PathVariable Integer templateNum,
            @RequestParam Map<String, String> filters) {
        return ResponseEntity.ok(ApiResponse.success(
                templateExecutionService.execute(templateNum, filters)));
    }

    @GetMapping("/templates")
    public ResponseEntity<ApiResponse<Page<ReportTemplateResponse>>> getAllTemplates(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String category,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                reportService.findAllTemplates(name, type, category, pageable)));
    }

    @GetMapping("/templates/{id}")
    public ResponseEntity<ApiResponse<ReportTemplateResponse>> getTemplateById(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.success(reportService.findTemplateById(id)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/templates")
    public ResponseEntity<ApiResponse<ReportTemplateResponse>> createTemplate(
            @Valid @RequestBody ReportTemplateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(reportService.createTemplate(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/templates/{id}")
    public ResponseEntity<ApiResponse<ReportTemplateResponse>> updateTemplate(
            @PathVariable Integer id,
            @Valid @RequestBody ReportTemplateRequest request) {
        return ResponseEntity.ok(ApiResponse.success(reportService.updateTemplate(id, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/templates/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteTemplate(@PathVariable Integer id) {
        reportService.deleteTemplate(id);
        return ResponseEntity.ok(ApiResponse.error("Report template deleted successfully"));
    }

    @GetMapping("/user-outputs")
    public ResponseEntity<ApiResponse<Page<UserOutputResponse>>> getAllUserOutputs(
            @RequestParam(required = false) String userNo,
            @RequestParam(required = false) String institutionNo,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                reportService.findAllUserOutputs(userNo, institutionNo, pageable)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/user-outputs")
    public ResponseEntity<ApiResponse<UserOutputResponse>> createUserOutput(
            @Valid @RequestBody UserOutputRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(reportService.createUserOutput(request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/user-outputs")
    public ResponseEntity<ApiResponse<Void>> deleteUserOutput(
            @RequestParam String institutionNo,
            @RequestParam String userNo,
            @RequestParam Integer outputNum) {
        reportService.deleteUserOutput(institutionNo, userNo, outputNum);
        return ResponseEntity.ok(ApiResponse.error("User output deleted successfully"));
    }

    // --- POUT1 ---

    @GetMapping("/pout1")
    public ResponseEntity<ApiResponse<Page<Pout1Response>>> getAllPout1(Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(pout1Service.findAll(pageable)));
    }

    @GetMapping("/pout1/{outIst}/{outNum}")
    public ResponseEntity<ApiResponse<Pout1Response>> getPout1ById(
            @PathVariable String outIst,
            @PathVariable Double outNum) {
        return ResponseEntity.ok(ApiResponse.success(pout1Service.findById(outIst, outNum)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/pout1/{outIst}")
    public ResponseEntity<ApiResponse<Pout1Response>> createPout1(
            @PathVariable String outIst,
            @Valid @RequestBody Pout1Request request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(pout1Service.create(outIst, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/pout1/{outIst}/{outNum}")
    public ResponseEntity<ApiResponse<Pout1Response>> updatePout1(
            @PathVariable String outIst,
            @PathVariable Double outNum,
            @Valid @RequestBody Pout1Request request) {
        return ResponseEntity.ok(ApiResponse.success(pout1Service.update(outIst, outNum, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/pout1/{outIst}/{outNum}")
    public ResponseEntity<ApiResponse<Void>> deletePout1(
            @PathVariable String outIst,
            @PathVariable Double outNum) {
        pout1Service.delete(outIst, outNum);
        return ResponseEntity.ok(ApiResponse.error("POUT1 entry deleted successfully"));
    }

    // --- Categories ---

    @GetMapping("/categories")
    public ResponseEntity<ApiResponse<List<CategoryResponse>>> getCategories() {
        return ResponseEntity.ok(ApiResponse.success(reportService.findAllCategories()));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/categories")
    public ResponseEntity<ApiResponse<CategoryResponse>> createCategory(
            @Valid @RequestBody CategoryRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(reportService.createCategory(request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/categories/{auto}")
    public ResponseEntity<ApiResponse<Void>> deleteCategory(@PathVariable Integer auto) {
        reportService.deleteCategory(auto);
        return ResponseEntity.ok(ApiResponse.error("Category deleted successfully"));
    }
}
