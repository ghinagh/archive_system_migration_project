package com.startupstack.app.modules.formthesaurus.controller;

import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileEdit;
import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileRow;
import com.startupstack.app.modules.formthesaurus.service.AdditionalFilesService;
import com.startupstack.app.shared.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * tmp_file.frm ("ملفات اضافية للترميز" / "الملفات الاضافية للادخال") is one window opened from two
 * places: Form2's Command8 (the analysis screen, no key) and coding.frm's Command7 (behind the
 * المكنز الشكلي key). These are the same calls as /api/form-thesaurus/additional-files without the
 * thesaurus key, so the analysis screen can open the window the way legacy does.
 */
@RestController
@RequestMapping("/api/additional-files")
public class AdditionalFilesController {

    private final AdditionalFilesService additionalFiles;

    public AdditionalFilesController(AdditionalFilesService additionalFiles) {
        this.additionalFiles = additionalFiles;
    }

    @PostMapping("/search")
    public ResponseEntity<ApiResponse<List<AdditionalFileRow>>> search(
            @RequestBody FormThesaurusController.AdditionalFilesSearch r) {
        return ResponseEntity.ok(ApiResponse.success(additionalFiles.search(r.criteria() == null ? List.of() : r.criteria())));
    }

    /** op_tmp Form2.Text1, box_user_no, today — Form2.Text1 is the analysed document's number. */
    @PostMapping("/op-tmp")
    public ResponseEntity<ApiResponse<Void>> opTmp(@RequestBody FormThesaurusController.OpTmpRequest r) {
        additionalFiles.insertOp(r.fileNo());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @PutMapping
    public ResponseEntity<ApiResponse<Void>> update(@RequestBody AdditionalFileEdit r) {
        additionalFiles.updateCell(r.original(), r.column(), r.value());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Void>> insert(@RequestBody AdditionalFileEdit r) {
        additionalFiles.insertRow(r.values() == null ? Map.of() : r.values());
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @PostMapping("/delete")
    public ResponseEntity<ApiResponse<Void>> delete(@RequestBody AdditionalFileEdit r) {
        additionalFiles.deleteRow(r.original());
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
