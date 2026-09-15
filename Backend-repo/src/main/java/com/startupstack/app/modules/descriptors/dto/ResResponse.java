package com.startupstack.app.modules.descriptors.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResResponse {

    private Integer id;
    private String appNo;
    private String resourceType;

    /** Resolved CODING description — matches Form6.frm's "typ_aut" view column. */
    private String resourceTypeDescription;

    private Double authorNo;
    private String authorName;
}
