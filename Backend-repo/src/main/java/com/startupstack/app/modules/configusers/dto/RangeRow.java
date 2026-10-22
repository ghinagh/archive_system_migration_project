package com.startupstack.app.modules.configusers.dto;

/** One DataGrid2 (ranj = select ranjpath.* from ranjpath) row. */
public record RangeRow(Integer rjpNo, String rjpNofrom, String rjpNoto, String rjpPath, Integer rjpTyp) {}
