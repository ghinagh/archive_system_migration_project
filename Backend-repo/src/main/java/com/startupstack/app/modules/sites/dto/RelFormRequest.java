package com.startupstack.app.modules.sites.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

public record RelFormRequest(
        @NotBlank @Size(max = 10) String form2No,
        LocalDateTime rlfDte,
        LocalDateTime rlfDte1,
        @Size(max = 2) String rlfRel
) {}
