-- The legacy SQL Server tables (macnz_manar_ddl.sql) declare no PRIMARY KEY and no UNIQUE constraint.
-- The keys the migration put on legacy tables are dropped so their structure is the legacy one and
-- real legacy rows (which may repeat a number) load as they are. The application keeps its own
-- duplicate checks where a screen used to rely on these keys (المؤلفين, المكنز الموضوعي, المستخدمين).
-- Tables that exist only in the migrated application keep their keys.

ALTER TABLE "ANALIS" DROP CONSTRAINT IF EXISTS "ANALIS_pkey";
ALTER TABLE "ARTICLE" DROP CONSTRAINT IF EXISTS "ARTICLE_pkey";
ALTER TABLE "AUTHER" DROP CONSTRAINT IF EXISTS "uq_auther_no";
ALTER TABLE "BOOK" DROP CONSTRAINT IF EXISTS "uq_book_app_no";
ALTER TABLE "CHARIT" DROP CONSTRAINT IF EXISTS "CHARIT_pkey";
ALTER TABLE "CHARIT" DROP CONSTRAINT IF EXISTS "uq_charit_no";
ALTER TABLE "DIGIT" DROP CONSTRAINT IF EXISTS "DIGIT_pkey";
ALTER TABLE "DIGIT" DROP CONSTRAINT IF EXISTS "uq_digit_dig_no";
ALTER TABLE "FILE_ADD" DROP CONSTRAINT IF EXISTS "FILE_ADD_pkey";
ALTER TABLE "GEO" DROP CONSTRAINT IF EXISTS "GEO_pkey";
ALTER TABLE "ISTARA" DROP CONSTRAINT IF EXISTS "ISTARA_pkey";
ALTER TABLE "MACNZ" DROP CONSTRAINT IF EXISTS "uq_macnz_code";
ALTER TABLE "NAROWER" DROP CONSTRAINT IF EXISTS "NAROWER_pkey";
ALTER TABLE "OPR_CHRT" DROP CONSTRAINT IF EXISTS "OPR_CHRT_pkey";
ALTER TABLE "PERIOD" DROP CONSTRAINT IF EXISTS "uq_period_no";
ALTER TABLE "PERSON" DROP CONSTRAINT IF EXISTS "uq_person_no";
ALTER TABLE "POUT" DROP CONSTRAINT IF EXISTS "POUT_pkey";
ALTER TABLE "RELATIVE" DROP CONSTRAINT IF EXISTS "RELATIVE_pkey";
ALTER TABLE "RES" DROP CONSTRAINT IF EXISTS "RES_pkey";
ALTER TABLE bnkout DROP CONSTRAINT IF EXISTS "bnkout_pkey";
ALTER TABLE bnkout DROP CONSTRAINT IF EXISTS "uq_bnkout_num";
ALTER TABLE catogorie DROP CONSTRAINT IF EXISTS "catogorie_pkey";
ALTER TABLE config DROP CONSTRAINT IF EXISTS "uq_config_user_no";
ALTER TABLE demand DROP CONSTRAINT IF EXISTS "demand_pkey";
ALTER TABLE main DROP CONSTRAINT IF EXISTS "main_pkey";
ALTER TABLE posts DROP CONSTRAINT IF EXISTS "posts_pkey";
ALTER TABLE ranjpath DROP CONSTRAINT IF EXISTS "ranjpath_pkey";
ALTER TABLE result DROP CONSTRAINT IF EXISTS "result_pkey";
ALTER TABLE user_bnkout DROP CONSTRAINT IF EXISTS "user_bnkout_pkey";

-- Plain (non-unique) indexes on the same columns, so lookups keep the speed the keys gave.
-- An index is not a constraint: it accepts every legacy row and changes no behaviour.
CREATE INDEX IF NOT EXISTS "ix_ANALIS_pkey" ON "ANALIS" ("AUTO");
CREATE INDEX IF NOT EXISTS "ix_ARTICLE_pkey" ON "ARTICLE" ("ART_APP_NO");
CREATE INDEX IF NOT EXISTS "ix_uq_auther_no" ON "AUTHER" ("AUT_NO");
CREATE INDEX IF NOT EXISTS "ix_uq_book_app_no" ON "BOOK" ("BK_APP_NO");
CREATE INDEX IF NOT EXISTS "ix_CHARIT_pkey" ON "CHARIT" (auto);
CREATE INDEX IF NOT EXISTS "ix_uq_charit_no" ON "CHARIT" ("CHA_NO");
CREATE INDEX IF NOT EXISTS "ix_DIGIT_pkey" ON "DIGIT" ("DIG_NO", "DIG_SER");
CREATE INDEX IF NOT EXISTS "ix_uq_digit_dig_no" ON "DIGIT" ("DIG_DIG_NO");
CREATE INDEX IF NOT EXISTS "ix_FILE_ADD_pkey" ON "FILE_ADD" (id);
CREATE INDEX IF NOT EXISTS "ix_GEO_pkey" ON "GEO" (auto);
CREATE INDEX IF NOT EXISTS "ix_ISTARA_pkey" ON "ISTARA" ("IAR_NO", iar_serial, iar_ist_typ);
CREATE INDEX IF NOT EXISTS "ix_uq_macnz_code" ON "MACNZ" ("SUB_CODE");
CREATE INDEX IF NOT EXISTS "ix_NAROWER_pkey" ON "NAROWER" ("AUTO");
CREATE INDEX IF NOT EXISTS "ix_OPR_CHRT_pkey" ON "OPR_CHRT" (auto);
CREATE INDEX IF NOT EXISTS "ix_uq_period_no" ON "PERIOD" ("PER_PER_NO");
CREATE INDEX IF NOT EXISTS "ix_uq_person_no" ON "PERSON" ("PRS_NO");
CREATE INDEX IF NOT EXISTS "ix_POUT_pkey" ON "POUT" (auto);
CREATE INDEX IF NOT EXISTS "ix_RELATIVE_pkey" ON "RELATIVE" ("AUTO");
CREATE INDEX IF NOT EXISTS "ix_RES_pkey" ON "RES" ("AUTO");
CREATE INDEX IF NOT EXISTS "ix_bnkout_pkey" ON bnkout (auto);
CREATE INDEX IF NOT EXISTS "ix_uq_bnkout_num" ON bnkout ("OUT_NUM");
CREATE INDEX IF NOT EXISTS "ix_catogorie_pkey" ON catogorie (auto);
CREATE INDEX IF NOT EXISTS "ix_uq_config_user_no" ON config (user_no);
CREATE INDEX IF NOT EXISTS "ix_demand_pkey" ON demand (auto);
CREATE INDEX IF NOT EXISTS "ix_main_pkey" ON main ("MN_APP_NO");
CREATE INDEX IF NOT EXISTS "ix_posts_pkey" ON posts (post_serial);
CREATE INDEX IF NOT EXISTS "ix_ranjpath_pkey" ON ranjpath (rjp_no);
CREATE INDEX IF NOT EXISTS "ix_result_pkey" ON result (auto);
CREATE INDEX IF NOT EXISTS "ix_user_bnkout_pkey" ON user_bnkout (user_ist_no, user_no, user_out_num);
