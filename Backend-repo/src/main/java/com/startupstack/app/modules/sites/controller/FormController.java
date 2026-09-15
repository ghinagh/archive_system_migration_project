package com.startupstack.app.modules.sites.controller;

import com.startupstack.app.modules.sites.dto.Form1Response;
import com.startupstack.app.modules.sites.dto.FormRequest;
import com.startupstack.app.modules.sites.dto.FormResponse;
import com.startupstack.app.modules.sites.dto.RelFormRequest;
import com.startupstack.app.modules.sites.dto.RelFormResponse;
import com.startupstack.app.modules.sites.dto.SubjectLinkRequest;
import com.startupstack.app.modules.sites.dto.SubjectLinkResponse;
import com.startupstack.app.modules.sites.service.Form1Service;
import com.startupstack.app.modules.sites.service.FormService;
import com.startupstack.app.modules.sites.service.RelFormService;
import com.startupstack.app.modules.sites.service.SubjectLinkService;
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
@RequestMapping("/api/forms")
public class FormController {

    private final FormService formService;
    private final Form1Service form1Service;
    private final SubjectLinkService subjectLinkService;
    private final RelFormService relFormService;

    public FormController(FormService formService,
                          Form1Service form1Service,
                          SubjectLinkService subjectLinkService,
                          RelFormService relFormService) {
        this.formService = formService;
        this.form1Service = form1Service;
        this.subjectLinkService = subjectLinkService;
        this.relFormService = relFormService;
    }

    // --- Secondary forms (form1) ---
    // form1 shares the same SUB_TYP/SUB_NO key space as the primary form table
    // but is a lightweight read-only variant used for selection dropdowns in the legacy UI.

    @GetMapping("/secondary")
    public ResponseEntity<ApiResponse<List<Form1Response>>> getSecondaryForms(
            @RequestParam(required = false) String type) {
        return ResponseEntity.ok(ApiResponse.success(form1Service.findAll(type)));
    }

    // --- Primary forms ---

    @GetMapping("/institutions")
    public ResponseEntity<ApiResponse<Page<FormResponse>>> getInstitutions(Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(formService.findInstitutions(pageable)));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<FormResponse>>> getAll(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String type,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(formService.findAll(name, type, pageable)));
    }

    @GetMapping("/{formNo}")
    public ResponseEntity<ApiResponse<FormResponse>> getById(@PathVariable String formNo) {
        return ResponseEntity.ok(ApiResponse.success(formService.findById(formNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<FormResponse>> create(@Valid @RequestBody FormRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(formService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{formNo}")
    public ResponseEntity<ApiResponse<FormResponse>> update(
            @PathVariable String formNo,
            @Valid @RequestBody FormRequest request) {
        return ResponseEntity.ok(ApiResponse.success(formService.update(formNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{formNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String formNo) {
        formService.delete(formNo);
        return ResponseEntity.ok(ApiResponse.error("Form deleted successfully"));
    }

    // --- SUBJECT links ---

    @GetMapping("/{formNo}/subjects")
    public ResponseEntity<ApiResponse<List<SubjectLinkResponse>>> getSubjects(@PathVariable String formNo) {
        return ResponseEntity.ok(ApiResponse.success(subjectLinkService.getByFormNo(formNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{formNo}/subjects")
    public ResponseEntity<ApiResponse<SubjectLinkResponse>> addSubject(
            @PathVariable String formNo,
            @Valid @RequestBody SubjectLinkRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(subjectLinkService.addSubject(formNo, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{formNo}/subjects/{mcnzCode}")
    public ResponseEntity<ApiResponse<SubjectLinkResponse>> updateSubject(
            @PathVariable String formNo,
            @PathVariable String mcnzCode,
            @Valid @RequestBody SubjectLinkRequest request) {
        return ResponseEntity.ok(ApiResponse.success(subjectLinkService.updateSubject(formNo, mcnzCode, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{formNo}/subjects/{mcnzCode}")
    public ResponseEntity<ApiResponse<Void>> deleteSubject(
            @PathVariable String formNo,
            @PathVariable String mcnzCode) {
        subjectLinkService.deleteSubject(formNo, mcnzCode);
        return ResponseEntity.ok(ApiResponse.error("Subject link deleted successfully"));
    }

    // --- Related forms ---

    @GetMapping("/{formNo}/related-forms")
    public ResponseEntity<ApiResponse<List<RelFormResponse>>> getRelatedForms(@PathVariable String formNo) {
        return ResponseEntity.ok(ApiResponse.success(relFormService.getByFormNo(formNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{formNo}/related-forms")
    public ResponseEntity<ApiResponse<RelFormResponse>> addRelatedForm(
            @PathVariable String formNo,
            @Valid @RequestBody RelFormRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(relFormService.addRelatedForm(formNo, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{formNo}/related-forms/{form2No}")
    public ResponseEntity<ApiResponse<RelFormResponse>> updateRelatedForm(
            @PathVariable String formNo,
            @PathVariable String form2No,
            @Valid @RequestBody RelFormRequest request) {
        return ResponseEntity.ok(ApiResponse.success(relFormService.updateRelatedForm(formNo, form2No, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{formNo}/related-forms/{form2No}")
    public ResponseEntity<ApiResponse<Void>> deleteRelatedForm(
            @PathVariable String formNo,
            @PathVariable String form2No) {
        relFormService.deleteRelatedForm(formNo, form2No);
        return ResponseEntity.ok(ApiResponse.error("Related form deleted successfully"));
    }
}
