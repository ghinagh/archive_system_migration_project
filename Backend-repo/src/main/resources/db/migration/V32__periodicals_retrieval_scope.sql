-- Field catalogue for "استـرجـاع الصحف والمجلات" (RetrievalScope.PERIODICALS,
-- module = 'PERIODICALS_RETRIEVAL').
--
-- Legacy evidence: ARCHIVE.frm f4_Click sets main_form = 3 and opens sort_form; sort_from.frm
-- Form_Load's main_form = 3 branch sets var_ist = '06' (POUT out_ist '06', view_user_pout
-- user_ist_no '06'); cmd_result_Click recreates proc tmp_result2, which frm_result runs. The only
-- captured tmp_result2 body (macnz_manar_ddl.sql) is:
--   select distinct trans.trs_dte as [trs_dte], trans.trs_dte1 as [trs_dte1],
--          form.[sub_name] as [per_geo], period.per_per_na as [per_per_na]
--   from (period inner join trans on (period.[PER_PER_NO] = trans.[trs_no]))
--        left join form on period.[per_geo] = form.[sub_typ] + form.[sub_no]
--   where (period.[per_freq]='03')
-- The real POUT '06' rows are DB-resident data absent from the legacy archive, so only the
-- columns that body selects or filters on are seeded. Labels are the legacy captions of the
-- controls that write each column:
--   per_per_na -> PERIOD1.frm "اسم الدورية :"           (m_per_name)
--   per_geo    -> PERIOD1.frm "مكان الصدور - 1:"        (M_PER_GEO, ListField SUB_NAME)
--   per_freq   -> PERIOD1.frm "وتيرة الصدور"            (m_per_freq, CODING '12' family code)
--   trs_dte1   -> trs_period.frm "التاريخ :"            (m_trs_dte1, the arrival date)
--   trs_dte    -> trs_period.frm "تاريخ الدورية"        (m_trs_dte)
-- Categories follow the two legacy screens (PERIOD1.frm "استمارة الدورية", trs_period.frm
-- "برنامج وصول الدوريات"). legacy_source_table follows V30's rule (F8/F9 whitelist only):
-- 'period' and 'form' are whitelisted, trans is not.
-- Aliases: p = PERIOD (root), t = TRANS, g = FORM (place of issue).
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order, legacy_source_table) VALUES
    (gen_random_uuid(), 'PERIODICALS_RETRIEVAL', 'periodical_name',      'name',      'STRING', 'اسم الدورية',    TRUE, NULL, 'الدورية',        TRUE,  0, 'period'),
    (gen_random_uuid(), 'PERIODICALS_RETRIEVAL', 'issue_place',          'name',      'STRING', 'مكان الصدور - 1', TRUE, 'g',  'الدورية',        TRUE,  1, 'form'),
    (gen_random_uuid(), 'PERIODICALS_RETRIEVAL', 'periodical_frequency', 'frequency', 'STRING', 'وتيرة الصدور',    TRUE, NULL, 'الدورية',        TRUE,  2, 'period'),
    (gen_random_uuid(), 'PERIODICALS_RETRIEVAL', 'arrival_date',         'trsDte1',   'DATE',   'التاريخ',         TRUE, 't',  'وصول الدوريات', FALSE, 0, NULL),
    (gen_random_uuid(), 'PERIODICALS_RETRIEVAL', 'issue_date',           'trsDte',    'DATE',   'تاريخ الدورية',   TRUE, 't',  'وصول الدوريات', FALSE, 1, NULL);
