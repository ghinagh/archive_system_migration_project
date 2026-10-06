package com.startupstack.app.modules.formthesaurus.dto;

import java.time.LocalDateTime;

/** A POSITION row (POS_NO, POS_NAM, DAT_REC) as DBList5 holds it. */
public record PositionRow(String number, String name, LocalDateTime recorded) {}
