package com.startupstack.app.modules.retrieval.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class RetrievalSearchRequest {

    @Valid
    private RetrievalConditionNode rootCondition;

    @NotEmpty
    private List<String> outputFieldKeys;

    /**
     * Field keys marked via the legacy F10 shortcut on "حقول العرض في الجدول"
     * (DBList2_KeyDown / user_out_choi1 in sort_from.frm), in the order they were marked —
     * mirrors legacy's m_indx_fld "order by" clause built from bnkout1 rows with
     * user_out_choi1 = 1. Empty/omitted means no explicit ordering (natural query order).
     */
    private List<String> orderFieldKeys;

    private int page = 0;

    private int size = 25;
}
