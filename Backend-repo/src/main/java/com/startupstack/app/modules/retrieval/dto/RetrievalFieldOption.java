package com.startupstack.app.modules.retrieval.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

/** A field the graphical retrieval builder's field picker (pin 13 of sort_from) can offer. */
@Getter
@AllArgsConstructor
public class RetrievalFieldOption {

    private String fieldKey;
    private String label;
    private String category;
    private String fieldType;
    private boolean lookupEnabled;
}
