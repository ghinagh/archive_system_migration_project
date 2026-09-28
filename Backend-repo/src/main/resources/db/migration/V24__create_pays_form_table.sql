-- Legacy PERIOD1.frm ("استمارة الدورية") binds مكان الصدور 1/2 (PER_GEO1/PER_GEO)
-- to DBCombo controls whose RecordSource is "select * from pays_form order by sub_name"
-- (ListField=SUB_NAME, BoundColumn=SUB_NO). This table does not exist in the old SQL
-- Server DDL dump, the new Postgres baseline, or the DBML — it was never migrated.
-- Structure mirrors the sibling "form" lookup table (same SUB_NO/SUB_NAME/SUB_TYP shape
-- used throughout this legacy app's place/institution-style lookups). Left empty; rows
-- are expected to be supplied separately (e.g. imported from the legacy live database).
CREATE TABLE "pays_form" (
  "SUB_TYP" varchar(2),
  "SUB_NO" varchar(8) PRIMARY KEY,
  "SUB_NAME" varchar(60),
  "SUB_DTE" timestamp
);
