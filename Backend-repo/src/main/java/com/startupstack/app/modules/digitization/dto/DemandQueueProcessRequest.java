package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * new_vdpreview.frm start / newstart / copy (Command9 / Command4 / Command5) over the grid rows,
 * in grid order. Rows whose {@code dmd_chek} is not 1 are skipped, as in legacy.
 */
@Getter
@Setter
public class DemandQueueProcessRequest {

    @NotEmpty
    private List<Integer> ids;

    @NotBlank
    @Pattern(regexp = "START|NEWSTART|COPY")
    private String mechanism;

    /** Check3 "كليب". */
    private boolean clip;

    /**
     * The name typed in legacy's Save dialog (CommonDialog1.FileName). Outputs are written to
     * the server archive directory under names built from it exactly as legacy builds them.
     */
    @NotBlank
    @Size(max = 100)
    private String outputName;
}
