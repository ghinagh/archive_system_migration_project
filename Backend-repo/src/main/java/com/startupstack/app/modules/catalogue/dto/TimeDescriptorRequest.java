package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record TimeDescriptorRequest(
        @NotBlank @Size(max = 2) String tmSerNo,
        @NotBlank @Size(max = 2) String tmRltvNo,
        @Size(max = 9) String tmDescNo,
        Double tmO,
        Double tmM,
        Double tmS,
        Double tmO1,
        Double tmM1,
        Double tmS1
) {}
