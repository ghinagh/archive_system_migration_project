package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 * tmp_file.frm Insert key: execute op_tmp Form2.Text1, box_user_no, today — the only value the caller
 * supplies is the document number (Form2.Text1); name, remark, place and date are never taken from it.
 */
public record TmpFileAddRequest(
        @NotNull @Size(max = 7) String tmpFadNo
) {}
