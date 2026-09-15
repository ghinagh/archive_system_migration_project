package com.startupstack.app.modules.descriptors.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NarowerResponse {

    private Integer id;
    private String appNo;
    private String descriptorNo;
    private String serialNo;
    private String relativeNo;
    private String narrowerType;
    private String narrowerNo;
}
