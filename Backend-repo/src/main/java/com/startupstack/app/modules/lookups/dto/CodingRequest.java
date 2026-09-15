package com.startupstack.app.modules.lookups.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CodingRequest(
        @NotBlank @Size(max = 2) String level,
        @NotBlank @Size(max = 9) String code,
        @Size(max = 40) String description
) {}
