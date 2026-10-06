package com.startupstack.app.modules.subjectthesaurus.dto;

/**
 * Command3 with mod_typ = "1": {@code insr_macnz desc, m_code, m_leve} followed by
 * {@code div_word(m_code, desc, "1")}. {@code wordCode} is the m_code div_word receives — for a
 * level-1 add Command3 never assigns m_code, so it is empty there.
 */
public record ThesaurusTermInsertRequest(String code, String description, String level, String wordCode) {}
