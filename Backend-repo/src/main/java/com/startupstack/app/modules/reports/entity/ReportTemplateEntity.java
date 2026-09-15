package com.startupstack.app.modules.reports.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "bnkout")
public class ReportTemplateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auto")
    private Integer id;

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

    @Column(name = "OUT_DISPLAY")
    private String display;

    @Column(name = "OUT_SELECT")
    private String selectClause;

    @Column(name = "out_fldselect")
    private String fieldSelect;

    @Column(name = "OUT_INDX")
    private String index;

    @Column(name = "OUT_INDX3")
    private String index3;

    @Column(name = "OUT_SEK")
    private String seek;

    @Column(name = "OUT_IF")
    private String ifCondition;

    @Column(name = "OUT_CHIOCE")
    private Double choice;

    @Column(name = "OUT_NATURE")
    private String nature;

    @Column(name = "OUT_SLCT1")
    private String selectClause1;

    @Column(name = "OUT_INDX1")
    private String index1;

    @Column(name = "OUT_COD")
    private String code;

    @Column(name = "OUT_VCOD")
    private String valueCode;

    @Column(name = "OUT_NAMCOD")
    private String codeName;

    @Column(name = "OUT_namcod1")
    private String codeName1;

    @Column(name = "OUT_RCRN")
    private String recurrence;

    @Column(name = "OUT_INDX12")
    private Double index12;

    @Column(name = "OUT_COND1")
    private String condition1;

    @Column(name = "OUT_TYP")
    private String type;

    @Column(name = "OUT_REL")
    private String relation;

    @Column(name = "OUT_REL1")
    private String relation1;

    @Column(name = "OUT_REL2")
    private String relation2;

    @Column(name = "OUT_REL3")
    private String relation3;

    @Column(name = "OUT_T2")
    private String text2;

    @Column(name = "OUT_CHIO1")
    private Double choice1;

    @Column(name = "OUT_SCOND2")
    private String subCondition2;

    @Column(name = "OUT_MCOND2")
    private String mainCondition2;

    @Column(name = "OUT_FIELD2")
    private String field2;

    @Column(name = "OUT_SLCT2")
    private Double selectClause2;

    @Column(name = "OUT_INDX2")
    private Double index2;

    @Column(name = "OUT_CAT", columnDefinition = "char(2)")
    private String category;
}
