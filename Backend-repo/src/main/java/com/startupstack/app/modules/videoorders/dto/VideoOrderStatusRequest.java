package com.startupstack.app.modules.videoorders.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VideoOrderStatusRequest {

    @NotBlank
    @Pattern(regexp = "PENDING|APPROVED|COMPLETED|CANCELLED")
    private String status;
}
