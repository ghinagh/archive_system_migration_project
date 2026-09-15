package com.startupstack.app.modules.search.dto;

import java.time.LocalDateTime;

public record PublicSearchResult(
        String id,
        String title,
        String additionalTitle,
        String type,
        LocalDateTime date
) {}
