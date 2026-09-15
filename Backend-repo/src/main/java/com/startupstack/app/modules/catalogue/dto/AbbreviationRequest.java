package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record AbbreviationRequest(
        @NotBlank @Size(max = 2) String relSerNo,
        @NotBlank @Size(max = 2) String relRltvN,
        @Size(max = 9) String relDescN,
        @Size(max = 1) String relRltvT,
        @Size(max = 9) String relRelNo
) {}
