package com.startupstack.app.modules.corrections.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class CorrectionLogResponse {

    private UUID id;
    private String appNo;
    private LocalDateTime correctedAt;
    private String correctedByUser;
    private String fieldName;
    private String oldValue;
    private String newValue;
    private String correctionReason;
}
