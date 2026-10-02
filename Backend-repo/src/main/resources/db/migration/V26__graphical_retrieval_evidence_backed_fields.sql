-- Adds retrieval_field rows for legacy screenshot captions where a real
-- table.column mapping was found by tracing the actual legacy archive (not the
-- unrecoverable bnkout metadata rows, but real DataField/DataGrid bindings and
-- SQL views/procs elsewhere in the archive). Every mapping below is cited with
-- its exact legacy source; see the migration audit report for full detail.
--
-- 1) "نوع المسؤولية البيانية" -> RES.RES_APP_TY (ResEntity.resourceType, alias 'r',
--    already in RetrievalService.JOIN_SKELETON). Evidence: Form6.frm DataGrid2
--    Column01 DataField="typ_aut" Caption="نوع المسؤولية البيانية"; dbo.view_res3 /
--    proc res_proc1 show typ_aut = CODING.SUB_DESC joined via '04'+RES.RES_APP_TY.
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'res_type', 'resourceType', 'STRING', 'نوع المسؤولية البيانية', TRUE, 'r', 'المسؤولية البيانية', TRUE, 0);

-- 2) "نوع المقالة" -> ARTICLE.ART_TYP (ArticleEntity.type, alias 'a'). Evidence:
--    m1.frm line 439 "article.Resultset![art_typ] = coding_typ.Resultset![sub_code]",
--    written from DBCombo5 which sits on the same row/TabIndex as Label13
--    captioned "نوع المقالة" (m1.frm / macnz.frm, Top=4560 Left=8040).
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'article_type', 'type', 'NUMBER', 'نوع المقالة', TRUE, 'a', 'المقال', TRUE, 4);

-- 3) "جهة الصدور" -> the article's periodical link (ARTICLE.ART_PER_NO -> PERIOD),
--    i.e. the SAME join/column as the existing periodical_name field (alias 'p',
--    entity_path 'name'). Evidence: user_inetrface.frm results DataGrid Column07,
--    DataField="art_per_no" Caption="جهة الصدور" (lines 1293-1294) — the legacy
--    results grid literally labels the periodical link "جهة الصدور". Added as its
--    own catalogue row (distinct caption/context from "اسم الدورية") rather than
--    renaming periodical_name, since the screenshot shows both as separate entries.
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'issuing_body', 'name', 'STRING', 'جهة الصدور', TRUE, 'p', 'الدورية', TRUE, 3);

-- 4) "نوع المادة" -> DIGIT.dig_typmat (DigitEntity.materialType). Evidence: Form6.frm
--    DataGrid DataField="desc_typmat" Caption="نوع المادة"; proc rel_digit_proc shows
--    desc_typmat = CODING_2.SUB_DESC joined via '29'+DIGIT.dig_typmat.
-- 5) "نوع الشريط" -> DIGIT.dig_typchrt (DigitEntity.chartType). Evidence: same
--    DataGrid, DataField="desc_typchrt" Caption="نوع الشريط"; same proc shows
--    desc_typchrt = CODING_1.SUB_DESC joined via '26'+DIGIT.dig_typchrt.
-- DigitEntity is joined into RetrievalService's JOIN_SKELETON under alias 'dg'
-- (DigitEntity.catalogue is already a real @ManyToOne to CatalogueEntity via
-- DIG_NO=MN_APP_NO, so this reuses an existing relationship, not a new one).
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'digit_material_type', 'materialType', 'STRING', 'نوع المادة', TRUE, 'dg', 'التوثيق الرقمي', TRUE, 0),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'digit_chart_type', 'chartType', 'STRING', 'نوع الشريط', TRUE, 'dg', 'التوثيق الرقمي', TRUE, 1);

-- 6) "مدخل البيانات" -> MAIN.MN_DATA_EN (CatalogueEntity.dataEntry, catalogue root,
--    no join_path needed). Evidence: user_inetrface.frm lines 2081/3357
--    "crit1 = crit1 & ' mn_data_en = ' & ... Mid(m_mn_data_en.BoundText,3,2)",
--    Label15 caption "مدخل البيانات" at the matching form position (Top=3840);
--    macnz_manar_ddl.sql confirms MAIN.MN_DATA_EN; CatalogueEntity already maps it.
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'data_entry_operator', 'dataEntry', 'STRING', 'مدخل البيانات', TRUE, NULL, 'الوثيقة', TRUE, 6);

-- 7) "المسؤول البياني (مؤلف)" is confirmed to be the SAME underlying column as the
--    existing author_name field (AUTHER.AUT_NAM), not a distinct field. Evidence:
--    Form6.frm DataGrid2 Column02 DataField="AUT_NAM" Caption="المسؤول البياني"
--    (same view_res3 grid as finding #1 above). Per the caption-only-fix rule,
--    correct author_name's label to the exact legacy text — no new field/table.
UPDATE retrieval_field
   SET label = 'المسؤول البياني (مؤلف)'
 WHERE module = 'GRAPHICAL_RETRIEVAL' AND field_key = 'author_name';

-- NOT implemented (no real table/column evidence found anywhere in the legacy
-- archive despite a full-corpus search across all 56 .frm/.bas files, the SQL
-- Server DDL, and the bnkout-admin forms — see the migration audit report for the
-- exact search performed per field): "جهة الصدور الاصلية", "لغة جهة الصدور",
-- "مصدر الدورية الاصلية في حال الترجمة", "نوع الوثيقة الشرح". These remain
-- unimplemented rather than guessed, per instruction.
