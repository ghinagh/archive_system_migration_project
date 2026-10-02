-- "لغة جهة الصدور" (language of the issuing body).
--
-- STRONG STRUCTURAL EVIDENCE, NOT a direct legacy-caption match: the literal compound
-- phrase "لغة جهة الصدور" / "لغة الصدور" was never found anywhere in the legacy archive
-- (56 .frm/.bas files + full macnz_manar_ddl.sql text, searched twice across two passes).
-- What was found: (1) "جهة الصدور" is already definitively mapped in this catalogue to the
-- article's periodical link (issuing_body field, ARTICLE.ART_PER_NO -> PERIOD, alias 'p'),
-- proven by user_inetrface.frm's results DataGrid Column07 (DataField="art_per_no",
-- Caption="جهة الصدور"); (2) PERIOD.PER_LANG is a real, dedicated language column on that
-- exact same PERIOD table, already mapped as PeriodicalEntity.lang; its only found caption
-- anywhere (PERIOD1.frm, control m_per_lang) is the generic "اللغة :" ("Language:"), not the
-- compound phrase. This field is therefore implemented on compositional reasoning (issuing
-- body = PERIOD; PER_LANG = that same PERIOD row's own language column) rather than a direct
-- binding of the exact screenshot phrase to this column. Reuses the SAME join alias 'p' as
-- the existing issuing_body field, since both read the same joined PERIOD row (no new join).
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'issuing_body_lang', 'lang', 'STRING', 'لغة جهة الصدور', TRUE, 'p', 'الدورية', TRUE, 4);
