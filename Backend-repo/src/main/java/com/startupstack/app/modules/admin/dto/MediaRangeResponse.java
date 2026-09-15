package com.startupstack.app.modules.admin.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MediaRangeResponse {

    private Integer id;
    private String noFrom;
    private String noTo;
    private String path;
    private Integer typ;
}
