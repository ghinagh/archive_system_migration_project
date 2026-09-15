package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class DemandRequest {

    @NotBlank
    @Size(max = 7)
    private String demandNo;

    @NotNull
    private Integer serial;

    @Size(max = 3)
    private String userNo;

    private LocalDateTime date;

    private BigDecimal inputSize;
    private BigDecimal outputSize;

    @Size(max = 100)
    private String path;

    private BigDecimal time;

    @Size(max = 7)
    private String machineNo;

    @Size(max = 100)
    private String description;

    private Integer checked;

    @Size(max = 6)
    private String machineStock;

    private Integer seconds;
    private Integer minutes;
    private Integer hours;
    private Integer frames;

    @Size(max = 50)
    private String cote;

    @Size(max = 12)
    private String time1;

    private Boolean checked1;
}
