-- V24 created "pays_form" as a stand-alone table on the belief that it was missing from the
-- legacy DDL. It is not missing: legacy macnz_manar_ddl.sql defines it as a VIEW over form —
--   CREATE VIEW dbo.pays_form AS SELECT TOP 100 PERCENT dbo.form.* FROM dbo.form
--   WHERE (SUB_TYP = '04') AND (SUBSTRING(SUB_NO, 4, 5) = '00000') ORDER BY SUB_NAME
-- i.e. the countries maintained in المكنز الشكلي (coding.frm). PERIOD1.frm's مكان الصدور 1/2
-- read it, so the separate table could never show a country created through the UI.
-- ORDER BY SUB_NAME is applied by the reading service (a view cannot guarantee row order).
DROP TABLE IF EXISTS "pays_form";

CREATE VIEW "pays_form" AS
SELECT f.*
FROM form f
WHERE f."SUB_TYP" = '04'
  AND SUBSTRING(f."SUB_NO", 4, 5) = '00000';
