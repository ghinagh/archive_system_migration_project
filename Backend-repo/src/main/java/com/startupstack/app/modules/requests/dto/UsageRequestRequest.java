package com.startupstack.app.modules.requests.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class UsageRequestRequest {

    @NotBlank
    @Size(max = 20)
    private String requestNo;

    @Size(max = 10)
    private String digitizationType;

    @Size(max = 20)
    private String digitizationNo;

    @Size(max = 20)
    private String permitNo;

    @NotBlank
    @Size(max = 100)
    private String requester;

    @Size(max = 50)
    private String cote;

    @NotNull
    private LocalDateTime requestDate;

    @Pattern(regexp = "PENDING|APPROVED|FULFILLED|REJECTED")
    private String status;
}
