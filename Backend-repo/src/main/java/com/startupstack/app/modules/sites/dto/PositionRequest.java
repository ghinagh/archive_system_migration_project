package com.startupstack.app.modules.sites.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

public record PositionRequest(
        @NotBlank @Size(max = 10) String posNo,
        @Size(max = 60) String name,
        LocalDateTime recordDate
) {}
