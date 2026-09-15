package com.startupstack.app.modules.retrievalfields.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class RetrievalFieldResponse {

    private UUID id;
    private String module;
    private String fieldKey;
    private String entityPath;
    private String fieldType;
    private String label;
    private boolean enabled;
    private String joinPath;
    private String category;
    private boolean lookupEnabled;
    private int displayOrder;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
