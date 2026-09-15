package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class CatalogueRequest {

    @NotBlank
    @Size(max = 7)
    private String appNo;

    @Size(max = 125)
    private String activeTitleAr;

    @Size(max = 125)
    private String additionalTitle;

    @Size(max = 2)
    private String dataEntry;

    @Size(max = 2)
    private String appDoc;

    private LocalDateTime entryDate;

    private LocalDateTime writeDate;

    @Size(max = 2)
    private String appRevision;

    @Size(max = 1)
    private String type;

    @Size(max = 1000)
    private String result;

    private Integer trans;

    @Size(max = 1)
    private String documentNature;
}
