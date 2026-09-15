package com.startupstack.app.modules.sites.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class SiteResponse {

    private String siteNo;
    private String formName;
    private String levelNo;
    private String level;
    private String process;
    private String description;
    private String docNo;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Integer free;
    private String type;
    private Integer wilyaNo;
    private String status;
    private String user;
    private Integer permission;
    private String accessLevel;
    private String kind;

    // Populated when includeFormInfo=true (replaces view_siteform)
    private String formType;
    private String formPrintName;
}
