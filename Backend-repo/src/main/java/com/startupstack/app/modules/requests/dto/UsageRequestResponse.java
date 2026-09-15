package com.startupstack.app.modules.requests.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class UsageRequestResponse {

    private UUID id;
    private String requestNo;
    private String digitizationType;
    private String digitizationNo;
    private String permitNo;
    private String requester;
    private String cote;
    private LocalDateTime requestDate;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
