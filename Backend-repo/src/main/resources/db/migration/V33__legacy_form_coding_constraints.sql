-- المكنز الشكلي (legacy coding.frm) — restore the legacy relational model of form / POSITION /
-- REL_FORM / SUBJECT. The legacy SQL Server tables had no keys or foreign keys at all; the baseline
-- added constraints that contradict how the legacy procedures store data:
--
--  * REL_FORM.RLF_FORM1/RLF_FORM2, SUBJECT.SUB_FORM, sites.sit_no and posts.post_no hold the
--    10-character form code SUB_TYP + SUB_NO (insr_rel_form / insr_subject are called with
--    sub_typ & sub_no; recorded legacy queries compare rel_form.rlf_form2 = '0200100010' and join
--    rel_form.rlf_form1 = position.pos_no). Foreign keys to the 8-character form.SUB_NO (and to
--    POSITION.POS_NO at the same time) can never be satisfied.
--  * form rows are identified by SUB_TYP + SUB_NO (find_form / upd_form / del_form all filter on
--    both); op_form numbers each type separately, so the same SUB_NO legitimately repeats across
--    types (e.g. the per-type country rows XXX00000).
--  * POSITION keeps several rows per person: proc_pos lists all rows of one pos_no by dat_rec,
--    upd_position / del_position match pos_no AND pos_nam.
--
-- SUBJECT.SUB_MCNZ -> MACNZ.SUB_CODE matches the legacy meaning and is kept.

ALTER TABLE "REL_FORM" DROP CONSTRAINT IF EXISTS "REL_FORM_RLF_FORM1_fkey";
ALTER TABLE "REL_FORM" DROP CONSTRAINT IF EXISTS "REL_FORM_RLF_FORM1_fkey1";
ALTER TABLE "REL_FORM" DROP CONSTRAINT IF EXISTS "REL_FORM_RLF_FORM2_fkey";
ALTER TABLE "SUBJECT" DROP CONSTRAINT IF EXISTS "SUBJECT_SUB_FORM_fkey";
ALTER TABLE "posts" DROP CONSTRAINT IF EXISTS "posts_post_no_fkey";
ALTER TABLE "sites" DROP CONSTRAINT IF EXISTS "sites_sit_no_fkey";
ALTER TABLE "POSITION" DROP CONSTRAINT IF EXISTS "uq_position_no";
ALTER TABLE "form" DROP CONSTRAINT IF EXISTS "uq_form_no";
