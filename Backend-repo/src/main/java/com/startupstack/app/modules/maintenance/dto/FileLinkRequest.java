package com.startupstack.app.modules.maintenance.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record FileLinkRequest(
        @NotBlank @Size(max = 7) String appNo,
        @NotBlank @Size(max = 255) String filePath
) {}
