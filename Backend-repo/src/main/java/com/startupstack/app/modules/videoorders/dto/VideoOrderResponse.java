package com.startupstack.app.modules.videoorders.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class VideoOrderResponse {

    private UUID id;
    private String orderNo;
    private String stockNo;
    private Integer chartId;
    private String description;
    private String requestedBy;
    private LocalDateTime requestDate;
    private String status;
    private boolean mediaAvailable;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
