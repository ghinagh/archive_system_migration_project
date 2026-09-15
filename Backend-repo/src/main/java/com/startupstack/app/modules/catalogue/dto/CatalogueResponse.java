package com.startupstack.app.modules.catalogue.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class CatalogueResponse {

    private String appNo;
    private String activeTitleAr;
    private String additionalTitle;
    private String dataEntry;
    private String appDoc;
    private LocalDateTime entryDate;
    private LocalDateTime writeDate;
    private String appRevision;
    private String type;
    private String result;
    private Integer trans;
    private String documentNature;
}
