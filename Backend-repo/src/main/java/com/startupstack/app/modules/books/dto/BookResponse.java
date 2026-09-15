package com.startupstack.app.modules.books.dto;

import com.startupstack.app.modules.descriptors.dto.ResResponse;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisResponse;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class BookResponse {

    private String appNo;

    private String catalogueTitle;

    private String publishLocation;
    private Double publisher;
    private String publishType;
    private String selectNo;
    private LocalDateTime publishDate;
    private String materialCount;
    private String lang3;
    private Double edition;
    private String rdmk;
    private String cover;
    private Double pageCount;
    private Double partNo;
    private Boolean isSeries;
    private Double copyCount;
    private Double regNo;
    private String additionalTitle;
    private String khalif;
    private Double volume;
    private String documentType;
    private String quarter;
    private Double save;
    private Double price;
    private LocalDateTime acquisitionDate;
    private Double translator;
    private String seriesTitle;
    private Double seriesNo;
    private String lang1;
    private Double volume1;
    private Double bindingFrom;
    private Double bindingTo;
    private Double partFrom;
    private Double partTo;
    private String content;
    private String memo;
    private Double yearPublished;
    private Double yearType;
    private String result;
    private Double free;
    private String lang;
    private String borrowingNo;
    private String status;

    private List<ResResponse> authors;
    private List<SubjectAnalysisResponse> subjects;
    private SeriesResponse series;
}
