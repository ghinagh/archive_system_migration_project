package com.startupstack.app.modules.catalogue.controller;

import com.startupstack.app.modules.catalogue.dto.CatalogueResponse;
import com.startupstack.app.modules.catalogue.service.DocumentLockService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/** "اقفال الوثائق المفتوحة" and "فتح صلاحية" — both gated by the legacy key (see DocumentLockService). */
@RestController
@RequestMapping("/api/catalogue")
public class DocumentLockController {

    /** The key typed in the legacy Frame3 / m_user_password box. */
    public record LockKeyRequest(String key) {}

    public record LockAllResponse(int locked) {}

    private final DocumentLockService service;

    public DocumentLockController(DocumentLockService service) {
        this.service = service;
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PostMapping("/lock-all")
    public ResponseEntity<ApiResponse<LockAllResponse>> lockAll(@RequestBody(required = false) LockKeyRequest request) {
        int n = service.lockAllOpen(request == null ? null : request.key());
        return ResponseEntity.ok(ApiResponse.success(new LockAllResponse(n)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PatchMapping("/{appNo}/unlock")
    public ResponseEntity<ApiResponse<CatalogueResponse>> unlock(@PathVariable String appNo,
                                                                 @RequestBody(required = false) LockKeyRequest request) {
        return ResponseEntity.ok(ApiResponse.success(service.unlock(appNo, request == null ? null : request.key())));
    }
}
