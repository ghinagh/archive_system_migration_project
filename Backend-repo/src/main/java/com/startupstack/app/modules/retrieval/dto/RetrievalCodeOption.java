package com.startupstack.app.modules.retrieval.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

/** One c_getcond entry of a coded condition: the name shown (ListField) and its code (BoundColumn). */
@Getter
@AllArgsConstructor
public class RetrievalCodeOption {

    private String code;
    private String label;
}
