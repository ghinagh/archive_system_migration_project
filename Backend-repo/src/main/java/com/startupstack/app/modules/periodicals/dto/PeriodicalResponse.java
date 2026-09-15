package com.startupstack.app.modules.periodicals.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PeriodicalResponse {

    private Double perNo;
    private String name;
    private Double publishLocation;
    private LocalDateTime startDate;
    private String lang;
    private String rdmd;
    private Double type;
    private String geo;
    private String type1;
    private String frequency;
    private String address;
    private String phone;
    private Double amount;
    private Double price;
    private Double publisher;
    private String pub;
    private String institution;
    private String editor;
    private String director;
    private String president;
    private String fax;
    private String creator;
    private String email;
    private String website;
}
