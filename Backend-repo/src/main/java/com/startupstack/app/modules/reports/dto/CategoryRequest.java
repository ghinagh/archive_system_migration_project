package com.startupstack.app.modules.reports.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record CategoryRequest(
        @Size(max = 2) String categoryNo,
        @NotNull Integer outputNum
) {}
