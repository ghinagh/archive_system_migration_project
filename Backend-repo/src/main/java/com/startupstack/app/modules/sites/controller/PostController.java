package com.startupstack.app.modules.sites.controller;

import com.startupstack.app.modules.sites.dto.PostRequest;
import com.startupstack.app.modules.sites.dto.PostResponse;
import com.startupstack.app.modules.sites.service.PostService;
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
@RequestMapping("/api/posts")
public class PostController {

    private final PostService postService;

    public PostController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<PostResponse>>> getAll(
            @RequestParam(required = false) String formNo,
            @RequestParam(required = false) Integer wilyaNo,
            @RequestParam(required = false) Boolean includeSiteInfo,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                postService.findAll(formNo, wilyaNo, includeSiteInfo, pageable)));
    }

    @GetMapping("/{serial}")
    public ResponseEntity<ApiResponse<PostResponse>> getById(@PathVariable String serial) {
        return ResponseEntity.ok(ApiResponse.success(postService.findById(serial)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<PostResponse>> create(@Valid @RequestBody PostRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(postService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{serial}")
    public ResponseEntity<ApiResponse<PostResponse>> update(
            @PathVariable String serial,
            @Valid @RequestBody PostRequest request) {
        return ResponseEntity.ok(ApiResponse.success(postService.update(serial, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{serial}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String serial) {
        postService.delete(serial);
        return ResponseEntity.ok(ApiResponse.error("Post deleted successfully"));
    }
}
