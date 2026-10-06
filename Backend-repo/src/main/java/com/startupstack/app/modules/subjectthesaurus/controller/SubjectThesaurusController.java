package com.startupstack.app.modules.subjectthesaurus.controller;

import com.startupstack.app.modules.subjectthesaurus.dto.AccessGrantResponse;
import com.startupstack.app.modules.subjectthesaurus.dto.AccessKeyRequest;
import com.startupstack.app.modules.subjectthesaurus.dto.Level3CodeRequest;
import com.startupstack.app.modules.subjectthesaurus.dto.Level3CodeResponse;
import com.startupstack.app.modules.subjectthesaurus.dto.SubjectThesaurusContext;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermInsertRequest;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermQuery;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermRow;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermUpdateRequest;
import com.startupstack.app.modules.subjectthesaurus.service.SubjectThesaurusAccessService;
import com.startupstack.app.modules.subjectthesaurus.service.SubjectThesaurusService;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.startupstack.app.modules.subjectthesaurus.service.SubjectThesaurusAccessService.HEADER;

/**
 * Endpoints of "المكنز الموضوعي" (legacy Form5.frm). Everything but the key check itself requires
 * the grant issued for the ARCHIVE.frm Frame3 key; writes additionally require user_no 244.
 */
@RestController
@RequestMapping("/api/subject-thesaurus")
public class SubjectThesaurusController {

    private final SubjectThesaurusService service;
    private final SubjectThesaurusAccessService access;

    public SubjectThesaurusController(SubjectThesaurusService service, SubjectThesaurusAccessService access) {
        this.service = service;
        this.access = access;
    }

    @PostMapping("/access")
    public ResponseEntity<ApiResponse<AccessGrantResponse>> grantAccess(@RequestBody AccessKeyRequest request) {
        return ResponseEntity.ok(ApiResponse.success(access.grant(request.key())));
    }

    @DeleteMapping("/access")
    public ResponseEntity<ApiResponse<Void>> revokeAccess(@RequestHeader(value = HEADER, required = false) String token) {
        access.revoke(token);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @GetMapping("/context")
    public ResponseEntity<ApiResponse<SubjectThesaurusContext>> context(
            @RequestHeader(value = HEADER, required = false) String token) {
        access.verify(token);
        return ResponseEntity.ok(ApiResponse.success(service.context()));
    }

    @GetMapping("/terms")
    public ResponseEntity<ApiResponse<List<ThesaurusTermRow>>> list(
            @RequestHeader(value = HEADER, required = false) String token,
            @RequestParam(defaultValue = "LEVEL1") ThesaurusTermQuery query,
            @RequestParam(required = false) String level,
            @RequestParam(required = false) String parentCode,
            @RequestParam(required = false) String text) {
        access.verify(token);
        return ResponseEntity.ok(ApiResponse.success(service.list(query, level, parentCode, text)));
    }

    @PostMapping("/terms")
    public ResponseEntity<ApiResponse<Void>> insert(@RequestHeader(value = HEADER, required = false) String token,
                                                    @RequestBody ThesaurusTermInsertRequest request) {
        access.verify(token);
        service.insert(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    @PutMapping("/terms")
    public ResponseEntity<ApiResponse<Void>> update(@RequestHeader(value = HEADER, required = false) String token,
                                                    @RequestBody ThesaurusTermUpdateRequest request) {
        access.verify(token);
        service.update(request);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @DeleteMapping("/terms")
    public ResponseEntity<ApiResponse<Void>> delete(@RequestHeader(value = HEADER, required = false) String token,
                                                    @RequestParam(defaultValue = "") String code) {
        access.verify(token);
        service.delete(code);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @PostMapping("/terms/level3-code")
    public ResponseEntity<ApiResponse<Level3CodeResponse>> openLevelThree(
            @RequestHeader(value = HEADER, required = false) String token,
            @RequestBody Level3CodeRequest request) {
        access.verify(token);
        return ResponseEntity.ok(ApiResponse.success(service.openLevelThree(request.parentCode())));
    }
}
