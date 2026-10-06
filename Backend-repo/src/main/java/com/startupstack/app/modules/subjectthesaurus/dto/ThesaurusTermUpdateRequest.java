package com.startupstack.app.modules.subjectthesaurus.dto;

/** Command3 with mod_typ = "2": {@code upd_macnz desc.Text, code.Text}. */
public record ThesaurusTermUpdateRequest(String code, String description) {}
