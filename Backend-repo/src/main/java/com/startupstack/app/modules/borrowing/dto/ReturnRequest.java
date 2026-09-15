package com.startupstack.app.modules.borrowing.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReturnRequest {

    @NotNull
    private LocalDateTime returnDate;
}
