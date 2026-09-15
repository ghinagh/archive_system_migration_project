package com.startupstack.app.modules.users.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record ChangePasswordRequest(
        @NotBlank @Size(min = 6, max = 72) String newPassword,
        @NotBlank String confirmPassword
) {}
