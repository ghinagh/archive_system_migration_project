package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * Writes the queue's "الاختيار" (dmd_chek) value: F1 sets every grid row to 1, F2 sets every grid
 * row to 2 (DataGrid1_KeyUp → upd_demand1), and the editable grid cell (AllowUpdate) writes a
 * single row. {@code null} clears the cell back to new.
 */
@Getter
@Setter
public class DemandQueueCheckRequest {

    @NotEmpty
    private List<Integer> ids;

    @Min(0)
    @Max(2)
    private Integer checked;
}
