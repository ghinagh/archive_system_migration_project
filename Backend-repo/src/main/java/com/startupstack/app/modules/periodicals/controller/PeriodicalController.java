package com.startupstack.app.modules.periodicals.controller;

import com.startupstack.app.modules.periodicals.dto.PeriodicalRequest;
import com.startupstack.app.modules.periodicals.dto.PeriodicalResponse;
import com.startupstack.app.modules.periodicals.service.PeriodicalService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
@RequestMapping("/api/periodicals")
public class PeriodicalController {

    private final PeriodicalService periodicalService;

    public PeriodicalController(PeriodicalService periodicalService) {
        this.periodicalService = periodicalService;
    }

    @GetMapping("/all")
    public ResponseEntity<ApiResponse<List<PeriodicalResponse>>> getAllPeriodicals() {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.getAllPeriodicals()));
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<PeriodicalResponse>>> searchPeriodicals(
            @RequestParam(required = false) String q) {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.searchByNameContains(q)));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<PeriodicalResponse>>> getAll(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String lang,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.findAll(name, lang, pageable)));
    }

    @GetMapping("/next-no")
    public ResponseEntity<ApiResponse<Double>> getNextPerNo() {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.nextPerNo()));
    }

    @GetMapping("/{perNo}")
    public ResponseEntity<ApiResponse<PeriodicalResponse>> getById(@PathVariable Double perNo) {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.findById(perNo)));
    }

    @GetMapping("/{perNo}/next")
    public ResponseEntity<ApiResponse<PeriodicalResponse>> getNext(@PathVariable Double perNo) {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.findNext(perNo)));
    }

    @GetMapping("/{perNo}/previous")
    public ResponseEntity<ApiResponse<PeriodicalResponse>> getPrevious(@PathVariable Double perNo) {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.findPrevious(perNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<PeriodicalResponse>> create(@Valid @RequestBody PeriodicalRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(periodicalService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{perNo}")
    public ResponseEntity<ApiResponse<PeriodicalResponse>> update(
            @PathVariable Double perNo,
            @Valid @RequestBody PeriodicalRequest request) {
        return ResponseEntity.ok(ApiResponse.success(periodicalService.update(perNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{perNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Double perNo) {
        periodicalService.delete(perNo);
        return ResponseEntity.ok(ApiResponse.error("Periodical deleted successfully"));
    }
}
