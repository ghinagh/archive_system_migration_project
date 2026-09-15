package com.startupstack.app.modules.persons.entity;

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
@Table(name = "PERSON")
public class PersonEntity {

    @Id
    @Column(name = "PRS_NO", columnDefinition = "char(10)")
    private String prsNo;

    @Column(name = "PRS_NAME")
    private String prsName;

    @Column(name = "PRS_INST")
    private String prsInst;

    @Column(name = "PRS_ADRS")
    private String prsAdrs;

    @Column(name = "prs_inst_tel")
    private String prsInstTel;

    @Column(name = "PRS_INST_BOX")
    private String prsInstBox;

    @Column(name = "PRS_INST_DIRCT")
    private String prsInstDirct;

    @Column(name = "PRS_INST_EMAIL")
    private String prsInstEmail;

    @Column(name = "PRS_KAYD")
    private String prsKayd;

    @Column(name = "PRS_BRTH_DTE")
    private LocalDateTime prsBrthDte;

    @Column(name = "PRS_VLG")
    private String prsVlg;

    @Column(name = "PRS_SAKAN")
    private String prsSakan;

    @Column(name = "PRS_ADRS1")
    private String prsAdrs1;

    @Column(name = "PRS_TEL")
    private String prsTel;

    @Column(name = "PRS_EMAIL")
    private String prsEmail;

    @Column(name = "PRS_BOX")
    private String prsBox;

    @Column(name = "prs_qualty")
    private String prsQualty;

    @Column(name = "prs_icht_dte1")
    private LocalDateTime prsIchtDte1;

    @Column(name = "prs_ent", columnDefinition = "char(2)")
    private String prsEnt;

    @Column(name = "prs_mzhb", columnDefinition = "char(3)")
    private String prsMzhb;

    @Column(name = "prs_politc", columnDefinition = "char(3)")
    private String prsPolitc;

    @Column(name = "prs_social_media", columnDefinition = "char(100)")
    private String prsSocialMedia;

    @Column(name = "prs_oldjob", columnDefinition = "char(3)")
    private String prsOldjob;

    @Column(name = "prs_sex", columnDefinition = "char(3)")
    private String prsSex;
}
