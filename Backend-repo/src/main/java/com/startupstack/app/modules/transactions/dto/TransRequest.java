package com.startupstack.app.modules.transactions.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class TransRequest {

    @NotNull
    private Double trsOpno;

    @NotNull
    private Double trsNo;

    private LocalDateTime trsDte;

    @Size(max = 5)
    private String trsNum;

    private Double trsNb;

    private Double trsYear;

    private Double trsTyp;

    private LocalDateTime trsDte1;
}
