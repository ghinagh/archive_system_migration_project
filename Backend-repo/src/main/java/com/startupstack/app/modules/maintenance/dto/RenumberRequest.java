package com.startupstack.app.modules.maintenance.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record RenumberRequest(
        @NotBlank @Size(max = 7) String oldAppNo,
        @NotBlank @Size(max = 7) String newAppNo
) {}
