package com.startupstack.app.modules.digitization.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class DemandResponse {

    private Integer id;
    private String demandNo;
    private Integer serial;
    private String userNo;
    private String userName;
    private LocalDateTime date;
    private BigDecimal inputSize;
    private BigDecimal outputSize;
    private String path;
    private BigDecimal time;
    private String machineNo;
    private String catalogueTitle;
    private String description;
    private Integer checked;
    private String machineStock;
    private Integer seconds;
    private Integer minutes;
    private Integer hours;
    private Integer frames;
    private String cote;
    private String time1;
    private Boolean checked1;
}
