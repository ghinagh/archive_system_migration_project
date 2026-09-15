package com.startupstack.app.modules.books.controller;

import com.startupstack.app.modules.books.dto.BookRequest;
import com.startupstack.app.modules.books.dto.BookResponse;
import com.startupstack.app.modules.books.dto.SeriesRequest;
import com.startupstack.app.modules.books.dto.SeriesResponse;
import com.startupstack.app.modules.books.service.BookService;
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
@RequestMapping("/api/books")
public class BookController {

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<BookResponse>>> getAll(
            @RequestParam(required = false) String title,
            @RequestParam(required = false) String lang,
            @RequestParam(required = false) String status,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(bookService.findAll(title, lang, status, pageable)));
    }

    @GetMapping("/{appNo}")
    public ResponseEntity<ApiResponse<BookResponse>> getById(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(bookService.findById(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<BookResponse>> create(@Valid @RequestBody BookRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(bookService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{appNo}")
    public ResponseEntity<ApiResponse<BookResponse>> update(
            @PathVariable String appNo,
            @Valid @RequestBody BookRequest request) {
        return ResponseEntity.ok(ApiResponse.success(bookService.update(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String appNo) {
        bookService.delete(appNo);
        return ResponseEntity.ok(ApiResponse.error("Book deleted successfully"));
    }

    @GetMapping("/{appNo}/series")
    public ResponseEntity<ApiResponse<SeriesResponse>> getSeries(@PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(bookService.getSeries(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{appNo}/series")
    public ResponseEntity<ApiResponse<SeriesResponse>> createSeries(
            @PathVariable String appNo,
            @Valid @RequestBody SeriesRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(bookService.createSeries(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{appNo}/series")
    public ResponseEntity<ApiResponse<SeriesResponse>> updateSeries(
            @PathVariable String appNo,
            @Valid @RequestBody SeriesRequest request) {
        return ResponseEntity.ok(ApiResponse.success(bookService.updateSeries(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{appNo}/series")
    public ResponseEntity<ApiResponse<Void>> deleteSeries(@PathVariable String appNo) {
        bookService.deleteSeries(appNo);
        return ResponseEntity.ok(ApiResponse.error("Series deleted successfully"));
    }
}
