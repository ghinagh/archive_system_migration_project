-- "طبيعة الوثيقة" (document nature: public/secret) as entered on the legacy
-- Form6 "استمارة التوثيق" screen (m_mn_typ). No existing column on "main"
-- carries this value: MN_TYP is already used elsewhere as the resource-type
-- discriminator (A/B/N/P), so this is a new, separately-named column.
ALTER TABLE "main" ADD COLUMN mn_doc_nature char(1);
