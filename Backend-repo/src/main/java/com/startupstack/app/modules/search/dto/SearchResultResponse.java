package com.startupstack.app.modules.search.dto;

public record SearchResultResponse(
        String appNo,
        String title,
        String typeBadge,
        String route
) {}
