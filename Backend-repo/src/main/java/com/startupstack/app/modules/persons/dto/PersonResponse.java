package com.startupstack.app.modules.persons.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PersonResponse {

    private String prsNo;
    private String name;
    private String institution;
    private String address;
    private String institutionPhone;
    private String institutionBox;
    private String institutionDirectorate;
    private String institutionEmail;
    private String registrationId;
    private LocalDateTime birthDate;
    private String village;
    private String residence;
    private String secondaryAddress;
    private String phone;
    private String email;
    private String poBox;
    private String qualification;
    private LocalDateTime specialtyDate;
    private String entity;
    private String denomination;
    private String politicalAffiliation;
    private String socialMedia;
    private String previousJob;
    private String sex;
}
