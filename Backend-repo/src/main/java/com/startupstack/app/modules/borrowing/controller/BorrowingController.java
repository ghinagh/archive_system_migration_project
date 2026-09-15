package com.startupstack.app.modules.borrowing.controller;

import com.startupstack.app.modules.borrowing.dto.BorrowingBookRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingBookResponse;
import com.startupstack.app.modules.borrowing.dto.BorrowingOtherRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingOtherResponse;
import com.startupstack.app.modules.borrowing.dto.BorrowingRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingResponse;
import com.startupstack.app.modules.borrowing.dto.ReturnRequest;
import com.startupstack.app.modules.borrowing.service.BorrowingService;
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
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/borrowing")
public class BorrowingController {

    private final BorrowingService borrowingService;

    public BorrowingController(BorrowingService borrowingService) {
        this.borrowingService = borrowingService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<BorrowingResponse>>> getAll(
            @RequestParam(required = false) String personNo,
            @RequestParam(required = false) Double borrowingType,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateFrom,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateTo,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(
                borrowingService.findAll(personNo, borrowingType, dateFrom, dateTo, pageable)));
    }

    @GetMapping("/lookup")
    public ResponseEntity<ApiResponse<BorrowingResponse>> getById(
            @RequestParam String iarNo,
            @RequestParam Double serial,
            @RequestParam Double borrowingType) {
        return ResponseEntity.ok(ApiResponse.success(
                borrowingService.findById(iarNo, serial, borrowingType)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<BorrowingResponse>> create(
            @Valid @RequestBody BorrowingRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(borrowingService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping
    public ResponseEntity<ApiResponse<BorrowingResponse>> update(
            @RequestParam String iarNo,
            @RequestParam Double serial,
            @RequestParam Double borrowingType,
            @Valid @RequestBody BorrowingRequest request) {
        return ResponseEntity.ok(ApiResponse.success(
                borrowingService.update(iarNo, serial, borrowingType, request)));
    }

    @Permission(PermissionConstants.PERM_BORROW)
    @PatchMapping("/return")
    public ResponseEntity<ApiResponse<BorrowingResponse>> returnBorrowing(
            @RequestParam String iarNo,
            @RequestParam Double serial,
            @RequestParam Double borrowingType,
            @Valid @RequestBody ReturnRequest request) {
        return ResponseEntity.ok(ApiResponse.success(
                borrowingService.returnBorrowing(iarNo, serial, borrowingType, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping
    public ResponseEntity<ApiResponse<Void>> delete(
            @RequestParam String iarNo,
            @RequestParam Double serial,
            @RequestParam Double borrowingType) {
        borrowingService.delete(iarNo, serial, borrowingType);
        return ResponseEntity.ok(ApiResponse.error("Borrowing deleted successfully"));
    }

    @GetMapping("/{iarNo}/books")
    public ResponseEntity<ApiResponse<List<BorrowingBookResponse>>> getBooks(@PathVariable String iarNo) {
        return ResponseEntity.ok(ApiResponse.success(borrowingService.findBooksByBorrowingNo(iarNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{iarNo}/books")
    public ResponseEntity<ApiResponse<BorrowingBookResponse>> addBook(
            @PathVariable String iarNo,
            @Valid @RequestBody BorrowingBookRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(borrowingService.addBook(iarNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{iarNo}/books/{iabSer}")
    public ResponseEntity<ApiResponse<Void>> removeBook(
            @PathVariable String iarNo,
            @PathVariable Double iabSer) {
        borrowingService.removeBook(iarNo, iabSer);
        return ResponseEntity.ok(ApiResponse.error("Book removed from borrowing successfully"));
    }

    @GetMapping("/{iarNo}/others")
    public ResponseEntity<ApiResponse<List<BorrowingOtherResponse>>> getOthers(@PathVariable String iarNo) {
        return ResponseEntity.ok(ApiResponse.success(borrowingService.findOthersByBorrowingNo(iarNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping("/{iarNo}/others")
    public ResponseEntity<ApiResponse<BorrowingOtherResponse>> addOther(
            @PathVariable String iarNo,
            @Valid @RequestBody BorrowingOtherRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(borrowingService.addOther(iarNo, request)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{iarNo}/others/{iaoSer}")
    public ResponseEntity<ApiResponse<Void>> removeOther(
            @PathVariable String iarNo,
            @PathVariable Double iaoSer) {
        borrowingService.removeOther(iarNo, iaoSer);
        return ResponseEntity.ok(ApiResponse.error("Other item removed from borrowing successfully"));
    }
}
