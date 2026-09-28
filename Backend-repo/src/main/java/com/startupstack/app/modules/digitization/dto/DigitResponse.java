package com.startupstack.app.modules.digitization.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DigitResponse {

    private String docNo;
    private Integer serial;
    private String catalogueTitle;
    private String digitNo;
    private String type;
    private String type1;
    private Integer durationHours;
    private Integer durationMinutes;
    private Integer durationSeconds;
    private Integer durationHours1;
    private Integer durationMinutes1;
    private Integer durationSeconds1;
    private BigDecimal size;
    private String chartNo;
    private String newChartNo;
    private String chartType;
    private String chartGeo;
    private Integer choice;
    private String chartNo1;
    private String materialType;
    private String highType;

    /** Legacy Form6.frm DataGrid1 Column02 "شكل الوثيقة" (DataField=desc_typ1) is a resolved
     *  CODING description, not the raw DIG_TYP1 code — resolved via CODING domain '24' (proven:
     *  user_inetrface.frm Form_Load joins "'24'+ dig_typ1 = CODING.SUB_CODE"). Null when the
     *  code has no matching CODING row. */
    private String type1Description;

    /** Legacy Column16 "مكان التصوير/النشر" (DataField=desc_geo) is a resolved name from the
     *  same "form"/sites table already used for شاشة البحث's geo/file lookups (DBList12,
     *  ListField=SUB_NAME/BoundColumn=sub_cod) — not the raw stored code. Null when the code
     *  has no matching form row. */
    private String chartGeoName;
}
