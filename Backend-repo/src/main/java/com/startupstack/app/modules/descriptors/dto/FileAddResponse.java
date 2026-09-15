package com.startupstack.app.modules.descriptors.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class FileAddResponse {

    private UUID id;
    private String appNo;
    private String descriptorNo;
    private String serialNo;
    private String fileType1;
    private String fileType2;
    private String relativeNo;
    private String fileNo;
}
