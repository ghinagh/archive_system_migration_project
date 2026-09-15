package com.startupstack.app.modules.sites.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

public record SubjectLinkRequest(
        @NotBlank @Size(max = 9) String mcnzCode,
        LocalDateTime subDte,
        LocalDateTime subDte1,
        @Size(max = 2) String subRel
) {}
