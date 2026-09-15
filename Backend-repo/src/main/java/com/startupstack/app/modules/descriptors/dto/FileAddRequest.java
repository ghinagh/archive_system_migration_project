package com.startupstack.app.modules.descriptors.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileAddRequest {

    @Size(max = 9)
    private String descriptorNo;

    @Size(max = 2)
    private String serialNo;

    @Size(max = 1)
    private String fileType1;

    @Size(max = 1)
    private String fileType2;

    @Size(max = 2)
    private String relativeNo;

    @Size(max = 10)
    private String fileNo;
}
