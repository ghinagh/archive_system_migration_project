package com.startupstack.app.modules.reports.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportTemplateRequest {

    private Double outputNum;

    @Size(max = 40)
    private String description;

    @Size(max = 20)
    private String name;

    @Size(max = 20)
    private String field;

    @Size(max = 70)
    private String subCondition0;

    @Size(max = 70)
    private String subCondition;

    @Size(max = 160)
    private String subCondition1;

    @Size(max = 45)
    private String mainCondition;

    @Size(max = 30)
    private String mainCondition1;

    @Size(max = 5)
    private String extension;

    private Double length;
    private Double length1;

    @Size(max = 60)
    private String condition;

    @Size(max = 80)
    private String display;

    @Size(max = 15)
    private String selectClause;

    @Size(max = 20)
    private String fieldSelect;

    @Size(max = 1)
    private String seek;

    @Size(max = 1)
    private String ifCondition;

    private Double choice;

    @Size(max = 1)
    private String nature;

    @Size(max = 1)
    private String type;

    @Size(max = 2)
    private String category;
}
