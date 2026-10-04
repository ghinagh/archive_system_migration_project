package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * F5 panel (new_vdpreview.frm Frame1): "تنفيذ الكل" sends every grid row, "تنفيذ مشهد" sends
 * the current row. Only rows with {@code dmd_chek = 1} are rewritten.
 */
@Getter
@Setter
public class DemandQueuePathRequest {

    @NotEmpty
    private List<Integer> ids;

    /** The chosen view_coding14 SUB_DESC — legacy m_view_path.Text. */
    @NotBlank
    @Size(max = 100)
    private String basePath;
}
