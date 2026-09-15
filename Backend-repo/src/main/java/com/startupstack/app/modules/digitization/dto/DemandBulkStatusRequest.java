package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/** Explicit, opt-in bulk status change — the deliberate replacement for the legacy F1/F2 whole-grid quirk. */
@Getter
@Setter
public class DemandBulkStatusRequest {

    @NotEmpty
    private List<Integer> ids;

    /**
     * Coarse two-state form: {@code true} → dmd_chek 2 (fulfilled), {@code false} → 1 (queued).
     * Ignored when {@link #checked} is supplied.
     */
    private Boolean fulfilled;

    /**
     * Raw legacy dmd_chek value, when the caller needs the third state the boolean cannot
     * express. USER_INTERFACE1.frm's "الاختيار" column is a real persisted column, not a
     * transient UI selection: {@code 1} = queued/selected (written on insert at :3549),
     * {@code 2} = fulfilled (written by the batch actions), {@code 0} = de-selected so the
     * batch actions skip the row. Without this, a queued row could never be un-queued.
     */
    @Min(0)
    @Max(2)
    private Integer checked;
}
