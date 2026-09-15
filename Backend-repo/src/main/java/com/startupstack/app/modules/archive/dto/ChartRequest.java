package com.startupstack.app.modules.archive.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ChartRequest {

    @Size(max = 6)
    private String chaNo;

    @Size(max = 2)
    private String subject;

    private Double type;

    private Double time;

    private LocalDateTime date;

    private Double number;

    private Double type1;

    @Size(max = 3)
    private String source;

    private LocalDateTime date1;

    @Size(max = 70)
    private String title;

    private Double stock;

    private Double nbDis;

    @Size(max = 3)
    private String subjectCode;

    @Size(max = 3)
    private String fromSite;

    @Size(max = 3)
    private String toSite;

    @Size(max = 3)
    private String fromPerson;

    @Size(max = 3)
    private String toPerson;

    @Size(max = 7)
    private String operationNo;

    @Size(max = 2)
    private String timeCode;
}
