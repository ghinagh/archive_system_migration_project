-- Fixes a mismapped CODING domain '24' ("شكل الوثيقة") row discovered while implementing the
-- Form6.frm DataGrid1 Column04 file-upload flow.
--
-- V19 seeded '2401' -> 'فيديو' (video), but Form6.frm's own literal branches
-- (datagrid1_DblClick :3432-3468, DBList4_KeyPress :3848 `If m_typ_auther = "04" Then
-- DataGrid1.Columns(3).value = "avi"`) tie DIG_TYP1 = "04", not "01", to video — "01" instead
-- routes to the scan folder (m_cnf_path_pic + "scan\"). '2402' (صوت/waves) and '2403'
-- (صورة/photo) already match the same source correctly and are left untouched.
--
-- '2401' is removed rather than relabelled: the correct Arabic label for DIG_TYP1 = "01"
-- (scan) has not been found in the traced legacy source, and leaving a guessed label here
-- would be fabricating data this project's own rules forbid. The video option now lives at
-- the code Form6.frm actually checks for it.
DELETE FROM "CODING" WHERE "SUB_LEVE" = '2' AND "SUB_CODE" = '2401';

INSERT INTO "CODING" ("SUB_CODE", "SUB_DESC", "SUB_LEVE") VALUES
('2404', 'فيديو', '2');
