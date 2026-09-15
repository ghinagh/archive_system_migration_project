package com.startupstack.app.modules.articles.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ArticleResponse {

    private String appNo;
    private String catalogueTitle;
    private String additionalTitle;
    private String dataEntry;
    private String appDoc;
    private LocalDateTime entryDate;
    private String result;
    private String documentNature;
    private Double year;
    private Double volume;
    private Integer articleNo;
    private LocalDateTime date;
    private Double periodicalNo;
    private String periodicalName;
    private String subjectType;
    private String pageNo;
    private String countryNo;
    private Double serialNo;
    private Double filmNo;
    private Double type;
    private String lang;
    private LocalDateTime date1;
    private Double periodical1;
    private Double choice;
    private String picture;
    private String lang1;

    /** MN_TRANS on the linked catalogue record — 1 means locked (see Form6.frm is_trans()). */
    private Boolean locked;
}
