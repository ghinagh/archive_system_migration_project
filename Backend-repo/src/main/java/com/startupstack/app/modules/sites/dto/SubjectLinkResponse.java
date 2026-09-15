package com.startupstack.app.modules.sites.dto;

import java.time.LocalDateTime;

public record SubjectLinkResponse(
        String formNo,
        String mcnzCode,
        String mcnzDesc,
        LocalDateTime subDte,
        LocalDateTime subDte1,
        String subRel
) {}
