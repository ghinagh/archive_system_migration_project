package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record Text1Request(
        @NotBlank @Size(max = 2) String txtSerNo,
        @Size(max = 9) String txtDescN,
        @Size(max = 2) String txtRltvN,
        @Size(max = 1) String txtRltvTyp,
        @Size(max = 4000) String txtText,
        Integer txtNbpage
) {}
