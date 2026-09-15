package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DigitRequest {

    @NotBlank
    @Size(max = 7)
    private String docNo;

    @NotNull
    private Integer serial;

    @Size(max = 6)
    private String digitNo;

    @Size(max = 4)
    private String type;

    @Size(max = 2)
    private String type1;

    private Integer durationHours;
    private Integer durationMinutes;
    private Integer durationSeconds;
    private Integer durationHours1;
    private Integer durationMinutes1;
    private Integer durationSeconds1;

    private BigDecimal size;

    @Size(max = 6)
    private String chartNo;

    @Size(max = 6)
    private String newChartNo;

    @Size(max = 2)
    private String chartType;

    @Size(max = 10)
    private String chartGeo;

    private Integer choice;

    @Size(max = 8)
    private String chartNo1;

    @Size(max = 2)
    private String materialType;

    @Size(max = 3)
    private String highType;
}
