package com.startupstack.app.modules.retrieval.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

/** One field's persisted per-user display/order marks — see RetrievalUserFieldEntity. */
@Getter
@AllArgsConstructor
public class RetrievalUserFieldState {
    private String fieldKey;
    private boolean display;
    private boolean orderMark;
}
