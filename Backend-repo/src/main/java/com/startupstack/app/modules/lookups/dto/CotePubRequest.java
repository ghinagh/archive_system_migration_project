package com.startupstack.app.modules.lookups.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record CotePubRequest(
        @NotNull Double ctpNo,
        @Size(max = 40) String ctpNam
) {}
