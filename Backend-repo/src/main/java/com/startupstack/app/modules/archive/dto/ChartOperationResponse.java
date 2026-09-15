package com.startupstack.app.modules.archive.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ChartOperationResponse {

    private Integer id;
    private String oprNo;
    private Double serial;
    private String chartNo;
    private String subject;
    private LocalDateTime date;
    private String time;
    private String fromSite;
    private String fromPerson;
    private String toSite;
    private String toPerson;
    private LocalDateTime returnDate;
    private String remark;
    private String title;
    private Boolean transferred;
    private String choice;
    private String externalCode;
}
