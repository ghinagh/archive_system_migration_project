-- (A) Fixes a mapping bug found while tracing "لغة جهة الصدور" for the field-catalogue
-- reconciliation task: the existing article_lang field pointed at ArticleEntity.lang
-- (ARTICLE.ART_LANG), but real legacy evidence shows the actual live "language" field is
-- ART_LANG1, not ART_LANG:
--   * user_inetrface.frm (the legacy search screen) builds its search condition as
--     "art_lang1 = ... Mid(m_art_lang.BoundText,3,2)" (crit1-building code, m_art_lang
--     DataCombo, labelled "اللغة" at Label27/Top=1680).
--   * Form6.frm (the ARTICLE data-entry form) writes the SAME m_art_lang.BoundText into
--     stored proc upd_article2's @m_art_lang parameter, whose body does
--     "update article set ... art_lang1 = @m_art_lang ..." (macnz_manar_ddl.sql).
-- ART_LANG (no "1") is never read or written anywhere in the legacy source outside its
-- own column declaration — it is a dead/unused column in the live application.
UPDATE retrieval_field
   SET entity_path = 'lang1'
 WHERE module = 'GRAPHICAL_RETRIEVAL' AND field_key = 'article_lang';

-- (B) "مصدر الدورية الاصلية في حال الترجمة" -> ARTICLE.ART_PER1 (a second periodical
-- reference), joined to PERIOD the same way as the existing periodical_name/issuing_body
-- fields but via a distinct alias 'p1' (see RetrievalService.JOIN_SKELETON). Evidence:
-- stored proc upd_article2 (macnz_manar_ddl.sql) updates "art_per1" alongside "art_per_no";
-- in Form6.frm, the DataCombo m_art_per1 (bound to PERIOD, same ListField/BoundColumn as
-- the confirmed "جهة الصدور" control m_art_per_no) sits at the exact form position of the
-- Label captioned "مصدر الترجمة" ("translation source"), directly matching this concept.
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'translation_source_periodical', 'name', 'STRING', 'مصدر الدورية الاصلية في حال الترجمة', TRUE, 'p1', 'المقال', TRUE, 5);

-- NOT implemented in this pass, evidence still insufficient (see migration audit report for
-- the exact deeper search performed): "جهة الصدور الاصلية" (no direct caption/DataField
-- evidence distinguishing it from the translation_source_periodical field above — treating
-- them as the same field would be exactly the kind of unproven equivalence this migration
-- avoids), "لغة جهة الصدور" (PERIOD.PER_LANG exists and is a plausible candidate by
-- composition, but only ever captioned generically "اللغة" in PERIOD1.frm — no evidence ties
-- the compound phrase to it directly), "نوع الوثيقة الشرح" (zero occurrences anywhere in the
-- legacy archive after an exhaustive search).
