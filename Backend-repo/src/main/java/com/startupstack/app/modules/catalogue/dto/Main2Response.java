package com.startupstack.app.modules.catalogue.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record Main2Response(
        String appNo,
        String activeTitleAr,
        String activeCode,
        String additionalTitle,
        String additionalCode,
        String dataEntry,
        String appDoc,
        LocalDateTime entryDate,
        LocalDateTime writeDate,
        String appRevision,
        String chartNo,
        Integer startHours,
        Integer startMinutes,
        Integer startSeconds,
        Integer endHours,
        Integer endMinutes,
        Integer endSeconds,
        BigDecimal size,
        String type,
        String pictureCode,
        String voiceCode,
        String result
) {}
