package com.startupstack.app.modules.configusers.controller;

import com.startupstack.app.modules.configusers.dto.AccessGrantResponse;
import com.startupstack.app.modules.configusers.dto.AccessKeyRequest;
import com.startupstack.app.modules.configusers.dto.FieldRow;
import com.startupstack.app.modules.configusers.dto.FormTypeRow;
import com.startupstack.app.modules.configusers.dto.RangeRow;
import com.startupstack.app.modules.configusers.service.ConfigUsersAccessService;
import com.startupstack.app.modules.configusers.service.ConfigUsersService;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.function.Supplier;

import static com.startupstack.app.modules.configusers.service.ConfigUsersAccessService.HEADER;

/**
 * Endpoints of "معالجة المستخدمين" (legacy config_users.frm). Everything but the key check itself
 * requires the grant issued for the ARCHIVE.frm Frame3 key 261015. Like legacy, no user-level check.
 */
@RestController
@RequestMapping("/api/config-users")
public class ConfigUsersController {

    private final ConfigUsersService service;
    private final ConfigUsersAccessService access;

    public ConfigUsersController(ConfigUsersService service, ConfigUsersAccessService access) {
        this.service = service;
        this.access = access;
    }

    public record UserCellEdit(Map<String, Object> original, String column, String text) {}

    public record FieldCellEdit(FieldRow row, String column, String text) {}

    public record RangeCellEdit(Integer rjpNo, String column, String text) {}

    public record UserFieldsRequest(String userNo, String formType) {}

    private <T> ResponseEntity<ApiResponse<T>> ok(String token, Supplier<T> body) {
        access.verify(token);
        return ResponseEntity.ok(ApiResponse.success(body.get()));
    }

    private ResponseEntity<ApiResponse<Void>> done(String token, Runnable action) {
        access.verify(token);
        action.run();
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // ─── access (ARCHIVE.frm Frame3) ───

    @PostMapping("/access")
    public ResponseEntity<ApiResponse<AccessGrantResponse>> grantAccess(@RequestBody AccessKeyRequest request) {
        return ResponseEntity.ok(ApiResponse.success(access.grant(request.key())));
    }

    @DeleteMapping("/access")
    public ResponseEntity<ApiResponse<Void>> revokeAccess(@RequestHeader(value = HEADER, required = false) String token) {
        access.revoke(token);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // ─── m_ist_no ───

    @GetMapping("/form-types")
    public ResponseEntity<ApiResponse<List<FormTypeRow>>> formTypes(@RequestHeader(value = HEADER, required = false) String token) {
        return ok(token, service::formTypes);
    }

    // ─── DataGrid1 ───

    @GetMapping("/users")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> users(@RequestHeader(value = HEADER, required = false) String token) {
        return ok(token, service::users);
    }

    @PutMapping("/users")
    public ResponseEntity<ApiResponse<Void>> updateUser(@RequestHeader(value = HEADER, required = false) String token,
                                                       @RequestBody UserCellEdit edit) {
        return done(token, () -> service.updateUser(edit.original(), edit.column(), edit.text()));
    }

    @PostMapping("/users")
    public ResponseEntity<ApiResponse<Void>> insertUser(@RequestHeader(value = HEADER, required = false) String token,
                                                       @RequestBody Map<String, String> values) {
        return done(token, () -> service.insertUser(values));
    }

    @PostMapping("/users/delete")
    public ResponseEntity<ApiResponse<Void>> deleteUser(@RequestHeader(value = HEADER, required = false) String token,
                                                       @RequestBody Map<String, Object> original) {
        return done(token, () -> service.deleteUser(original));
    }

    // ─── DataGrid3 ───

    @GetMapping("/fields")
    public ResponseEntity<ApiResponse<List<FieldRow>>> fields(@RequestHeader(value = HEADER, required = false) String token,
                                                              @RequestParam(required = false) String userNo,
                                                              @RequestParam(required = false) String formType,
                                                              @RequestParam(defaultValue = "false") boolean all) {
        return ok(token, () -> all ? service.allFields() : service.userFields(userNo, formType));
    }

    @PostMapping("/fields/create")
    public ResponseEntity<ApiResponse<Integer>> createFields(@RequestHeader(value = HEADER, required = false) String token,
                                                             @RequestBody UserFieldsRequest request) {
        return ok(token, () -> service.createFields(request.userNo(), request.formType()));
    }

    @PostMapping("/fields/delete")
    public ResponseEntity<ApiResponse<Integer>> deleteFields(@RequestHeader(value = HEADER, required = false) String token,
                                                             @RequestBody UserFieldsRequest request) {
        return ok(token, () -> service.deleteFields(request.userNo(), request.formType()));
    }

    @PutMapping("/fields")
    public ResponseEntity<ApiResponse<Void>> updateField(@RequestHeader(value = HEADER, required = false) String token,
                                                        @RequestBody FieldCellEdit edit) {
        return done(token, () -> service.updateField(edit.row(), edit.column(), edit.text()));
    }

    // ─── DataGrid2 ───

    @GetMapping("/ranges")
    public ResponseEntity<ApiResponse<List<RangeRow>>> ranges(@RequestHeader(value = HEADER, required = false) String token) {
        return ok(token, service::ranges);
    }

    @PutMapping("/ranges")
    public ResponseEntity<ApiResponse<Void>> updateRange(@RequestHeader(value = HEADER, required = false) String token,
                                                        @RequestBody RangeCellEdit edit) {
        return done(token, () -> service.updateRange(edit.rjpNo(), edit.column(), edit.text()));
    }

    @PostMapping("/ranges")
    public ResponseEntity<ApiResponse<Void>> insertRange(@RequestHeader(value = HEADER, required = false) String token,
                                                        @RequestBody Map<String, String> values) {
        return done(token, () -> service.insertRange(values));
    }

    @DeleteMapping("/ranges/{rjpNo}")
    public ResponseEntity<ApiResponse<Void>> deleteRange(@RequestHeader(value = HEADER, required = false) String token,
                                                        @PathVariable Integer rjpNo) {
        return done(token, () -> service.deleteRange(rjpNo));
    }
}
