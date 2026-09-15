package com.startupstack.app.modules.videoorders.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class VideoOrderRequest {

    @NotBlank
    @Size(max = 20)
    private String orderNo;

    @NotBlank
    @Size(max = 6)
    private String stockNo;

    private Integer chartId;

    @Size(max = 200)
    private String description;

    @NotBlank
    @Size(max = 30)
    private String requestedBy;

    @NotNull
    private LocalDateTime requestDate;

    @Pattern(regexp = "PENDING|APPROVED|COMPLETED|CANCELLED")
    private String status;
}
