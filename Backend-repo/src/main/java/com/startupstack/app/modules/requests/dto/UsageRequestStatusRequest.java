package com.startupstack.app.modules.requests.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UsageRequestStatusRequest {

    @NotBlank
    @Pattern(regexp = "PENDING|APPROVED|FULFILLED|REJECTED")
    private String status;
}
