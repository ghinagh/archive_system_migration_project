package com.startupstack.app.modules.formthesaurus.dto;

import java.time.LocalDateTime;

/**
 * One tmp_fileadd row as tmp_file.frm's DataGrid1 shows it (tmp_fad_no, tmp_final, tmp_file_name,
 * tmp_rmrk, tmp_mk, tmp_date, tmp_user_no, tmp_ser).
 */
public record AdditionalFileRow(String fileNo, Integer finalFlag, String fileName, String remark, String place,
                                LocalDateTime date, String userNo, Double serial) {}
