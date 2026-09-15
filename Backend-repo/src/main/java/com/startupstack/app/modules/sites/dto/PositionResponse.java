package com.startupstack.app.modules.sites.dto;

import java.time.LocalDateTime;

public record PositionResponse(
        String posNo,
        String name,
        LocalDateTime recordDate
) {}
