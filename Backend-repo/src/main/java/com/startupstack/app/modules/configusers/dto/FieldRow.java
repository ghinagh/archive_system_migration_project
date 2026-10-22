package com.startupstack.app.modules.configusers.dto;

/**
 * One DataGrid3 (t_bnkout) row: user_no, user_out_num "المتسلسل", user_out_desc "اسم الحقل ",
 * user_out_choice "الاختيار", user_out_index "الترتيب" — plus user_ist_no, which addresses the
 * user_bnkout row behind it.
 */
public record FieldRow(String istNo, String userNo, Integer outNum, String outDesc, Integer outChoice, String outIndex) {}
