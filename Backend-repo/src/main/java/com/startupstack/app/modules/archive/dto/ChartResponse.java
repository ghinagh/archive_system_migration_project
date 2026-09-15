package com.startupstack.app.modules.archive.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ChartResponse {

    private Integer id;
    private String chaNo;
    private String subject;
    private Double type;
    private Double time;
    private LocalDateTime date;
    private Double number;
    private Double type1;
    private String source;
    private LocalDateTime date1;
    private String title;
    private Double stock;
    private Double nbDis;
    private String subjectCode;
    private String fromSite;
    private String toSite;
    private String fromPerson;
    private String toPerson;
    private String operationNo;
    private String timeCode;
}
