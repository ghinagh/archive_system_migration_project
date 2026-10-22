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
        /**
         * The scope's root key regardless of outputFieldKeys: MAIN.MN_APP_NO for BANK, FORM.SUB_NO
         * for ADDITIONAL_FILES. Null for PERIODICALS, whose legacy rows are "select distinct" over
         * the displayed columns only (no key column).
         */
        private String appNo;
        private Map<String, Object> values;
        /**
         * BANK only: the row's DIGIT file and the MAIN/ARTICLE columns frm_result's keys read
         * (dig_DIG_NO, dig_typ1, dig_typ, DIG_choice, dig_o..dig_s1, dig_typ_high, MN_ACT_TTL,
         * art_dte — F9/F2/F6/double-click/نسخ, frm_result.frm:1193-1630). Not a displayed column.
         */
        private Map<String, Object> digit;
    }
}
