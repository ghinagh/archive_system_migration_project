package com.startupstack.app.modules.digitization.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DigitResponse {

    private String docNo;
    private Integer serial;
    private String catalogueTitle;
    private String digitNo;
    private String type;
    private String type1;
    private Integer durationHours;
    private Integer durationMinutes;
    private Integer durationSeconds;
    private Integer durationHours1;
    private Integer durationMinutes1;
    private Integer durationSeconds1;
    private BigDecimal size;
    private String chartNo;
    private String newChartNo;
    private String chartType;
    private String chartGeo;
    private Integer choice;
    private String chartNo1;
    private String materialType;
    private String highType;
}
