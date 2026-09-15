package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

public record Main2Request(
        @Size(max = 6) String chartNo,
        Integer startHours,
        Integer startMinutes,
        Integer startSeconds,
        Integer endHours,
        Integer endMinutes,
        Integer endSeconds,
        BigDecimal size,
        @Size(max = 1) String type,
        @Size(max = 2) String pictureCode,
        @Size(max = 2) String voiceCode,
        @Size(max = 500) String result
) {}
