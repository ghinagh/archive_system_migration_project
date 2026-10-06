package com.startupstack.app.modules.formthesaurus.dto;

/** insr_pos (@desc, @m_sub_no) / upd_position (@desc, @m_sub_no, @desc1 = the old POS_NAM). */
public record PositionWriteRequest(String description, String number, String oldDescription) {}
