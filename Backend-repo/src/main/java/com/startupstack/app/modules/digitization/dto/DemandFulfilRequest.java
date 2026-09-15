package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DemandFulfilRequest {

    /** START = full re-encode (legacy "start"), NEWSTART = ffmpeg stream-copy trim, COPY = plain whole-file copy. */
    @Pattern(regexp = "START|NEWSTART|COPY")
    private String mechanism = "COPY";
}
