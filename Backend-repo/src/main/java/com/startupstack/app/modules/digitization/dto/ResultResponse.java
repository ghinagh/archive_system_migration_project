package com.startupstack.app.modules.digitization.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ResultResponse {

    private Integer id;
    private String resultNo;
    private Integer serial;
    private String digitNo;
    private String type;
    private String type1;
    private LocalDateTime date;
    private String userNo;
    private String catalogueAppNo;
    private String catalogueTitle;
    private String person;
    private String cote;
    private String coteDescription;
    private String permit;
    private String permitDescription;
    private String subject;
    private String type1Description;
}
