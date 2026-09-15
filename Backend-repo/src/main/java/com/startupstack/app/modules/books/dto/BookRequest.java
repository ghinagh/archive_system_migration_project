package com.startupstack.app.modules.books.dto;

import com.startupstack.app.modules.catalogue.dto.CatalogueRequest;
import com.startupstack.app.modules.descriptors.dto.ResRequest;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisRequest;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class BookRequest {

    @NotBlank
    @Size(max = 7)
    private String appNo;

    @Size(max = 125)
    private String activeTitleAr;

    @Size(max = 125)
    private String additionalCatalogueTitle;

    @Size(max = 8)
    private String publishLocation;

    private Double publisher;

    @Size(max = 2)
    private String publishType;

    @Size(max = 20)
    private String selectNo;

    private LocalDateTime publishDate;

    @Size(max = 10)
    private String materialCount;

    @Size(max = 1)
    private String lang3;

    private Double edition;

    @Size(max = 15)
    private String rdmk;

    @Size(max = 2)
    private String cover;

    private Double pageCount;

    private Double partNo;

    @NotNull
    private Boolean isSeries;

    private Double copyCount;

    private Double regNo;

    @Size(max = 75)
    private String additionalTitle;

    @Size(max = 35)
    private String khalif;

    private Double volume;

    @Size(max = 2)
    private String documentType;

    @Size(max = 11)
    private String quarter;

    private Double save;

    private Double price;

    private LocalDateTime acquisitionDate;

    private Double translator;

    @Size(max = 60)
    private String seriesTitle;

    private Double seriesNo;

    @Size(max = 1)
    private String lang1;

    private Double volume1;

    private Double bindingFrom;

    private Double bindingTo;

    private Double partFrom;

    private Double partTo;

    @Size(max = 130)
    private String content;

    @Size(max = 200)
    private String memo;

    private Double yearPublished;

    private Double yearType;

    @Size(max = 1000)
    private String result;

    private Double free;

    @Size(max = 1)
    private String lang;

    @Size(max = 6)
    private String borrowingNo;

    @Size(max = 2)
    private String status;

    private CatalogueRequest mainData;
    private List<ResRequest> authors;
    private List<SubjectAnalysisRequest> subjects;
    private SeriesRequest series;
}
