package com.startupstack.app.modules.retrievalbuild.controller;

import com.startupstack.app.modules.admin.dto.BackupResponse;
import com.startupstack.app.modules.admin.service.AdminService;
import com.startupstack.app.modules.retrievalbuild.repository.RetrievalBuildRepository;
import com.startupstack.app.modules.retrievalbuild.service.RetrievalBuildAccessService;
import com.startupstack.app.modules.retrievalbuild.service.RetrievalBuildAccessService.Gate;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
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

/**
 * ARCHIVE.frm الترميز menu items that work on the retrieval-field tables:
 * m9 "ملف بناء الاسترجاعات" (Form4), M32 "معالجة حقول الاسترجاع" (CAT_OUTFRM) and
 * m33 "نسخ قاعدة البيانات". None of them checks the user; m9 and M32 ask for their key.
 */
@RestController
@RequestMapping("/api/retrieval-build")
public class RetrievalBuildController {

    private static final String H = RetrievalBuildAccessService.HEADER;

    private final RetrievalBuildAccessService access;
    private final RetrievalBuildRepository repo;
    private final AdminService adminService;

    public RetrievalBuildController(RetrievalBuildAccessService access, RetrievalBuildRepository repo,
                                    AdminService adminService) {
        this.access = access;
        this.repo = repo;
        this.adminService = adminService;
    }

    public record AccessRequest(Gate gate, String key) {}
    public record Form4Cell(String table, int auto, String column, String text) {}
    public record Cell(String column, String text) {}
    public record CategoryRequest(String category) {}

    @PostMapping("/access")
    public ResponseEntity<ApiResponse<Map<String, String>>> grant(@RequestBody AccessRequest r) {
        return ResponseEntity.ok(ApiResponse.success(Map.of("token", access.grant(r.gate(), r.key()))));
    }

    @DeleteMapping("/access")
    public ResponseEntity<ApiResponse<Void>> revoke(@RequestHeader(value = H, required = false) String token) {
        access.revoke(token);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // ---------------- Form4 ----------------

    @GetMapping("/form4/{table}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> form4(@RequestHeader(value = H, required = false) String token,
                                                                 @PathVariable String table) {
        access.verify(Gate.FORM4, token);
        String[] t = RetrievalBuildRepository.FORM4_TABLES.get(table);
        Map<String, Object> body = Map.of(
                "columns", t == null ? List.of() : List.copyOf(repo.columns(t[1]).keySet()),
                "rows", repo.form4Rows(table));
        return ResponseEntity.ok(ApiResponse.success(body));
    }

    @Transactional
    @PutMapping("/form4/cell")
    public ResponseEntity<ApiResponse<Void>> form4Cell(@RequestHeader(value = H, required = false) String token,
                                                       @RequestBody Form4Cell c) {
        access.verify(Gate.FORM4, token);
        repo.form4Update(c.table(), c.auto(), c.column(), c.text());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // ---------------- CAT_OUTFRM ----------------

    @GetMapping("/cat-out/fields")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> fields(@RequestHeader(value = H, required = false) String token,
                                                                         @RequestParam(defaultValue = "ALL") String filter) {
        access.verify(Gate.CAT_OUT, token);
        return ResponseEntity.ok(ApiResponse.success(repo.fields(filter)));
    }

    @Transactional
    @PutMapping("/cat-out/fields/{outNum}")
    public ResponseEntity<ApiResponse<Void>> updateField(@RequestHeader(value = H, required = false) String token,
                                                         @PathVariable double outNum, @RequestBody Cell c) {
        access.verify(Gate.CAT_OUT, token);
        repo.updateField(outNum, c.column(), c.text());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Transactional
    @PostMapping("/cat-out/fields")
    public ResponseEntity<ApiResponse<Void>> insertField(@RequestHeader(value = H, required = false) String token,
                                                         @RequestBody Map<String, String> values) {
        access.verify(Gate.CAT_OUT, token);
        repo.insertField(values);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Transactional
    @DeleteMapping("/cat-out/fields/{outNum}")
    public ResponseEntity<ApiResponse<Void>> deleteField(@RequestHeader(value = H, required = false) String token,
                                                         @PathVariable double outNum) {
        access.verify(Gate.CAT_OUT, token);
        repo.deleteField(outNum);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Transactional
    @PutMapping("/cat-out/fields/{outNum}/category")
    public ResponseEntity<ApiResponse<Void>> fieldCategory(@RequestHeader(value = H, required = false) String token,
                                                           @PathVariable double outNum, @RequestBody CategoryRequest r) {
        access.verify(Gate.CAT_OUT, token);
        repo.updateFieldCategory(outNum, r.category());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @GetMapping("/cat-out/categories")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> categories(@RequestHeader(value = H, required = false) String token) {
        access.verify(Gate.CAT_OUT, token);
        return ResponseEntity.ok(ApiResponse.success(repo.categories()));
    }

    @GetMapping("/cat-out/categories/{catNo}/fields")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> categoryFields(@RequestHeader(value = H, required = false) String token,
                                                                                 @PathVariable String catNo) {
        access.verify(Gate.CAT_OUT, token);
        return ResponseEntity.ok(ApiResponse.success(repo.categoryFields(catNo)));
    }

    @Transactional
    @PostMapping("/cat-out/categories/{catNo}/fields")
    public ResponseEntity<ApiResponse<Void>> insertCategoryField(@RequestHeader(value = H, required = false) String token,
                                                                 @PathVariable String catNo) {
        access.verify(Gate.CAT_OUT, token);
        repo.insertCategoryField(catNo);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Transactional
    @PostMapping("/cat-out/categories/{catNo}/rows")
    public ResponseEntity<ApiResponse<Void>> insertCategoryRow(@RequestHeader(value = H, required = false) String token,
                                                               @PathVariable String catNo, @RequestBody Map<String, String> values) {
        access.verify(Gate.CAT_OUT, token);
        String no = values.get("cat_no");
        repo.insertCategoryRow(no == null || no.isEmpty() ? catNo : no, values.get("cat_num"));
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Transactional
    @PutMapping("/cat-out/category-fields/{auto}")
    public ResponseEntity<ApiResponse<Void>> updateCategoryField(@RequestHeader(value = H, required = false) String token,
                                                                 @PathVariable int auto, @RequestBody Cell c) {
        access.verify(Gate.CAT_OUT, token);
        repo.updateCategoryField(auto, c.column(), c.text());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @Transactional
    @DeleteMapping("/cat-out/category-fields/{auto}")
    public ResponseEntity<ApiResponse<Void>> deleteCategoryField(@RequestHeader(value = H, required = false) String token,
                                                                 @PathVariable int auto) {
        access.verify(Gate.CAT_OUT, token);
        repo.deleteCategoryField(auto);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // ---------------- m33 "نسخ قاعدة البيانات" ----------------

    /** m33_Click: BACKUP DATABASE … then MsgBox "انتهى الاقفال......." — any signed-in user, no key. */
    @PostMapping("/backup")
    public ResponseEntity<ApiResponse<BackupResponse>> backup() {
        return ResponseEntity.ok(ApiResponse.success(adminService.createBackup()));
    }
}
