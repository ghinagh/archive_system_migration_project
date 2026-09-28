package com.startupstack.app.modules.paysform.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PaysFormResponse {

    private String formNo;
    private String formType;
    private String name;
    private LocalDateTime date;
}
