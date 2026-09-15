package com.startupstack.app.modules.catalogue.dto;

import java.time.LocalDateTime;

public record DateSubjectResponse(
        String appNo,
        String dteSerNo,
        String dteRelNo,
        String dteDescNo,
        LocalDateTime dteDteDeb,
        LocalDateTime dteDteFin
) {}
