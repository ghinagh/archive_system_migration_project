package com.startupstack.app.modules.archivesearch.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
public class ArchiveSearchResultResponse {

    private String appNo;
    private String activeTitleAr;
    private String additionalTitle;
    private LocalDateTime articleDate;
    private String pageNo;
    private String periodicalName;
    private String digitNo;
    private String documentType;
    private String documentType1;
    private String docTypeDescription;
    private Integer choice;
    private String highType;
    private String machineStock;
    private Integer durationHours;
    private Integer durationMinutes;
    private Integer durationSeconds;
    private Integer durationHours1;
    private Integer durationMinutes1;
    private Integer durationSeconds1;
    private String responsiblePersonName;
    private String language;

    /** Full abstract text (main.MN_RESULT) — legacy Frame3/F6 popup shows this alongside the title. */
    private String abstractText;
}
