package com.startupstack.app.modules.users.controller;

import com.startupstack.app.modules.users.dto.ChangePasswordRequest;
import com.startupstack.app.modules.users.dto.LoginRequest;
import com.startupstack.app.modules.users.dto.LoginResponse;
import com.startupstack.app.modules.users.dto.UserRequest;
import com.startupstack.app.modules.users.dto.UserResponse;
import com.startupstack.app.modules.users.service.UserService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

import java.util.Map;

@RestController
@RequestMapping("/api")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/auth/login")
    public ResponseEntity<ApiResponse<LoginResponse>> login(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = userService.login(request);
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    @PostMapping("/auth/change-password")
    public ResponseEntity<ApiResponse<LoginResponse>> changePassword(
            @RequestHeader("X-OTP-Token") String otpToken,
            @Valid @RequestBody ChangePasswordRequest request) {
        LoginResponse response = userService.changePassword(otpToken, request);
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    @PostMapping("/admin/migrate-passwords")
    public ResponseEntity<ApiResponse<Map<String, Integer>>> migratePasswords() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int count = userService.migratePasswords(auth.getName());
        return ResponseEntity.ok(ApiResponse.success(Map.of("migratedCount", count)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping("/users")
    public ResponseEntity<ApiResponse<Page<UserResponse>>> getAll(
            @RequestParam(required = false) String level,
            @RequestParam(required = false) String entity,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(userService.findAll(level, entity, pageable)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @GetMapping("/users/{userNo}")
    public ResponseEntity<ApiResponse<UserResponse>> getById(@PathVariable String userNo) {
        return ResponseEntity.ok(ApiResponse.success(userService.findById(userNo)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @PostMapping("/users")
    public ResponseEntity<ApiResponse<UserResponse>> create(@Valid @RequestBody UserRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(userService.create(request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @PutMapping("/users/{userNo}")
    public ResponseEntity<ApiResponse<UserResponse>> update(
            @PathVariable String userNo,
            @Valid @RequestBody UserRequest request) {
        return ResponseEntity.ok(ApiResponse.success(userService.update(userNo, request)));
    }

    @Permission(PermissionConstants.PERM_ADMIN)
    @DeleteMapping("/users/{userNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String userNo) {
        userService.delete(userNo);
        return ResponseEntity.ok(ApiResponse.error("User deleted successfully"));
    }
}
