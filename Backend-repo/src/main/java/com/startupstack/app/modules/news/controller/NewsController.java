package com.startupstack.app.modules.news.controller;

import com.startupstack.app.modules.news.dto.NewsRequest;
import com.startupstack.app.modules.news.dto.NewsResponse;
import com.startupstack.app.modules.news.service.NewsService;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/news")
public class NewsController {

    private final NewsService newsService;

    public NewsController(NewsService newsService) {
        this.newsService = newsService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<NewsResponse>>> getAll(
            @RequestParam(required = false) String docType,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTo,
            @RequestParam(required = false) Double publication,
            @RequestParam(required = false) String title,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                newsService.findAll(docType, dateFrom, dateTo, publication, title, pageable)));
    }

    @GetMapping("/{newsNo}")
    public ResponseEntity<ApiResponse<NewsResponse>> getById(@PathVariable String newsNo) {
        return ResponseEntity.ok(ApiResponse.success(newsService.findById(newsNo)));
    }

    @PostMapping("/search")
    public ResponseEntity<ApiResponse<Page<NewsResponse>>> advancedSearch(
            @Valid @RequestBody AdvancedSearchRequest request,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                newsService.advancedSearch(request.getConditions(), pageable)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<NewsResponse>> create(@Valid @RequestBody NewsRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(newsService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{newsNo}")
    public ResponseEntity<ApiResponse<NewsResponse>> update(
            @PathVariable String newsNo,
            @Valid @RequestBody NewsRequest request) {
        return ResponseEntity.ok(ApiResponse.success(newsService.update(newsNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{newsNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String newsNo) {
        newsService.delete(newsNo);
        return ResponseEntity.ok(ApiResponse.error("News record deleted successfully"));
    }

    @GetMapping("/{newsNo}/keywords")
    public ResponseEntity<ApiResponse<List<String>>> getKeywords(@PathVariable String newsNo) {
        return ResponseEntity.ok(ApiResponse.success(newsService.getKeywords(newsNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{newsNo}/keywords")
    public ResponseEntity<ApiResponse<List<String>>> addKeyword(
            @PathVariable String newsNo,
            @RequestBody Map<String, String> body) {
        String word = body.getOrDefault("word", "");
        return ResponseEntity.ok(ApiResponse.success(newsService.addKeyword(newsNo, word)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{newsNo}/keywords/{word}")
    public ResponseEntity<ApiResponse<Void>> removeKeyword(
            @PathVariable String newsNo,
            @PathVariable String word) {
        newsService.removeKeyword(newsNo, word);
        return ResponseEntity.ok(ApiResponse.error("Keyword removed successfully"));
    }
}
