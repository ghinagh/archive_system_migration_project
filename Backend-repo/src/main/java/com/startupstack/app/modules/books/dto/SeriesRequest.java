package com.startupstack.app.modules.books.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SeriesRequest {

    @Size(max = 40)
    private String arabicSeriesTitle;

    @Size(max = 40)
    private String additionalTitle;

    private Double activeNo;

    private Double additionalNo;
}
