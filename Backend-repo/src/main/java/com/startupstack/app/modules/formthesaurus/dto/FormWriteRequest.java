package com.startupstack.app.modules.formthesaurus.dto;

/** insr_form / upd_form arguments: @desc, @m_sub_no, @m_sub_typ. */
public record FormWriteRequest(String description, String number, String type) {}
