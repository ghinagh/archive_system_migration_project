package com.startupstack.app.modules.authors.controller;

import com.startupstack.app.modules.authors.dto.AuthorOptionResponse;
import com.startupstack.app.modules.authors.dto.AuthorRequest;
import com.startupstack.app.modules.authors.dto.AuthorResponse;
import com.startupstack.app.modules.authors.service.AuthorService;
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
@RequestMapping("/api/authors")
public class AuthorController {

    private final AuthorService authorService;

    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<AuthorOptionResponse>>> search(
            @RequestParam String q,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(ApiResponse.success(authorService.search(q, size)));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<AuthorResponse>>> getAll(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String type,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(authorService.findAll(name, type, pageable)));
    }

    @GetMapping("/{autNo}")
    public ResponseEntity<ApiResponse<AuthorResponse>> getById(@PathVariable Double autNo) {
        return ResponseEntity.ok(ApiResponse.success(authorService.findById(autNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<AuthorResponse>> create(@Valid @RequestBody AuthorRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(authorService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{autNo}")
    public ResponseEntity<ApiResponse<AuthorResponse>> update(
            @PathVariable Double autNo,
            @Valid @RequestBody AuthorRequest request) {
        return ResponseEntity.ok(ApiResponse.success(authorService.update(autNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{autNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Double autNo) {
        authorService.delete(autNo);
        return ResponseEntity.ok(ApiResponse.error("Author deleted successfully"));
    }
}
