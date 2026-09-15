package com.startupstack.app.modules.sites.dto;

import java.time.LocalDateTime;

public record RelFormResponse(
        String form1No,
        String form2No,
        String form2Name,
        LocalDateTime rlfDte,
        LocalDateTime rlfDte1,
        String rlfRel
) {}
