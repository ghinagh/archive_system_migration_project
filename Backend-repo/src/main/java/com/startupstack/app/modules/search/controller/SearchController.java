package com.startupstack.app.modules.search.controller;

import com.startupstack.app.modules.search.dto.SearchResultResponse;
import com.startupstack.app.modules.search.service.SearchService;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/search")
public class SearchController {

    private final SearchService searchService;

    public SearchController(SearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping("/fulltext")
    public ResponseEntity<ApiResponse<List<SearchResultResponse>>> fullTextSearch(
            @RequestParam String q) {
        return ResponseEntity.ok(ApiResponse.success(searchService.search(q)));
    }
}
