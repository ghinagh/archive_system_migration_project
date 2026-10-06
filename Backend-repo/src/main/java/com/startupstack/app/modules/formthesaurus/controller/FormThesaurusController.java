package com.startupstack.app.modules.formthesaurus.controller;

import com.startupstack.app.modules.formthesaurus.dto.AccessGrantResponse;
import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileCriterion;
import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileEdit;
import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileRow;
import com.startupstack.app.modules.formthesaurus.dto.AccessKeyRequest;
import com.startupstack.app.modules.formthesaurus.dto.CodingRow;
import com.startupstack.app.modules.formthesaurus.dto.CodingWriteRequest;
import com.startupstack.app.modules.formthesaurus.dto.FormQuery;
import com.startupstack.app.modules.formthesaurus.dto.FormRelationRow;
import com.startupstack.app.modules.formthesaurus.dto.FormRow;
import com.startupstack.app.modules.formthesaurus.dto.FormThesaurusContext;
import com.startupstack.app.modules.formthesaurus.dto.FormWriteRequest;
import com.startupstack.app.modules.formthesaurus.dto.MacnzQuery;
import com.startupstack.app.modules.formthesaurus.dto.MacnzRow;
import com.startupstack.app.modules.formthesaurus.dto.NextNumberRequest;
import com.startupstack.app.modules.formthesaurus.dto.NextNumberResponse;
import com.startupstack.app.modules.formthesaurus.dto.PositionRow;
import com.startupstack.app.modules.formthesaurus.dto.PositionWriteRequest;
import com.startupstack.app.modules.formthesaurus.dto.RelationWriteRequest;
import com.startupstack.app.modules.formthesaurus.dto.SaveResult;
import com.startupstack.app.modules.formthesaurus.dto.SubjectRelationRow;
import com.startupstack.app.modules.formthesaurus.dto.WordsRequest;
import com.startupstack.app.modules.formthesaurus.service.AdditionalFilesService;
import com.startupstack.app.modules.formthesaurus.service.FormThesaurusAccessService;
import com.startupstack.app.modules.formthesaurus.service.FormThesaurusService;
import com.startupstack.app.shared.response.ApiResponse;
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

import static com.startupstack.app.modules.formthesaurus.service.FormThesaurusAccessService.HEADER;

/**
 * Endpoints of "المكنز الشكلي" (legacy coding.frm). Everything but the key check itself requires
 * the grant issued for the ARCHIVE.frm Frame3 key. Like coding.frm, no further user restriction.
 */
@RestController
@RequestMapping("/api/form-thesaurus")
public class FormThesaurusController {

    private final FormThesaurusService service;
    private final FormThesaurusAccessService access;
    private final AdditionalFilesService additionalFiles;

    public FormThesaurusController(FormThesaurusService service, FormThesaurusAccessService access,
                                   AdditionalFilesService additionalFiles) {
        this.service = service;
        this.access = access;
        this.additionalFiles = additionalFiles;
    }

    public record AdditionalFilesSearch(List<AdditionalFileCriterion> criteria) {}

    public record OpTmpRequest(String fileNo) {}

    private <T> ResponseEntity<ApiResponse<T>> ok(String token, java.util.function.Supplier<T> body) {
        access.verify(token);
        return ResponseEntity.ok(ApiResponse.success(body.get()));
    }

    private ResponseEntity<ApiResponse<Void>> done(String token, Runnable action) {
        access.verify(token);
        action.run();
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // ─── access ─────────────────────────────────────────────────────────

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
    public ResponseEntity<ApiResponse<FormThesaurusContext>> context(@RequestHeader(value = HEADER, required = false) String token) {
        return ok(token, service::context);
    }

    // ─── CODING ─────────────────────────────────────────────────────────

    @GetMapping("/coding")
    public ResponseEntity<ApiResponse<List<CodingRow>>> coding(@RequestHeader(value = HEADER, required = false) String token,
                                                               @RequestParam(required = false) String prefix) {
        return ok(token, () -> prefix == null ? service.codingLevelOne() : service.codingChildren(prefix));
    }

    @GetMapping("/coding/find")
    public ResponseEntity<ApiResponse<List<CodingRow>>> findCoding(@RequestHeader(value = HEADER, required = false) String token,
                                                                   @RequestParam(defaultValue = "") String code) {
        return ok(token, () -> service.findCoding(code));
    }

    @PostMapping("/coding")
    public ResponseEntity<ApiResponse<SaveResult>> insertCoding(@RequestHeader(value = HEADER, required = false) String token,
                                                                @RequestBody CodingWriteRequest r) {
        return ok(token, () -> service.insertCoding(r.code(), r.description(), r.level()));
    }

    @PutMapping("/coding")
    public ResponseEntity<ApiResponse<Void>> updateCoding(@RequestHeader(value = HEADER, required = false) String token,
                                                          @RequestBody CodingWriteRequest r) {
        return done(token, () -> service.updateCoding(r.code(), r.description()));
    }

    @DeleteMapping("/coding")
    public ResponseEntity<ApiResponse<Void>> deleteCoding(@RequestHeader(value = HEADER, required = false) String token,
                                                          @RequestParam(defaultValue = "") String code) {
        return done(token, () -> service.deleteCoding(code));
    }

    // ─── form ───────────────────────────────────────────────────────────

    @GetMapping("/forms")
    public ResponseEntity<ApiResponse<List<FormRow>>> forms(@RequestHeader(value = HEADER, required = false) String token,
                                                            @RequestParam FormQuery query,
                                                            @RequestParam(required = false) String type,
                                                            @RequestParam(required = false) String country,
                                                            @RequestParam(required = false) String text,
                                                            @RequestParam(required = false) Integer lent,
                                                            @RequestParam(required = false) String pays) {
        return ok(token, () -> service.forms(query, type, country, text, lent, pays));
    }

    @GetMapping("/forms/find")
    public ResponseEntity<ApiResponse<List<FormRow>>> findForm(@RequestHeader(value = HEADER, required = false) String token,
                                                               @RequestParam(defaultValue = "") String number,
                                                               @RequestParam(defaultValue = "") String type) {
        return ok(token, () -> service.findForm(number, type));
    }

    @PostMapping("/forms")
    public ResponseEntity<ApiResponse<SaveResult>> insertForm(@RequestHeader(value = HEADER, required = false) String token,
                                                              @RequestBody FormWriteRequest r) {
        return ok(token, () -> service.insertForm(r.description(), r.number(), r.type()));
    }

    @PutMapping("/forms")
    public ResponseEntity<ApiResponse<SaveResult>> updateForm(@RequestHeader(value = HEADER, required = false) String token,
                                                              @RequestBody FormWriteRequest r) {
        return ok(token, () -> service.updateForm(r.description(), r.number(), r.type()));
    }

    @DeleteMapping("/forms")
    public ResponseEntity<ApiResponse<Void>> deleteForm(@RequestHeader(value = HEADER, required = false) String token,
                                                        @RequestParam(defaultValue = "") String number,
                                                        @RequestParam(defaultValue = "") String type) {
        return done(token, () -> service.deleteForm(number, type));
    }

    @PostMapping("/forms/next-number")
    public ResponseEntity<ApiResponse<NextNumberResponse>> nextNumber(@RequestHeader(value = HEADER, required = false) String token,
                                                                      @RequestBody NextNumberRequest r) {
        return ok(token, () -> service.nextNumber(r.sub()));
    }

    @PutMapping("/words")
    public ResponseEntity<ApiResponse<Void>> replaceWords(@RequestHeader(value = HEADER, required = false) String token,
                                                          @RequestBody WordsRequest r) {
        return done(token, () -> service.replaceWords(r.code(), r.description()));
    }

    @PostMapping("/words")
    public ResponseEntity<ApiResponse<Void>> addWords(@RequestHeader(value = HEADER, required = false) String token,
                                                      @RequestBody WordsRequest r) {
        return done(token, () -> service.addWords(r.code(), r.description()));
    }

    // ─── POSITION ───────────────────────────────────────────────────────

    @GetMapping("/positions")
    public ResponseEntity<ApiResponse<List<PositionRow>>> positions(@RequestHeader(value = HEADER, required = false) String token,
                                                                    @RequestParam(defaultValue = "") String number) {
        return ok(token, () -> service.positions(number));
    }

    @PostMapping("/positions")
    public ResponseEntity<ApiResponse<Void>> insertPosition(@RequestHeader(value = HEADER, required = false) String token,
                                                            @RequestBody PositionWriteRequest r) {
        return done(token, () -> service.insertPosition(r.description(), r.number()));
    }

    @PutMapping("/positions")
    public ResponseEntity<ApiResponse<Void>> updatePosition(@RequestHeader(value = HEADER, required = false) String token,
                                                            @RequestBody PositionWriteRequest r) {
        return done(token, () -> service.updatePosition(r.description(), r.number(), r.oldDescription()));
    }

    @DeleteMapping("/positions")
    public ResponseEntity<ApiResponse<Void>> deletePosition(@RequestHeader(value = HEADER, required = false) String token,
                                                            @RequestParam(defaultValue = "") String number,
                                                            @RequestParam(defaultValue = "") String name) {
        return done(token, () -> service.deletePosition(number, name));
    }

    // ─── relations ──────────────────────────────────────────────────────

    @GetMapping("/relations/forms")
    public ResponseEntity<ApiResponse<List<FormRelationRow>>> formRelations(@RequestHeader(value = HEADER, required = false) String token,
                                                                            @RequestParam(defaultValue = "") String form,
                                                                            @RequestParam(defaultValue = "") String relation) {
        return ok(token, () -> service.formRelations(form, relation));
    }

    @PostMapping("/relations/forms")
    public ResponseEntity<ApiResponse<Void>> insertFormRelation(@RequestHeader(value = HEADER, required = false) String token,
                                                                @RequestBody RelationWriteRequest r) {
        return done(token, () -> service.insertFormRelation(r));
    }

    @PutMapping("/relations/forms/dates")
    public ResponseEntity<ApiResponse<Void>> formRelationDates(@RequestHeader(value = HEADER, required = false) String token,
                                                               @RequestBody RelationWriteRequest r) {
        return done(token, () -> service.updateFormRelationDates(r));
    }

    @DeleteMapping("/relations/forms")
    public ResponseEntity<ApiResponse<Void>> deleteFormRelation(@RequestHeader(value = HEADER, required = false) String token,
                                                                @RequestParam(defaultValue = "") String first,
                                                                @RequestParam(defaultValue = "") String second,
                                                                @RequestParam(defaultValue = "") String relation) {
        return done(token, () -> service.deleteFormRelation(first, second, relation));
    }

    @GetMapping("/relations/subjects")
    public ResponseEntity<ApiResponse<List<SubjectRelationRow>>> subjectRelations(@RequestHeader(value = HEADER, required = false) String token,
                                                                                  @RequestParam(defaultValue = "") String form,
                                                                                  @RequestParam(defaultValue = "") String relation) {
        return ok(token, () -> service.subjectRelations(form, relation));
    }

    @PostMapping("/relations/subjects")
    public ResponseEntity<ApiResponse<Void>> insertSubjectRelation(@RequestHeader(value = HEADER, required = false) String token,
                                                                   @RequestBody RelationWriteRequest r) {
        return done(token, () -> service.insertSubjectRelation(r));
    }

    @PutMapping("/relations/subjects/dates")
    public ResponseEntity<ApiResponse<Void>> subjectRelationDates(@RequestHeader(value = HEADER, required = false) String token,
                                                                  @RequestBody RelationWriteRequest r) {
        return done(token, () -> service.updateSubjectRelationDates(r));
    }

    @DeleteMapping("/relations/subjects")
    public ResponseEntity<ApiResponse<Void>> deleteSubjectRelation(@RequestHeader(value = HEADER, required = false) String token,
                                                                   @RequestParam(defaultValue = "") String first,
                                                                   @RequestParam(defaultValue = "") String second,
                                                                   @RequestParam(defaultValue = "") String relation) {
        return done(token, () -> service.deleteSubjectRelation(first, second, relation));
    }

    // ─── MACNZ picker ───────────────────────────────────────────────────

    @GetMapping("/macnz")
    public ResponseEntity<ApiResponse<List<MacnzRow>>> macnz(@RequestHeader(value = HEADER, required = false) String token,
                                                             @RequestParam(defaultValue = "ALL") MacnzQuery query,
                                                             @RequestParam(required = false) String text,
                                                             @RequestParam(required = false) Integer lent) {
        return ok(token, () -> service.macnz(query, text, lent));
    }

    // ─── "ملفات اضافية للادخال" (tmp_file.frm, opened by Command7) ───────

    @PostMapping("/additional-files/search")
    public ResponseEntity<ApiResponse<List<AdditionalFileRow>>> searchAdditionalFiles(
            @RequestHeader(value = HEADER, required = false) String token, @RequestBody AdditionalFilesSearch r) {
        return ok(token, () -> additionalFiles.search(r.criteria() == null ? List.of() : r.criteria()));
    }

    @PostMapping("/additional-files/op-tmp")
    public ResponseEntity<ApiResponse<Void>> opTmp(@RequestHeader(value = HEADER, required = false) String token,
                                                   @RequestBody OpTmpRequest r) {
        return done(token, () -> additionalFiles.insertOp(r.fileNo()));
    }

    @PutMapping("/additional-files")
    public ResponseEntity<ApiResponse<Void>> updateAdditionalFile(@RequestHeader(value = HEADER, required = false) String token,
                                                                  @RequestBody AdditionalFileEdit r) {
        return done(token, () -> additionalFiles.updateCell(r.original(), r.column(), r.value()));
    }

    @PostMapping("/additional-files")
    public ResponseEntity<ApiResponse<Void>> insertAdditionalFile(@RequestHeader(value = HEADER, required = false) String token,
                                                                  @RequestBody AdditionalFileEdit r) {
        return done(token, () -> additionalFiles.insertRow(r.values() == null ? java.util.Map.of() : r.values()));
    }

    @PostMapping("/additional-files/delete")
    public ResponseEntity<ApiResponse<Void>> deleteAdditionalFile(@RequestHeader(value = HEADER, required = false) String token,
                                                                  @RequestBody AdditionalFileEdit r) {
        return done(token, () -> additionalFiles.deleteRow(r.original()));
    }
}
