package com.startupstack.app.modules.sites.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PostResponse {

    private String serial;
    private String formNo;
    private String formName;
    private String siteNo;
    private String docNo;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Integer wilyaNo;
    private Integer status;
    private String levelNo;
    private Integer type;
    private String user;
    private Integer permission;
    private String level;

    // Populated when includeSiteInfo=true (replaces view_posts)
    private String siteDescription;
    private String siteLevel;
}
