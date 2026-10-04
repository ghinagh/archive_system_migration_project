-- Splits "استرجاع الملفات الاضافية" back out of the bank retrieval catalogue so each screen
-- follows its own legacy data path.
--
-- Legacy evidence (ARCHIVE.frm f2_Click / f3_Click -> sort_from.frm Form_Load / cmd_result_Click,
-- frm_result.frm Form_Load): both menu items open the same sort_form against the same database,
-- but main_form switches every source:
--   main_form = 1 (bank)             : bnkout / view_user_bnkout, user_ist_no '01', proc tmp_result
--   main_form = 2 (additional files) : POUT (out_ist '02') / view_user_pout, user_ist_no '02',
--                                      proc tmp_result1
-- Every captured tmp_result1 body in macnz_manar_ddl.sql is rooted on FORM / view_form1 and joins
-- REL_FORM, POSITION / view_pos and SUBJECT — never MAIN or FILE_ADD (FILE_ADD only ever appears
-- in tmp_result, i.e. the bank screen, so V9's FILE_ADD fields correctly stay there).

-- 1. Per-user marks: legacy keeps both screens in user_bnkout, partitioned by user_ist_no.
ALTER TABLE retrieval_user_field ADD COLUMN module VARCHAR(30) NOT NULL DEFAULT 'GRAPHICAL_RETRIEVAL';
ALTER TABLE retrieval_user_field ALTER COLUMN module DROP DEFAULT;
DROP INDEX idx_retrieval_user_field_user_key;
CREATE UNIQUE INDEX idx_retrieval_user_field_user_module_key ON retrieval_user_field(user_no, module, field_key);

-- 2. Field catalogue for module = 'ADDITIONAL_FILES_RETRIEVAL' (RetrievalScope.ADDITIONAL_FILES:
--    f = FORM root, rf = REL_FORM, rf2 = related FORM, pos = POSITION, sj = SUBJECT, sub = MACNZ).
--    The real POUT rows (out_ist '02') are DB-resident data absent from the legacy archive, so only
--    columns that the captured tmp_result1 bodies actually select or filter on are seeded:
--      SELECT view_form1.sub_name / form.sub_name          -> form_name
--      WHERE  form.sub_dte = ...                           -> form_date
--      WHERE  rel_form.rlf_form2 = '...'                   -> related_form_code (+ its form name)
--      SELECT position.pos_nam / view_pos.pos_nam          -> position_name
--      WHERE  subject.sub_mcnz = '...'                     -> subject_term
--    Further POUT fields can be added from the maintenance screen under this module.
--    legacy_source_table follows V30's rule: set only when the table is in the F8/F9 whitelist.
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order, legacy_source_table) VALUES
    (gen_random_uuid(), 'ADDITIONAL_FILES_RETRIEVAL', 'form_name',          'name',      'STRING', 'اسم الاستمارة',           TRUE, NULL,  'الاستمارة',    TRUE,  0, 'view_form1'),
    (gen_random_uuid(), 'ADDITIONAL_FILES_RETRIEVAL', 'form_date',          'date',      'DATE',   'تاريخ الاستمارة',         TRUE, NULL,  'الاستمارة',    FALSE, 1, 'form'),
    (gen_random_uuid(), 'ADDITIONAL_FILES_RETRIEVAL', 'related_form_code',  'rlfForm2',  'STRING', 'رمز الاستمارة المرتبطة',  TRUE, 'rf',  'الربط الشكلي', FALSE, 0, NULL),
    (gen_random_uuid(), 'ADDITIONAL_FILES_RETRIEVAL', 'related_form_name',  'name',      'STRING', 'اسم الاستمارة المرتبطة',  TRUE, 'rf2', 'الربط الشكلي', TRUE,  1, 'view_form1'),
    (gen_random_uuid(), 'ADDITIONAL_FILES_RETRIEVAL', 'position_name',      'name',      'STRING', 'الوظيفة',                 TRUE, 'pos', 'الوظيفة',      TRUE,  0, NULL),
    (gen_random_uuid(), 'ADDITIONAL_FILES_RETRIEVAL', 'subject_term',       'subDesc',   'STRING', 'الموضوع (ماكنز)',         TRUE, 'sub', 'الموضوع',      TRUE,  0, 'macnz');
