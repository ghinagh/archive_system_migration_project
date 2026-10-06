package com.startupstack.app.modules.authors.controller;

import com.startupstack.app.modules.authors.dto.AuthorCodingInsertRequest;
import com.startupstack.app.modules.authors.dto.AuthorCodingQuery;
import com.startupstack.app.modules.authors.dto.AuthorCodingRow;
import com.startupstack.app.modules.authors.dto.AuthorCodingUpdateRequest;
import com.startupstack.app.modules.authors.service.AuthorCodingService;
import com.startupstack.app.shared.response.ApiResponse;
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

/**
 * Endpoints of the "المؤلفين ودور النشر" coding screen (legacy Form8.frm). Like the legacy menu
 * item m10, they carry no permission gate beyond being signed in.
 */
@RestController
@RequestMapping("/api/authors/coding")
public class AuthorCodingController {

    private final AuthorCodingService service;

    public AuthorCodingController(AuthorCodingService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<AuthorCodingRow>>> list(
            @RequestParam(defaultValue = "BY_NUMBER") AuthorCodingQuery query,
            @RequestParam(required = false) String text) {
        return ResponseEntity.ok(ApiResponse.success(service.list(query, text)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<AuthorCodingRow>> insert(@RequestBody AuthorCodingInsertRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(service.insert(request)));
    }

    @PutMapping("/{number}")
    public ResponseEntity<ApiResponse<Void>> update(@PathVariable Double number,
                                                    @RequestBody AuthorCodingUpdateRequest request) {
        service.updateName(number, request);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @DeleteMapping("/{number}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Double number) {
        service.delete(number);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
