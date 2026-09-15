package com.startupstack.app.modules.retrieval.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;
import java.util.Map;

/** The dynamic-column result set — migrated equivalent of what frm_result's DataGrid1 rendered. */
@Getter
@AllArgsConstructor
public class RetrievalSearchResponse {

    private List<RetrievalColumn> columns;
    private List<RetrievalResultRow> rows;
    private long totalElements;
    private int page;
    private int size;

    @Getter
    @AllArgsConstructor
    public static class RetrievalColumn {
        private String fieldKey;
        private String label;
    }

    @Getter
    @AllArgsConstructor
    public static class RetrievalResultRow {
        /** Always present regardless of outputFieldKeys, so the UI can navigate to the underlying record. */
        private String appNo;
        private Map<String, Object> values;
    }
}
