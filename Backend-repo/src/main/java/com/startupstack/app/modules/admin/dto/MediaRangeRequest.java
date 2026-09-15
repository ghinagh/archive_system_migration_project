package com.startupstack.app.modules.admin.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record MediaRangeRequest(
        @NotBlank @Size(max = 10) String noFrom,
        @NotBlank @Size(max = 10) String noTo,
        @NotBlank @Size(max = 200) String path,
        Integer typ
) {}
