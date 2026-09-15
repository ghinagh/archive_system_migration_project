package com.startupstack.app.modules.archive.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BatchChartRequest {

    @NotBlank
    private String baseTitle;

    @NotNull
    @Min(1)
    @Max(100)
    private Integer quantity;

    @NotNull
    @Min(1)
    private Integer startSequence;

    @NotNull
    @Valid
    private ChartRequest charitTemplate;
}
