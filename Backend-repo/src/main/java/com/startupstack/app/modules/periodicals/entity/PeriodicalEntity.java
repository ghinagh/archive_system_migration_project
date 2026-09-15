package com.startupstack.app.modules.periodicals.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "PERIOD")
public class PeriodicalEntity {

    @Id
    @Column(name = "PER_PER_NO")
    private Double perNo;

    @Column(name = "PER_PER_NA")
    private String name;

    @Column(name = "PER_PUB_LO")
    private Double publishLocation;

    @Column(name = "PER_ST_DTE")
    private LocalDateTime startDate;

    @Column(name = "PER_LANG")
    private String lang;

    @Column(name = "PER_RDMD")
    private String rdmd;

    @Column(name = "PER_TYP")
    private Double type;

    @Column(name = "PER_GEO")
    private String geo;

    @Column(name = "PER_TYP1")
    private String type1;

    @Column(name = "PER_FREQ")
    private String frequency;

    @Column(name = "PER_ADRS")
    private String address;

    @Column(name = "PER_TEL")
    private String phone;

    @Column(name = "PER_AMNT")
    private Double amount;

    @Column(name = "PER_PRIX")
    private Double price;

    @Column(name = "PER_PBLSHR")
    private Double publisher;

    @Column(name = "PER_PRIX1")
    private Double price1;

    @Column(name = "PER_PUB")
    private String pub;

    @Column(name = "PER_MOASS")
    private String institution;

    @Column(name = "PER_TAHRIR")
    private String editor;

    @Column(name = "PER_DIRCT")
    private String director;

    @Column(name = "PER_PRESD")
    private String president;

    @Column(name = "PER_UTILS")
    private Double utils;

    @Column(name = "PER_GEO1")
    private String geo1;

    @Column(name = "PER_TAH1")
    private String editor1;

    @Column(name = "PER_FAX")
    private String fax;

    @Column(name = "PER_CREAT")
    private String creator;

    @Column(name = "PER_DTE")
    private LocalDateTime date;

    @Column(name = "per_email")
    private String email;

    @Column(name = "per_website")
    private String website;
}
