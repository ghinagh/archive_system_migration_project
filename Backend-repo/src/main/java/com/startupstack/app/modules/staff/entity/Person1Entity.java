package com.startupstack.app.modules.staff.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Maps the PERSON1 table — internal staff/employees.
 *
 * Distinction from PERSON (patrons): PERSON1 uses a shorter 5-char PK (staff ID),
 * carries two specialty dates and a specialty type code, and omits the personal/
 * demographic fields (denomination, political affiliation, social media, sex) that
 * are relevant only for external patron records.
 *
 * Both tables share prs_ent (char 2) as the entity/branch discriminator.
 */
@Getter
@Setter
@Entity
@Table(name = "PERSON1")
public class Person1Entity {

    @Id
    @Column(name = "prs_no", columnDefinition = "nvarchar(5)")
    private String prsNo;

    @Column(name = "prs_name", columnDefinition = "nvarchar(25)")
    private String prsName;

    @Column(name = "prs_inst")
    private String prsInst;

    @Column(name = "prs_adrs")
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

    @Column(name = "PRS_TYP_ICHT")
    private Integer prsTypIcht;

    @Column(name = "prs_qualty")
    private String prsQualty;

    @Column(name = "prs_icht_dte1")
    private LocalDateTime prsIchtDte1;

    @Column(name = "prs_icht_dte2")
    private LocalDateTime prsIchtDte2;

    @Column(name = "prs_ent", columnDefinition = "char(2)")
    private String prsEnt;
}
