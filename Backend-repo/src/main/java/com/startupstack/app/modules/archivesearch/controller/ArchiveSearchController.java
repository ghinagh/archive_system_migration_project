package com.startupstack.app.modules.archivesearch.controller;

import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchRequest;
import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchResultResponse;
import com.startupstack.app.modules.archivesearch.dto.AuthorOptionResponse;
import com.startupstack.app.modules.archivesearch.dto.CodingOptionResponse;
import com.startupstack.app.modules.archivesearch.service.ArchiveSearchService;
import com.startupstack.app.modules.corrections.service.CorrectionLogService;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/archive-search")
public class ArchiveSearchController {

    private final ArchiveSearchService archiveSearchService;
    private final CorrectionLogService correctionLogService;

    public ArchiveSearchController(ArchiveSearchService archiveSearchService,
                                    CorrectionLogService correctionLogService) {
        this.archiveSearchService = archiveSearchService;
        this.correctionLogService = correctionLogService;
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Page<ArchiveSearchResultResponse>>> search(
            @Valid @RequestBody ArchiveSearchRequest request,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(archiveSearchService.search(request, pageable)));
    }

    /** Legacy: m_res_no dropdown
     *  Returns list of responsible persons (AUTHER table) for search filter */
    @GetMapping("/responsible-persons")
    public ResponseEntity<ApiResponse<List<AuthorOptionResponse>>> getResponsiblePersons() {
        return ResponseEntity.ok(ApiResponse.success(archiveSearchService.getResponsiblePersons()));
    }

    /** Legacy: m_mch_typ dropdown
     *  Returns list of article types (CODING table) for search filter */
    @GetMapping("/article-types")
    public ResponseEntity<ApiResponse<List<CodingOptionResponse>>> getArticleTypes() {
        return ResponseEntity.ok(ApiResponse.success(archiveSearchService.getArticleTypes()));
    }

    /** Legacy: m_dig_typ1 dropdown
     *  Returns list of document types (CODING table) for search filter */
    @GetMapping("/document-types")
    public ResponseEntity<ApiResponse<List<CodingOptionResponse>>> getDocumentTypes() {
        return ResponseEntity.ok(ApiResponse.success(archiveSearchService.getDocumentTypes()));
    }

    /** Legacy Frame3 "ملاحظات المستفيد" — a beneficiary note about missing/incomplete
     *  information on the record, logged against it for staff follow-up. */
    @PostMapping("/{appNo}/remark")
    public ResponseEntity<ApiResponse<Void>> saveRemark(@PathVariable String appNo, @Valid @RequestBody RemarkRequest request) {
        correctionLogService.logChange(appNo, "user_remark", null, request.remark(),
                "ملاحظة من شاشة البحث الأرشيفي فيديو/صوتي");
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    public record RemarkRequest(@NotBlank String remark) {
    }
}
