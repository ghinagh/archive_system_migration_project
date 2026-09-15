package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class DemandBulkFulfilRequest {

    @NotEmpty
    private List<Integer> ids;

    @Pattern(regexp = "START|NEWSTART|COPY")
    private String mechanism = "COPY";

    /** The legacy "كليب" checkbox — merge all selected demands' clips into one output file. */
    private boolean mergeClip = false;
}
