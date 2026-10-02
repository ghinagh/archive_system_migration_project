-- Backfills legacy_source_table (added NULL/unpopulated in V25) ONLY for fields whose real
-- underlying table was already independently confirmed with cited evidence in earlier audit
-- passes, and where that exact table name is literally one of the legacy F8/F9 whitelist
-- values confirmed in sort_from.frm/end_user.frm's c_getcond_KeyDown:
--   F8 = {form, macnz, view_form1, main, auther, period}; F9 adds {view_form}.
-- This is NOT a new/invented mapping — every row below cites the same evidence already used
-- to seed/implement that field in earlier migrations (V7, V26, V27, V28); this migration only
-- completes the already-known legacySourceTable column with the already-confirmed table name.
--
-- doc_*/data_entry_operator -> CatalogueEntity, @Table(name="main") (Backend-repo
-- CatalogueEntity.java) -- confirmed via MAIN.MN_APP_NO/MN_ACT_TTL/MN_ADD_TTL/MN_ENT_DTE/
-- MN_TYP/MN_DATA_EN bindings traced in earlier passes (user_inetrface.frm crit1-building code,
-- upd_article2/upd_main procs). "main" is literally in the F8 AND F9 whitelist.
UPDATE retrieval_field SET legacy_source_table = 'main'
 WHERE module = 'GRAPHICAL_RETRIEVAL'
   AND field_key IN ('doc_app_no','doc_title','doc_subtitle','doc_entry_date','doc_type','doc_nature','data_entry_operator');

-- periodical_*/issuing_body*/translation_source_periodical -> PeriodicalEntity,
-- @Table(name="PERIOD") -- confirmed via PERIOD.PER_PER_NO/PER_PER_NA/PER_LANG bindings
-- (m_art_per_no/m_art_per1 DataCombos, both ListField="PER_PER_NA"/BoundColumn="PER_PER_NO").
-- "period" is literally in the F8 AND F9 whitelist.
UPDATE retrieval_field SET legacy_source_table = 'period'
 WHERE module = 'GRAPHICAL_RETRIEVAL'
   AND field_key IN ('periodical_name','periodical_frequency','periodical_start_date','issuing_body','issuing_body_lang','translation_source_periodical');

-- author_name/author_type -> AuthorEntity, @Table mapping AUTHER.AUT_NAM/AUT_TYP -- confirmed
-- via Form6.frm DataGrid2 Column02 (DataField="AUT_NAM") and the AUTHER RecordSource
-- ("SELECT * FROM AUTHER order by aut_nam") traced in earlier passes. "auther" is literally in
-- the F8 AND F9 whitelist (legacy's own spelling, not a typo on our part).
UPDATE retrieval_field SET legacy_source_table = 'auther'
 WHERE module = 'GRAPHICAL_RETRIEVAL'
   AND field_key IN ('author_name','author_type');

-- subject_term/subject_level -> MacnzEntity, @Table(name="MACNZ") -- confirmed via the
-- MacnzEntity join (sub.subCode = sl.descriptorNo) already in RetrievalService.JOIN_SKELETON,
-- and MACNZ being a real table in macnz_manar_ddl.sql. "macnz" is literally in the F8 AND F9
-- whitelist.
UPDATE retrieval_field SET legacy_source_table = 'macnz'
 WHERE module = 'GRAPHICAL_RETRIEVAL'
   AND field_key IN ('subject_term','subject_level');

-- NOT backfilled (table not in the whitelist, or no confirmed table at all): article_* (table
-- ARTICLE is not in the whitelist set), res_type (RES not in the whitelist), digit_material_type/
-- digit_chart_type (DIGIT not in the whitelist), file_relation_type1/2/file_relative_no/
-- file_related_app_no/file_related_title (FILE_ADD not in the whitelist). These remain NULL —
-- not because their source table is unknown, but because that known table is genuinely absent
-- from the legacy F8/F9 whitelist itself, so marking them would misrepresent what the whitelist
-- says, not complete it.
