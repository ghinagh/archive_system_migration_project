package com.startupstack.app.modules.formthesaurus.dto;

/** Command1 on the names list: m_sub = Trim(v_typ) + Mid(country sub_no, 1, 3). */
public record NextNumberRequest(String sub) {}
