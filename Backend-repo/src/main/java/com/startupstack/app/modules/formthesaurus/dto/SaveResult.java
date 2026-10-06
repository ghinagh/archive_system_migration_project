package com.startupstack.app.modules.formthesaurus.dto;

/**
 * Outcome of a write that legacy ran under "On Error Resume Next": {@code saved = false} means the
 * statement failed (e.g. a value longer than the column) and legacy silently continued.
 */
public record SaveResult(boolean saved) {}
