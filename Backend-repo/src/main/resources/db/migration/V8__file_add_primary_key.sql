-- FILE_ADD (legacy document-to-document "additional file" relationship links) was carried
-- over from SQL Server with no primary key at all. The entity previously faked one off
-- Postgres's internal "ctid" system column, which is not a stable identifier (it changes
-- on every UPDATE/VACUUM), so any delete-by-id or repeat read was unsafe. Give it a real
-- generated key, same convention as every other new/completed table in this schema.
ALTER TABLE "FILE_ADD" ADD COLUMN id UUID NOT NULL DEFAULT gen_random_uuid();
ALTER TABLE "FILE_ADD" ADD PRIMARY KEY (id);
