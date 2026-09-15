package com.startupstack.app.modules.archive.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "CHARIT")
public class ChartEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auto")
    private Integer id;

    @Column(name = "CHA_NO")
    private String chaNo;

    @Column(name = "CHA_SUB")
    private String subject;

    @Column(name = "CHA_TYP")
    private Double type;

    @Column(name = "CHA_TIME")
    private Double time;

    @Column(name = "CHA_DTE")
    private LocalDateTime date;

    @Column(name = "CHA_NUM")
    private Double number;

    @Column(name = "CHA_TYP1")
    private Double type1;

    @Column(name = "CHA_SOURCE")
    private String source;

    @Column(name = "CHA_DTE1")
    private LocalDateTime date1;

    @Column(name = "CHA_TITLE")
    private String title;

    @Column(name = "CHA_STOCK")
    private Double stock;

    @Column(name = "CHA_NBDIS")
    private Double nbDis;

    @Column(name = "CHA_SUBJCT")
    private String subjectCode;

    @Column(name = "CHA_FRM")
    private String fromSite;

    @Column(name = "cha_to")
    private String toSite;

    @Column(name = "cha_prsfrm")
    private String fromPerson;

    @Column(name = "cha_prsto")
    private String toPerson;

    @Column(name = "cha_opr_no")
    private String operationNo;

    @Column(name = "cha_tmcode")
    private String timeCode;
}
