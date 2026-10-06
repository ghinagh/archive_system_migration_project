package com.startupstack.app.modules.subjectthesaurus.dto;

/** One MACNZ row as a Form5 DataList holds it (ListField SUB_DESC, sub_code behind it). */
public record ThesaurusTermRow(String code, String level, String description) {}
