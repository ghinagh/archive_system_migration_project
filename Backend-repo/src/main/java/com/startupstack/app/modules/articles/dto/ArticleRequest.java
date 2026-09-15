package com.startupstack.app.modules.articles.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ArticleRequest {

    @NotBlank
    @Size(max = 7)
    private String appNo;

    @Size(max = 125)
    private String activeTitleAr;

    @Size(max = 125)
    private String additionalCatalogueTitle;

    @Size(max = 2)
    private String dataEntry;

    @Size(max = 2)
    private String appDoc;

    private LocalDateTime entryDate;

    @Size(max = 1000)
    private String result;

    @Size(max = 1)
    private String documentNature;

    private Double year;

    private Double volume;

    private Integer articleNo;

    private LocalDateTime date;

    private Double periodicalNo;

    @Size(max = 2)
    private String subjectType;

    @Size(max = 5)
    private String pageNo;

    @Size(max = 3)
    private String countryNo;

    private Double serialNo;

    private Double filmNo;

    private Double type;

    @Size(max = 1)
    private String lang;

    private LocalDateTime date1;

    private Double periodical1;

    private Double choice;

    @Size(max = 6)
    private String picture;

    @Size(max = 2)
    private String lang1;
}
