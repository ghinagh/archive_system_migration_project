package com.startupstack.app.modules.articles.controller;

import com.startupstack.app.modules.articles.dto.ArticleRequest;
import com.startupstack.app.modules.articles.dto.ArticleResponse;
import com.startupstack.app.modules.articles.service.ArticleService;
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

@RestController
@RequestMapping("/api/articles")
public class ArticleController {

    private final ArticleService articleService;

    public ArticleController(ArticleService articleService) {
        this.articleService = articleService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<ArticleResponse>>> getAll(
            @RequestParam(required = false) Double periodicalNo,
            @RequestParam(required = false) String title,
            @RequestParam(required = false) Double year,
            @RequestParam(required = false) String lang,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                articleService.findAll(periodicalNo, title, year, lang, pageable)));
    }

    @GetMapping("/{appNo}")
    public ResponseEntity<ApiResponse<ArticleResponse>> getById(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(articleService.findById(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<ArticleResponse>> create(@Valid @RequestBody ArticleRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(articleService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{appNo}")
    public ResponseEntity<ApiResponse<ArticleResponse>> update(
            @PathVariable String appNo,
            @Valid @RequestBody ArticleRequest request) {
        return ResponseEntity.ok(ApiResponse.success(articleService.update(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String appNo) {
        articleService.delete(appNo);
        return ResponseEntity.ok(ApiResponse.error("Article deleted successfully"));
    }
}
