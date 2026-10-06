package com.startupstack.app.modules.formthesaurus.dto;

import java.time.LocalDate;

/**
 * insr_rel_form / insr_subject (first, second, relation) and upd_rfl_dte / upd_sub_dte (+ the two
 * dates; null = the empty text box, which the procedures store as NULL).
 */
public record RelationWriteRequest(String first, String second, String relation, LocalDate start, LocalDate end) {}
