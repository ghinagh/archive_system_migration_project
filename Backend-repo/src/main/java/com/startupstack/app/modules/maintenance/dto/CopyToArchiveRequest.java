package com.startupstack.app.modules.maintenance.dto;

import jakarta.validation.constraints.NotBlank;

public record CopyToArchiveRequest(
        @NotBlank String stockNo
) {}
