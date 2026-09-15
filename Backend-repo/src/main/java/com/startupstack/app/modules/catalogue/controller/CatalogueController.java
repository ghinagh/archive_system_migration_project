package com.startupstack.app.modules.catalogue.controller;

import com.startupstack.app.modules.catalogue.dto.AbbreviationRequest;
import com.startupstack.app.modules.catalogue.dto.AbbreviationResponse;
import com.startupstack.app.modules.catalogue.dto.CatalogueRequest;
import com.startupstack.app.modules.catalogue.dto.CatalogueResponse;
import com.startupstack.app.modules.catalogue.dto.DateSubjectRequest;
import com.startupstack.app.modules.catalogue.dto.DateSubjectResponse;
import com.startupstack.app.modules.catalogue.dto.Text1Request;
import com.startupstack.app.modules.catalogue.dto.Text1Response;
import com.startupstack.app.modules.catalogue.dto.TimeDescriptorRequest;
import com.startupstack.app.modules.catalogue.dto.TimeDescriptorResponse;
import com.startupstack.app.modules.catalogue.service.AbbreviationService;
import com.startupstack.app.modules.catalogue.service.CatalogueService;
import com.startupstack.app.modules.catalogue.service.DateSubjectService;
import com.startupstack.app.modules.catalogue.service.Text1Service;
import com.startupstack.app.modules.catalogue.service.TimeDescriptorService;
import com.startupstack.app.modules.corrections.dto.CorrectionLogResponse;
import com.startupstack.app.modules.corrections.service.CorrectionLogService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import com.startupstack.app.shared.specification.AdvancedSearchRequest;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/catalogue")
public class CatalogueController {

    private final CatalogueService catalogueService;
    private final DateSubjectService dateSubjectService;
    private final Text1Service text1Service;
    private final TimeDescriptorService timeDescriptorService;
    private final AbbreviationService abbreviationService;
    private final CorrectionLogService correctionLogService;

    public CatalogueController(CatalogueService catalogueService,
                               DateSubjectService dateSubjectService,
                               Text1Service text1Service,
                               TimeDescriptorService timeDescriptorService,
                               AbbreviationService abbreviationService,
                               CorrectionLogService correctionLogService) {
        this.catalogueService = catalogueService;
        this.dateSubjectService = dateSubjectService;
        this.text1Service = text1Service;
        this.timeDescriptorService = timeDescriptorService;
        this.abbreviationService = abbreviationService;
        this.correctionLogService = correctionLogService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<CatalogueResponse>>> getAll(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTo,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(catalogueService.findAll(type, dateFrom, dateTo, pageable)));
    }

    @GetMapping("/{appNo}")
    public ResponseEntity<ApiResponse<CatalogueResponse>> getById(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(catalogueService.findById(appNo)));
    }

    @PostMapping("/search")
    public ResponseEntity<ApiResponse<Page<CatalogueResponse>>> advancedSearch(
            @Valid @RequestBody AdvancedSearchRequest request,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                catalogueService.advancedSearch(request.getConditions(), pageable)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<CatalogueResponse>> create(@Valid @RequestBody CatalogueRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(catalogueService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{appNo}")
    public ResponseEntity<ApiResponse<CatalogueResponse>> update(
            @PathVariable String appNo,
            @Valid @RequestBody CatalogueRequest request,
            @RequestParam(required = false) String correctionReason) {
        return ResponseEntity.ok(ApiResponse.success(catalogueService.update(appNo, request, correctionReason)));
    }

    @GetMapping("/{appNo}/corrections")
    public ResponseEntity<ApiResponse<List<CorrectionLogResponse>>> getCorrections(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(correctionLogService.getCorrections(appNo)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String appNo) {
        catalogueService.delete(appNo);
        return ResponseEntity.ok(ApiResponse.error("Catalogue record deleted successfully"));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping("/locked")
    public ResponseEntity<ApiResponse<Page<CatalogueResponse>>> getLocked(Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(catalogueService.getLockedDocuments(pageable)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/{appNo}/unlock")
    public ResponseEntity<ApiResponse<CatalogueResponse>> unlock(@PathVariable String appNo) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        CatalogueResponse response = catalogueService.unlockRecord(appNo, auth.getName());
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    // --- Date subjects ---

    @GetMapping("/{appNo}/date-subjects")
    public ResponseEntity<ApiResponse<List<DateSubjectResponse>>> getDateSubjects(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(dateSubjectService.getByAppNo(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{appNo}/date-subjects")
    public ResponseEntity<ApiResponse<DateSubjectResponse>> addDateSubject(
            @PathVariable String appNo,
            @Valid @RequestBody DateSubjectRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(dateSubjectService.addDateSubject(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}/date-subjects/{serNo}/{relNo}")
    public ResponseEntity<ApiResponse<Void>> deleteDateSubject(
            @PathVariable String appNo,
            @PathVariable String serNo,
            @PathVariable String relNo) {
        dateSubjectService.deleteDateSubject(appNo, serNo, relNo);
        return ResponseEntity.ok(ApiResponse.error("Date subject deleted successfully"));
    }

    // --- Time descriptors ---

    @GetMapping("/{appNo}/time-descriptors")
    public ResponseEntity<ApiResponse<List<TimeDescriptorResponse>>> getTimeDescriptors(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(timeDescriptorService.getByAppNo(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{appNo}/time-descriptors")
    public ResponseEntity<ApiResponse<TimeDescriptorResponse>> addTimeDescriptor(
            @PathVariable String appNo,
            @Valid @RequestBody TimeDescriptorRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(timeDescriptorService.add(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}/time-descriptors/{serNo}/{rltvNo}")
    public ResponseEntity<ApiResponse<Void>> deleteTimeDescriptor(
            @PathVariable String appNo,
            @PathVariable String serNo,
            @PathVariable String rltvNo) {
        timeDescriptorService.delete(appNo, serNo, rltvNo);
        return ResponseEntity.ok(ApiResponse.error("Time descriptor deleted successfully"));
    }

    // --- Abbreviations ---

    @GetMapping("/{appNo}/abbreviations")
    public ResponseEntity<ApiResponse<List<AbbreviationResponse>>> getAbbreviations(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(abbreviationService.getByAppNo(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{appNo}/abbreviations")
    public ResponseEntity<ApiResponse<AbbreviationResponse>> addAbbreviation(
            @PathVariable String appNo,
            @Valid @RequestBody AbbreviationRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(abbreviationService.add(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}/abbreviations/{serNo}/{rltvN}")
    public ResponseEntity<ApiResponse<Void>> deleteAbbreviation(
            @PathVariable String appNo,
            @PathVariable String serNo,
            @PathVariable String rltvN) {
        abbreviationService.delete(appNo, serNo, rltvN);
        return ResponseEntity.ok(ApiResponse.error("Abbreviation deleted successfully"));
    }

    // --- Text1 ---

    @GetMapping("/{appNo}/text1")
    public ResponseEntity<ApiResponse<List<Text1Response>>> getText1(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(text1Service.getByAppNo(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{appNo}/text1")
    public ResponseEntity<ApiResponse<Text1Response>> createText1(
            @PathVariable String appNo,
            @Valid @RequestBody Text1Request request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(text1Service.create(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{appNo}/text1/{serNo}")
    public ResponseEntity<ApiResponse<Text1Response>> updateText1(
            @PathVariable String appNo,
            @PathVariable String serNo,
            @Valid @RequestBody Text1Request request) {
        return ResponseEntity.ok(ApiResponse.success(text1Service.update(appNo, serNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}/text1/{serNo}")
    public ResponseEntity<ApiResponse<Void>> deleteText1(
            @PathVariable String appNo,
            @PathVariable String serNo) {
        text1Service.delete(appNo, serNo);
        return ResponseEntity.ok(ApiResponse.error("Text1 entry deleted successfully"));
    }
}
