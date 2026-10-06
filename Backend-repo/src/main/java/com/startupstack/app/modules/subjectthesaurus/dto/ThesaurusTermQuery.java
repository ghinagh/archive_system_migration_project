package com.startupstack.app.modules.subjectthesaurus.dto;

/**
 * The RecordSources Form5 assigns to its macnz1/2/3 data controls.
 * <ul>
 *   <li>LEVEL1 — {@code execute proc_macnz1}</li>
 *   <li>CHILDREN — {@code execute proc_macnz 1, 2|6, level, Mid(code, 1, 2|6)}</li>
 *   <li>PREFIX — {@code execute serh_macnz desc, Len(Trim(desc))}</li>
 *   <li>WORD — {@code execute serh_wrdmacnz desc, Len(Trim(desc))}</li>
 * </ul>
 */
public enum ThesaurusTermQuery {
    LEVEL1,
    CHILDREN,
    PREFIX,
    WORD
}
