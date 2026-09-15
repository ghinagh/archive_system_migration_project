package com.startupstack.app.modules.archive.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ChartOperationRequest {

    @Size(max = 7)
    private String oprNo;

    private Double serial;

    @Size(max = 2)
    private String subject;

    private LocalDateTime date;

    @Size(max = 15)
    private String time;

    @Size(max = 3)
    private String fromSite;

    @Size(max = 3)
    private String fromPerson;

    @Size(max = 3)
    private String toSite;

    @Size(max = 3)
    private String toPerson;

    private LocalDateTime returnDate;

    @Size(max = 50)
    private String remark;

    @Size(max = 70)
    private String title;

    @NotNull
    private Boolean transferred;

    @Size(max = 20)
    private String choice;

    @Size(max = 10)
    private String externalCode;
}
