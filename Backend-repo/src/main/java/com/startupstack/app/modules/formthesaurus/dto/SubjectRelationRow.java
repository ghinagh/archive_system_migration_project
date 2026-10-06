package com.startupstack.app.modules.formthesaurus.dto;

import java.time.LocalDateTime;

/** subject_proc row: sub_form, sub_mcnz, sub_rel, m_sub_desc (macnz.sub_desc), sub_dte, sub_dte1. */
public record SubjectRelationRow(String form, String macnz, String relation, String description,
                                 LocalDateTime start, LocalDateTime end) {}
