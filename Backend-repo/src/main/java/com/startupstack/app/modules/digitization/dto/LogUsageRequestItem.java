package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/** One document/digitized-asset being registered under a shared usage-request header. */
@Getter
@Setter
public class LogUsageRequestItem {

    @NotBlank
    @Size(max = 7)
    private String catalogueAppNo;

    @Size(max = 6)
    private String digitNo;

    @Size(max = 3)
    private String type;

    @Size(max = 2)
    private String type1;
}
