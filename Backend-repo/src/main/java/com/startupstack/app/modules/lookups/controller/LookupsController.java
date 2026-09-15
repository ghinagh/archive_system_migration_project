package com.startupstack.app.modules.lookups.controller;

import com.startupstack.app.modules.lookups.dto.Arrays1Response;
import com.startupstack.app.modules.lookups.dto.ArraysResponse;
import com.startupstack.app.modules.lookups.dto.CodingRequest;
import com.startupstack.app.modules.lookups.dto.CodingResponse;
import com.startupstack.app.modules.lookups.dto.CotePubRequest;
import com.startupstack.app.modules.lookups.dto.CotePubResponse;
import com.startupstack.app.modules.lookups.dto.DictResponse;
import com.startupstack.app.modules.lookups.dto.MacnzRequest;
import com.startupstack.app.modules.lookups.dto.MacnzResponse;
import com.startupstack.app.modules.lookups.dto.MemResponse;
import com.startupstack.app.modules.lookups.dto.RelisResponse;
import com.startupstack.app.modules.lookups.dto.TOperationResponse;
import com.startupstack.app.modules.lookups.service.LookupsService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
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
@RequestMapping("/api/lookups")
public class LookupsController {

    private final LookupsService lookupsService;

    public LookupsController(LookupsService lookupsService) {
        this.lookupsService = lookupsService;
    }

    @GetMapping("/arrays")
    public ResponseEntity<ApiResponse<List<ArraysResponse>>> getArrays(
            @RequestParam(required = false) String arTyp) {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllArrays(arTyp)));
    }

    @GetMapping("/arrays1")
    public ResponseEntity<ApiResponse<List<Arrays1Response>>> getArrays1(
            @RequestParam(required = false) String arTyp) {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllArrays1(arTyp)));
    }

    @GetMapping("/relations")
    public ResponseEntity<ApiResponse<List<RelisResponse>>> getRelations() {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllRelations()));
    }

    @GetMapping("/dict")
    public ResponseEntity<ApiResponse<List<DictResponse>>> getDict(
            @RequestParam(required = false) String subCode3) {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllDict(subCode3)));
    }

    @GetMapping("/mem")
    public ResponseEntity<ApiResponse<List<MemResponse>>> getMem() {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllMem()));
    }

    @GetMapping("/cote-pub")
    public ResponseEntity<ApiResponse<List<CotePubResponse>>> getCotePub() {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllCotePub()));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/cote-pub")
    public ResponseEntity<ApiResponse<CotePubResponse>> createCotePub(
            @Valid @RequestBody CotePubRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(lookupsService.createCotePub(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/cote-pub/{id}")
    public ResponseEntity<ApiResponse<CotePubResponse>> updateCotePub(
            @PathVariable Double id,
            @Valid @RequestBody CotePubRequest request) {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.updateCotePub(id, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/cote-pub/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteCotePub(@PathVariable Double id) {
        lookupsService.deleteCotePub(id);
        return ResponseEntity.ok(ApiResponse.error("CotePub entry deleted successfully"));
    }

    @GetMapping("/operations")
    public ResponseEntity<ApiResponse<List<TOperationResponse>>> getOperations() {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllOperations()));
    }

    @GetMapping("/subjects")
    public ResponseEntity<ApiResponse<List<MacnzResponse>>> getSubjects() {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllSubjects()));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/subjects")
    public ResponseEntity<ApiResponse<MacnzResponse>> createSubject(
            @Valid @RequestBody MacnzRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(lookupsService.createSubject(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/subjects/{code}")
    public ResponseEntity<ApiResponse<MacnzResponse>> updateSubject(
            @PathVariable String code,
            @Valid @RequestBody MacnzRequest request) {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.updateSubject(code, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/subjects/{code}")
    public ResponseEntity<ApiResponse<Void>> deleteSubject(@PathVariable String code) {
        lookupsService.deleteSubject(code);
        return ResponseEntity.ok(ApiResponse.error("Subject deleted successfully"));
    }

    @GetMapping("/coding")
    public ResponseEntity<ApiResponse<List<CodingResponse>>> getCoding(
            @RequestParam(required = false) String level,
            @RequestParam(required = false) String codePrefix) {
        if (codePrefix != null && !codePrefix.isBlank()) {
            return ResponseEntity.ok(ApiResponse.success(lookupsService.getCodingByCodePrefix(codePrefix)));
        }
        if (level != null && !level.isBlank()) {
            return ResponseEntity.ok(ApiResponse.success(lookupsService.getCodingByLevel(level)));
        }
        return ResponseEntity.ok(ApiResponse.success(lookupsService.getAllCoding()));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/coding")
    public ResponseEntity<ApiResponse<CodingResponse>> createCoding(
            @Valid @RequestBody CodingRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(lookupsService.createCoding(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/coding/{level}/{code}")
    public ResponseEntity<ApiResponse<CodingResponse>> updateCoding(
            @PathVariable String level,
            @PathVariable String code,
            @Valid @RequestBody CodingRequest request) {
        return ResponseEntity.ok(ApiResponse.success(lookupsService.updateCoding(level, code, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/coding/{level}/{code}")
    public ResponseEntity<ApiResponse<Void>> deleteCoding(
            @PathVariable String level,
            @PathVariable String code) {
        lookupsService.deleteCoding(level, code);
        return ResponseEntity.ok(ApiResponse.error("Coding entry deleted successfully"));
    }
}
