package com.startupstack.app.modules.persons.dto;

import java.time.LocalDateTime;

public record PostAssignmentResponse(
        String serial,
        String siteDescription,
        Integer type,
        LocalDateTime startDate,
        LocalDateTime endDate,
        Integer status,
        String level,
        String positionNo,
        String positionName
) {}
