package com.startupstack.app.modules.reports.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "POUT1")
@IdClass(Pout1Id.class)
public class Pout1Entity {

    @Id
    @Column(name = "OUT_IST", length = 2)
    private String institution;

    @Id
    @Column(name = "OUT_NUM")
    private Double outputNum;

    @Column(name = "OUT_DESC", length = 25)
    private String description;

    @Column(name = "OUT_NAME", length = 12)
    private String name;

    @Column(name = "OUT_FIELD", length = 100)
    private String field;

    @Column(name = "OUT_SCOND0", length = 100)
    private String subCondition0;

    @Column(name = "OUT_SCOND", length = 200)
    private String subCondition;

    @Column(name = "OUT_SCOND1", length = 200)
    private String subCondition1;

    @Column(name = "OUT_MCOND", length = 100)
    private String mainCondition;

    @Column(name = "OUT_MCOND1", length = 100)
    private String mainCondition1;

    @Column(name = "OUT_LEN")
    private Double length;

    @Column(name = "OUT_LEN1")
    private Double length1;

    @Column(name = "OUT_COND", length = 40)
    private String condition;

    @Column(name = "OUT_SELECT", length = 53)
    private String selectClause;

    @Column(name = "OUT_INDX")
    private Double index;

    @Column(name = "OUT_INDX3")
    private Double index3;

    @Column(name = "OUT_SEK", length = 1)
    private String seek;

    @Column(name = "OUT_IF", length = 1)
    private String ifCondition;

    @Column(name = "OUT_CHIOCE")
    private Double choice;

    @Column(name = "OUT_NATURE", length = 1)
    private String nature;

    @Column(name = "OUT_SLCT1", length = 53)
    private String selectClause1;

    @Column(name = "OUT_INDX1", length = 53)
    private String index1;

    @Column(name = "OUT_COD", length = 80)
    private String code;

    @Column(name = "OUT_VCOD", length = 2)
    private String valueCode;

    @Column(name = "OUT_NAMCOD", length = 50)
    private String codeName;

    @Column(name = "OUT_NAMCOD1", length = 50)
    private String codeName1;

    @Column(name = "OUT_RCRN", length = 1)
    private String recurrence;

    @Column(name = "OUT_INDX12")
    private Double index12;

    @Column(name = "OUT_COND1", length = 50)
    private String condition1;

    @Column(name = "OUT_TYP", length = 1)
    private String type;

    @Column(name = "OUT_REL", length = 20)
    private String relation;

    @Column(name = "OUT_CHIO1")
    private Double choice1;

    @Column(name = "out_serial")
    private Double serial;

    @Column(name = "OUT_REL1", length = 12)
    private String relation1;

    @Column(name = "OUT_REL2", length = 12)
    private String relation2;

    @Column(name = "OUT_REL3", length = 12)
    private String relation3;
}
