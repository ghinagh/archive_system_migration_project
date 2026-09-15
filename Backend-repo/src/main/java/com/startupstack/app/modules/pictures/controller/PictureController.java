package com.startupstack.app.modules.pictures.controller;

import com.startupstack.app.modules.pictures.dto.PictureRequest;
import com.startupstack.app.modules.pictures.dto.PictureResponse;
import com.startupstack.app.modules.pictures.service.PictureService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
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

@RestController
@RequestMapping("/api/pictures")
public class PictureController {

    private final PictureService pictureService;

    public PictureController(PictureService pictureService) {
        this.pictureService = pictureService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<PictureResponse>>> getAll(
            @RequestParam(required = false) Double type,
            @RequestParam(required = false) String entity,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTo,
            @RequestParam(required = false) String person,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                pictureService.findAll(type, entity, dateFrom, dateTo, person, pageable)));
    }

    @GetMapping("/{picNo}")
    public ResponseEntity<ApiResponse<PictureResponse>> getById(@PathVariable String picNo) {
        return ResponseEntity.ok(ApiResponse.success(pictureService.findById(picNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<PictureResponse>> create(@Valid @RequestBody PictureRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(pictureService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{picNo}")
    public ResponseEntity<ApiResponse<PictureResponse>> update(
            @PathVariable String picNo,
            @Valid @RequestBody PictureRequest request) {
        return ResponseEntity.ok(ApiResponse.success(pictureService.update(picNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{picNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String picNo) {
        pictureService.delete(picNo);
        return ResponseEntity.ok(ApiResponse.error("Picture record deleted successfully"));
    }
}
