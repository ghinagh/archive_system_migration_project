package com.startupstack.app.modules.descriptors.controller;

import com.startupstack.app.modules.descriptors.dto.FileAddRequest;
import com.startupstack.app.modules.descriptors.dto.FileAddResponse;
import com.startupstack.app.modules.descriptors.dto.GeoRequest;
import com.startupstack.app.modules.descriptors.dto.GeoResponse;
import com.startupstack.app.modules.descriptors.dto.NarowerRequest;
import com.startupstack.app.modules.descriptors.dto.NarowerResponse;
import com.startupstack.app.modules.descriptors.dto.RelativeRequest;
import com.startupstack.app.modules.descriptors.dto.RelativeResponse;
import com.startupstack.app.modules.descriptors.dto.ResRequest;
import com.startupstack.app.modules.descriptors.dto.ResResponse;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisRequest;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisResponse;
import com.startupstack.app.modules.descriptors.dto.TextRequest;
import com.startupstack.app.modules.descriptors.dto.TextResponse;
import com.startupstack.app.modules.descriptors.service.DescriptorService;
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
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/catalogue/{appNo}")
public class DescriptorController {

    private final DescriptorService descriptorService;

    public DescriptorController(DescriptorService descriptorService) {
        this.descriptorService = descriptorService;
    }

    @GetMapping("/subjects")
    public ResponseEntity<ApiResponse<List<SubjectAnalysisResponse>>> getSubjects(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.getSubjects(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/subjects")
    public ResponseEntity<ApiResponse<SubjectAnalysisResponse>> addSubject(
            @PathVariable String appNo,
            @Valid @RequestBody SubjectAnalysisRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(descriptorService.addSubject(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/subjects/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteSubject(
            @PathVariable String appNo,
            @PathVariable Integer id) {
        descriptorService.deleteSubject(appNo, id);
        return ResponseEntity.ok(ApiResponse.error("Subject analysis deleted successfully"));
    }

    @GetMapping("/geo")
    public ResponseEntity<ApiResponse<List<GeoResponse>>> getGeoDescriptors(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.getGeoDescriptors(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/geo")
    public ResponseEntity<ApiResponse<GeoResponse>> addGeoDescriptor(
            @PathVariable String appNo,
            @Valid @RequestBody GeoRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(descriptorService.addGeoDescriptor(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/geo/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteGeoDescriptor(
            @PathVariable String appNo,
            @PathVariable Integer id) {
        descriptorService.deleteGeoDescriptor(appNo, id);
        return ResponseEntity.ok(ApiResponse.error("Geo descriptor deleted successfully"));
    }

    @GetMapping("/files")
    public ResponseEntity<ApiResponse<List<FileAddResponse>>> getFiles(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.getFiles(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/files")
    public ResponseEntity<ApiResponse<FileAddResponse>> addFile(
            @PathVariable String appNo,
            @Valid @RequestBody FileAddRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(descriptorService.addFile(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/files/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteFile(
            @PathVariable String appNo,
            @PathVariable java.util.UUID id) {
        descriptorService.deleteFile(appNo, id);
        return ResponseEntity.ok(ApiResponse.error("File relation deleted successfully"));
    }

    @GetMapping("/text")
    public ResponseEntity<ApiResponse<List<TextResponse>>> getTexts(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.getTexts(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/text")
    public ResponseEntity<ApiResponse<TextResponse>> addText(
            @PathVariable String appNo,
            @Valid @RequestBody TextRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(descriptorService.addText(appNo, request)));
    }

    @GetMapping("/narrower")
    public ResponseEntity<ApiResponse<List<NarowerResponse>>> getNarrowerTerms(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.getNarrowerTerms(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/narrower")
    public ResponseEntity<ApiResponse<NarowerResponse>> addNarrowerTerm(
            @PathVariable String appNo,
            @Valid @RequestBody NarowerRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(descriptorService.addNarrowerTerm(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/narrower/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteNarrowerTerm(
            @PathVariable String appNo,
            @PathVariable Integer id) {
        descriptorService.deleteNarrowerTerm(appNo, id);
        return ResponseEntity.ok(ApiResponse.error("Narrower term deleted successfully"));
    }

    @GetMapping("/related")
    public ResponseEntity<ApiResponse<List<RelativeResponse>>> getRelatedTerms(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.getRelatedTerms(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/related")
    public ResponseEntity<ApiResponse<RelativeResponse>> addRelatedTerm(
            @PathVariable String appNo,
            @Valid @RequestBody RelativeRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(descriptorService.addRelatedTerm(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/related/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteRelatedTerm(
            @PathVariable String appNo,
            @PathVariable Integer id) {
        descriptorService.deleteRelatedTerm(appNo, id);
        return ResponseEntity.ok(ApiResponse.error("Related term deleted successfully"));
    }

    @GetMapping("/authors")
    public ResponseEntity<ApiResponse<List<ResResponse>>> getLinkedAuthors(
            @PathVariable String appNo) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.getLinkedAuthors(appNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/authors")
    public ResponseEntity<ApiResponse<ResResponse>> addLinkedAuthor(
            @PathVariable String appNo,
            @Valid @RequestBody ResRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(descriptorService.addLinkedAuthor(appNo, request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/authors/{id}")
    public ResponseEntity<ApiResponse<ResResponse>> updateLinkedAuthor(
            @PathVariable String appNo,
            @PathVariable Integer id,
            @Valid @RequestBody ResRequest request) {
        return ResponseEntity.ok(ApiResponse.success(descriptorService.updateLinkedAuthor(appNo, id, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/authors/{id}")
    public ResponseEntity<ApiResponse<Void>> removeLinkedAuthor(
            @PathVariable String appNo,
            @PathVariable Integer id) {
        descriptorService.removeLinkedAuthor(appNo, id);
        return ResponseEntity.ok(ApiResponse.error("Author link removed successfully"));
    }
}
