package com.startupstack.app.modules.news.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class NewsRequest {

    @NotBlank
    @Size(max = 7)
    private String newsNo;

    @Size(max = 2)
    private String newsDoc;

    private LocalDateTime newsDteD;

    private LocalDateTime newsDte;

    private Double newsNum;

    @Size(max = 75)
    private String newsTit1;

    @Size(max = 75)
    private String newsTit2;

    @Size(max = 2)
    private String newsDesT;

    private LocalDateTime newsDesD;

    private Double newsDesP;

    private Double newsPub;

    @Size(max = 9)
    private String newsDesN;

    private Double newsMlh;
}
