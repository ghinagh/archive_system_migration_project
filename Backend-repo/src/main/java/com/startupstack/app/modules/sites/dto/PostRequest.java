package com.startupstack.app.modules.sites.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PostRequest {

    @NotBlank
    @Size(max = 6)
    private String serial;

    @Size(max = 10)
    private String formNo;

    @Size(max = 13)
    private String siteNo;

    @Size(max = 7)
    private String docNo;

    private LocalDateTime startDate;

    private LocalDateTime endDate;

    private Integer wilyaNo;

    private Integer status;

    @Size(max = 2)
    private String levelNo;

    private Integer type;

    @Size(max = 3)
    private String user;

    private Integer permission;

    @Size(max = 1)
    private String level;
}
