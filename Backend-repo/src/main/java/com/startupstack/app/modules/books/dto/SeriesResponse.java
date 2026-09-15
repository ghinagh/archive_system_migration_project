package com.startupstack.app.modules.books.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SeriesResponse {

    private String appNo;
    private String arabicSeriesTitle;
    private String additionalTitle;
    private Double activeNo;
    private Double additionalNo;
}
