package com.startupstack.app.modules.search.controller;

import com.startupstack.app.modules.search.dto.PublicSearchResult;
import com.startupstack.app.modules.search.service.PublicSearchService;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/public")
public class PublicSearchController {

    private final PublicSearchService searchService;

    public PublicSearchController(PublicSearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<Page<PublicSearchResult>>> search(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(required = false) String type,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(searchService.search(q, type, pageable)));
    }
}
