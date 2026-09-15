package com.startupstack.app.modules.reports.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pout1Request {

    private Double outputNum;

    @Size(max = 25)
    private String description;

    @Size(max = 12)
    private String name;

    @Size(max = 100)
    private String field;

    @Size(max = 100)
    private String subCondition0;

    @Size(max = 200)
    private String subCondition;

    @Size(max = 200)
    private String subCondition1;

    @Size(max = 100)
    private String mainCondition;

    @Size(max = 100)
    private String mainCondition1;

    private Double length;
    private Double length1;

    @Size(max = 40)
    private String condition;

    @Size(max = 53)
    private String selectClause;

    private Double index;
    private Double index3;

    @Size(max = 1)
    private String seek;

    @Size(max = 1)
    private String ifCondition;

    private Double choice;

    @Size(max = 1)
    private String nature;

    @Size(max = 53)
    private String selectClause1;

    @Size(max = 53)
    private String index1;

    @Size(max = 80)
    private String code;

    @Size(max = 2)
    private String valueCode;

    @Size(max = 50)
    private String codeName;

    @Size(max = 50)
    private String codeName1;

    @Size(max = 1)
    private String recurrence;

    private Double index12;

    @Size(max = 50)
    private String condition1;

    @Size(max = 1)
    private String type;

    @Size(max = 20)
    private String relation;

    private Double choice1;
    private Double serial;

    @Size(max = 12)
    private String relation1;

    @Size(max = 12)
    private String relation2;

    @Size(max = 12)
    private String relation3;
}
