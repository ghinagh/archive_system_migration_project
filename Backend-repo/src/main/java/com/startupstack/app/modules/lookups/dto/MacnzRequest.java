package com.startupstack.app.modules.lookups.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record MacnzRequest(
        @NotBlank @Size(max = 9) String code,
        @NotBlank @Size(max = 1) String level,
        @NotBlank @Size(max = 40) String description
) {}
