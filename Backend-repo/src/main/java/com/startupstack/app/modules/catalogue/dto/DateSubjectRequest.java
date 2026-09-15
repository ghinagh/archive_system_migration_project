package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

public record DateSubjectRequest(
        @NotBlank @Size(max = 2) String dteSerNo,
        @NotBlank @Size(max = 2) String dteRelNo,
        @Size(max = 9) String dteDescNo,
        LocalDateTime dteDteDeb,
        LocalDateTime dteDteFin
) {}
