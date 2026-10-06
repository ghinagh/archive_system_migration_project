package com.startupstack.app.modules.subjectthesaurus.repository;

/** Projection (not the entity) so MACNZ rows whose SUB_CODE is NULL still come back as rows. */
public interface ThesaurusTermView {
    String getCode();

    String getLevel();

    String getDescription();
}
