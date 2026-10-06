package com.startupstack.app.modules.formthesaurus.dto;

import java.time.LocalDateTime;

/** rel_form_proc row: rlf_form1, rlf_form2, rlf_rel, m_name (view_form.SUB_NAME), rlf_dte, rlf_dte1. */
public record FormRelationRow(String form1, String form2, String relation, String name,
                              LocalDateTime start, LocalDateTime end) {}
