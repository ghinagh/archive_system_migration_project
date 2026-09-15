package com.startupstack.app.modules.transactions.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class TransResponse {

    private Double trsOpno;
    private Double trsNo;
    private LocalDateTime trsDte;
    private String trsNum;
    private Double trsNb;
    private Double trsYear;
    private Double trsTyp;
    private LocalDateTime trsDte1;
}
