package com.startupstack.app.modules.admin.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TempSchemaResponse {

    private String fieldName;
    private String fieldType;
    private Double fieldLen;
    private Double fieldDec;
}
