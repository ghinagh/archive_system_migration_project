package com.startupstack.app.modules.formthesaurus.dto;

/**
 * A DataGrid1 cell edit (AllowUpdate), a new-row insert (AllowAddNew; {@code original} null) or a
 * row delete (AllowDelete; {@code column} null). Values are the grid's cell texts.
 *
 * @param column one of fileNo, finalFlag, fileName, remark, place, date, userNo, serial
 */
public record AdditionalFileEdit(AdditionalFileRow original, String column, String value, java.util.Map<String, String> values) {}
