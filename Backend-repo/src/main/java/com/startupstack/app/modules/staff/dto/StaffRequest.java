package com.startupstack.app.modules.staff.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class StaffRequest {

    @NotBlank
    @Size(max = 5)
    private String prsNo;

    @Size(max = 25)
    private String name;

    @Size(max = 50)
    private String institution;

    @Size(max = 100)
    private String address;

    @Size(max = 30)
    private String institutionPhone;

    @Size(max = 15)
    private String institutionBox;

    @Size(max = 50)
    private String institutionDirectorate;

    @Size(max = 50)
    private String institutionEmail;

    @Size(max = 10)
    private String registrationId;

    private LocalDateTime birthDate;

    @Size(max = 10)
    private String village;

    @Size(max = 10)
    private String residence;

    @Size(max = 100)
    private String secondaryAddress;

    @Size(max = 50)
    private String phone;

    @Size(max = 50)
    private String email;

    @Size(max = 50)
    private String poBox;

    private Integer specialtyTypeCode;

    @Size(max = 3)
    private String qualification;

    private LocalDateTime specialtyDate1;

    private LocalDateTime specialtyDate2;

    @Size(max = 2)
    private String entity;
}
