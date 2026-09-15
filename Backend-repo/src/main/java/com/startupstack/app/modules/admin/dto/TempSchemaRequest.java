package com.startupstack.app.modules.admin.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record TempSchemaRequest(
        @NotBlank @Size(max = 10) String fieldName,
        @Size(max = 1) String fieldType,
        Double fieldLen,
        Double fieldDec
) {}
