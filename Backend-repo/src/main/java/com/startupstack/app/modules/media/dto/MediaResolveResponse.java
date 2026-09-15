package com.startupstack.app.modules.media.dto;

public record MediaResolveResponse(
        String resolvedPath,
        boolean fileExists
) {}
