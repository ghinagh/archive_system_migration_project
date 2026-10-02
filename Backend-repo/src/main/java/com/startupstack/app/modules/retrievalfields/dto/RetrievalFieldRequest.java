package com.startupstack.app.modules.retrievalfields.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RetrievalFieldRequest {

    @NotBlank
    @Size(max = 30)
    private String module;

    @NotBlank
    @Size(max = 50)
    private String fieldKey;

    @NotBlank
    @Size(max = 100)
    private String entityPath;

    @NotBlank
    @Pattern(regexp = "STRING|NUMBER|DATE")
    private String fieldType;

    @NotBlank
    @Size(max = 100)
    private String label;

    private boolean enabled = true;

    @Size(max = 150)
    private String joinPath;

    @Size(max = 60)
    private String category;

    private boolean lookupEnabled = false;

    private int displayOrder = 0;

    /** Legacy bnkout.out_slct1 equivalent — see RetrievalFieldEntity#legacySourceTable. */
    @Size(max = 60)
    private String legacySourceTable;
}
