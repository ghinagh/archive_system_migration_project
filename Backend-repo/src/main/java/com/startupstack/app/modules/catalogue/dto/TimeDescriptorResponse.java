package com.startupstack.app.modules.catalogue.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TimeDescriptorResponse {

    private String appNo;
    private String serNo;
    private String rltvNo;
    private String descNo;
    private Double startHour;
    private Double startMinute;
    private Double startSecond;
    private Double endHour;
    private Double endMinute;
    private Double endSecond;
}
