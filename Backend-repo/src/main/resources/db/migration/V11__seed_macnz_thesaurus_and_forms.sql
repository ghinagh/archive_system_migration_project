-- Dev/test seed data for the التحليل (Form2.frm) subject-analysis screen.
-- The dev database had zero rows in MACNZ/form, so every picker on
-- analysis-panel (المكنز MACNZ picker + form/site picker) had nothing to
-- show. No legacy data dump was available to import, so this is a small
-- representative thesaurus hierarchy + a handful of site/form entries,
-- enough to exercise every add/delete flow end to end.

INSERT INTO "MACNZ" ("SUB_CODE", "SUB_LEVEL", "SUB_DESC", "SUB_LOGIC") VALUES
  ('01',     '1', 'العلوم الاجتماعية', 0),
  ('0101',   '2', 'الاقتصاد', 0),
  ('010101', '3', 'الاقتصاد الزراعي', 0),
  ('010102', '3', 'الاقتصاد الصناعي', 0),
  ('010103', '3', 'الاقتصاد الدولي', 0),
  ('010104', '3', 'التجارة الخارجية', 0),
  ('0102',   '2', 'الاجتماع', 0),
  ('010201', '3', 'التنمية الاجتماعية', 0),
  ('010202', '3', 'الهجرة والسكان', 0),
  ('02',     '1', 'العلوم السياسية', 0),
  ('0201',   '2', 'العلاقات الدولية', 0),
  ('020101', '3', 'السياسة الخارجية', 0),
  ('020102', '3', 'الأمن القومي', 0),
  ('020103', '3', 'المنظمات الدولية', 0),
  ('0202',   '2', 'الأنظمة السياسية', 0),
  ('020201', '3', 'الانتخابات', 0),
  ('020202', '3', 'الأحزاب السياسية', 0),
  ('03',     '1', 'الجغرافيا', 0),
  ('0301',   '2', 'الجغرافيا السياسية', 0),
  ('030101', '3', 'الحدود الدولية', 0),
  ('030102', '3', 'الموارد الطبيعية', 0),
  ('030103', '3', 'المناخ والبيئة', 0)
ON CONFLICT DO NOTHING;

INSERT INTO "form" ("SUB_TYP", "SUB_NO", "SUB_NAME", "SUB_DTE", "SUB_USER", "SUB_SEC", "SUB_NOJIHAD", "SUB_NAME_PRINT") VALUES
  ('01', '00000001', 'وزارة الخارجية', NULL, NULL, NULL, NULL, NULL),
  ('01', '00000002', 'وزارة الداخلية', NULL, NULL, NULL, NULL, NULL),
  ('01', '00000003', 'مجلس الوزراء', NULL, NULL, NULL, NULL, NULL),
  ('01', '00000004', 'وزارة الدفاع', NULL, NULL, NULL, NULL, NULL),
  ('01', '00000005', 'وزارة المالية', NULL, NULL, NULL, NULL, NULL)
ON CONFLICT DO NOTHING;
