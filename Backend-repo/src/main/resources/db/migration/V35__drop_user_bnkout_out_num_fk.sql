-- معالجة المستخدمين (legacy config_users.frm) — strict legacy user_bnkout.
--
-- Legacy user_bnkout has no foreign key (the legacy DDL defines none at all). config_users F4 fills it
-- with insr_user_bnkout from bnkout ("نوع الاستمارة" 3801) OR from pout (any other form type), and
-- proc_user_pout reads those rows back joined to pout. The migrated FK to bnkout."OUT_NUM" rejected
-- every pout field number that is not also a bnkout number, so it is dropped.
ALTER TABLE user_bnkout DROP CONSTRAINT IF EXISTS user_bnkout_user_out_num_fkey;
