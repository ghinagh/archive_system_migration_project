package com.startupstack.app.modules.periodicals.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PeriodicalRequest {

    @NotNull
    private Double perNo;

    @Size(max = 40)
    private String name;

    private Double publishLocation;

    private LocalDateTime startDate;

    @Size(max = 1)
    private String lang;

    @Size(max = 15)
    private String rdmd;

    private Double type;

    @Size(max = 10)
    private String geo;

    @Size(max = 2)
    private String type1;

    @Size(max = 2)
    private String frequency;

    @Size(max = 65)
    private String address;

    @Size(max = 16)
    private String phone;

    private Double amount;

    private Double price;

    private Double publisher;

    @Size(max = 10)
    private String pub;

    @Size(max = 10)
    private String institution;

    @Size(max = 10)
    private String editor;

    @Size(max = 10)
    private String director;

    @Size(max = 10)
    private String president;

    @Size(max = 15)
    private String fax;

    @Size(max = 10)
    private String creator;

    @Size(max = 60)
    private String email;

    @Size(max = 60)
    private String website;
}
