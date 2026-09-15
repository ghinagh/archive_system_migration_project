package com.startupstack.app.modules.sites.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class SiteRequest {

    @NotBlank
    @Size(max = 10)
    private String siteNo;

    @Size(max = 13)
    private String levelNo;

    @Size(max = 2)
    private String level;

    @Size(max = 10)
    private String process;

    @Size(max = 100)
    private String description;

    @Size(max = 7)
    private String docNo;

    private LocalDateTime startDate;

    private LocalDateTime endDate;

    private Integer free;

    @Size(max = 2)
    private String type;

    private Integer wilyaNo;

    @Size(max = 2)
    private String status;

    @Size(max = 3)
    private String user;

    private Integer permission;

    @Size(max = 1)
    private String accessLevel;

    @Size(max = 2)
    private String kind;
}
