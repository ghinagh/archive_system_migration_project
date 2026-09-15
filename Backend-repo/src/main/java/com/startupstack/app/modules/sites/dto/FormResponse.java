package com.startupstack.app.modules.sites.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class FormResponse {

    private String formNo;
    private String formType;
    private String name;
    private LocalDateTime date;
    private String user;
    private Integer section;
    private Integer jihadNo;
    private String printName;
}
