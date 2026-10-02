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

    /**
     * Legacy bnkout.out_slct1 equivalent, used by the frontend to gate the F8/F9 keyboard
     * shortcuts exactly as sort_form.frm's c_getcond_KeyDown did. Null for every field until
     * real legacy row data is supplied (see RetrievalFieldEntity#legacySourceTable).
     */
    private String legacySourceTable;

    /** Legacy F2 (DBList2_77) "#" marker — global per-field flag (bnkout.OUT_CHIOCE), not per-user. */
    private boolean hashMarked;
}
