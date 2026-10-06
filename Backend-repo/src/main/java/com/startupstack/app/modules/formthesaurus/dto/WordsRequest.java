package com.startupstack.app.modules.formthesaurus.dto;

/** Command3 mod_typ 2: del_word m_code, '2' then div_word(m_code, m_desc, "2"). */
public record WordsRequest(String code, String description) {}
