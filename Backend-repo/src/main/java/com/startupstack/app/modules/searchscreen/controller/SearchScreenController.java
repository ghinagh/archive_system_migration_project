package com.startupstack.app.modules.searchscreen.controller;

import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchResultResponse;
import com.startupstack.app.modules.searchscreen.dto.SearchScreenRequest;
import com.startupstack.app.modules.searchscreen.service.SearchScreenService;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/** Legacy "شاشة البحث" (user_inetrface.frm), Command1_Click "النتيجة" and DataGrid1. */
@RestController
@RequestMapping("/api/search-screen")
public class SearchScreenController {

    private final SearchScreenService searchScreenService;

    public SearchScreenController(SearchScreenService searchScreenService) {
        this.searchScreenService = searchScreenService;
    }

    @PostMapping("/search")
    public ResponseEntity<ApiResponse<Page<ArchiveSearchResultResponse>>> search(
            @Valid @RequestBody SearchScreenRequest request,
            @PageableDefault(size = 10) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(searchScreenService.search(request, pageable)));
    }

    /** Legacy DataGrid1_KeyDown F9 "الاختيار" (:2590-2605). */
    @PutMapping("/results/{digitNo}/choice")
    public ResponseEntity<ApiResponse<Void>> setChoice(
            @PathVariable String digitNo,
            @RequestParam String type1,
            @RequestParam int choice) {
        searchScreenService.setChoice(digitNo, type1, choice);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
