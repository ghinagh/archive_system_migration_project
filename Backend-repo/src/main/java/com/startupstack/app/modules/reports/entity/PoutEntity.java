package com.startupstack.app.modules.reports.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "POUT")
public class PoutEntity {

    @Id
    @Column(name = "auto")
    private Integer id;

    @Column(name = "OUT_IST")
    private String institution;

    @Column(name = "OUT_NUM")
    private Double outputNum;

    @Column(name = "OUT_DESC")
    private String description;

    @Column(name = "OUT_NAME")
    private String name;

    @Column(name = "OUT_FIELD")
    private String field;

    @Column(name = "OUT_SCOND0")
    private String subCondition0;

    @Column(name = "OUT_SCOND")
    private String subCondition;

    @Column(name = "OUT_SCOND1")
    private String subCondition1;

    @Column(name = "OUT_MCOND")
    private String mainCondition;

    @Column(name = "OUT_MCOND1")
    private String mainCondition1;

    @Column(name = "out_ext")
    private String extension;

    @Column(name = "OUT_LEN")
    private Double length;

    @Column(name = "OUT_LEN1")
    private Double length1;

    @Column(name = "OUT_COND")
    private String condition;

    @Column(name = "OUT_SELECT")
    private String selectClause;

    @Column(name = "OUT_INDX")
    private Double index;

    @Column(name = "OUT_INDX3")
    private Double index3;

    @Column(name = "OUT_SEK")
    private String seek;

    @Column(name = "OUT_IF")
    private String ifCondition;

    @Column(name = "OUT_CHIOCE")
    private Double choice;

    @Column(name = "OUT_NATURE")
    private String nature;

    @Column(name = "OUT_TYP")
    private String type;

    @Column(name = "OUT_REL")
    private String relation;

    @Column(name = "OUT_CHIO1")
    private Double choice1;

    @Column(name = "out_rel1")
    private String relation1;

    @Column(name = "out_rel2")
    private String relation2;

    @Column(name = "out_rel3")
    private String relation3;
}
