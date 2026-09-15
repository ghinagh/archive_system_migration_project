package com.startupstack.app.modules.news.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class NewsResponse {

    private String newsNo;
    private String newsDoc;
    private LocalDateTime newsDteD;
    private LocalDateTime newsDte;
    private Double newsNum;
    private String newsTit1;
    private String newsTit2;
    private String newsDesT;
    private LocalDateTime newsDesD;
    private Double newsDesP;
    private Double newsPub;
    private String newsDesN;
    private Double newsMlh;
    private List<String> keywords;
}
