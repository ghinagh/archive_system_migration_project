package com.startupstack.app.modules.descriptors.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NarowerRequest {

    @Size(max = 9)
    private String descriptorNo;

    @Size(max = 2)
    private String serialNo;

    @Size(max = 9)
    private String relativeNo;

    @Size(max = 1)
    private String narrowerType;

    @Size(max = 9)
    private String narrowerNo;
}
