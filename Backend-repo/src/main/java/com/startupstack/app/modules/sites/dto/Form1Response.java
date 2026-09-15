package com.startupstack.app.modules.sites.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Form1Response {

    private String formType;
    private String formNo;
    private String name;
    private LocalDateTime date;
}
