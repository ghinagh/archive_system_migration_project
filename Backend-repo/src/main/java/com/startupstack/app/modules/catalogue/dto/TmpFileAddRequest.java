package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

public record TmpFileAddRequest(
        @NotBlank @Size(max = 7) String tmpFadNo,
        @Size(max = 50) String tmpFileName,
        @Size(max = 50) String tmpRmrk,
        @Size(max = 30) String tmpMk,
        LocalDateTime tmpDate
) {}
