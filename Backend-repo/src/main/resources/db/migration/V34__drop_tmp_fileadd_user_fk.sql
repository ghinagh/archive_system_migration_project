-- "ملفات اضافية للادخال" (legacy tmp_file.frm) — رقم الموثق (tmp_fileadd.tmp_user_no) is a free char(3)
-- in legacy: the SQL Server database declared no foreign keys at all, and config.user_no (nullable, no
-- primary/unique key) could not even be referenced. DataGrid1 accepted any value of up to 3 characters,
-- blank or NULL, whether or not that user exists. The baseline's FK to config.user_no is not legacy.
ALTER TABLE tmp_fileadd DROP CONSTRAINT IF EXISTS tmp_fileadd_tmp_user_no_fkey;
