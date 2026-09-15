-- Create views for legacy CODING queries
-- VIEW_coding: All article types (SUB_CODE not starting with 24)
-- VIEW_coding24: All document types (SUB_CODE starting with 24)

-- Drop existing views if they exist
DROP VIEW IF EXISTS "VIEW_coding" CASCADE;
DROP VIEW IF EXISTS "VIEW_coding24" CASCADE;

-- VIEW_coding: Article types
CREATE VIEW "VIEW_coding" AS
SELECT "SUB_CODE" as code, "SUB_DESC" as description
FROM "CODING"
WHERE "SUB_LEVE" = '2'
  AND "SUB_CODE" NOT LIKE '24%'
ORDER BY code;

-- VIEW_coding24: Document types
CREATE VIEW "VIEW_coding24" AS
SELECT "SUB_CODE" as code, "SUB_DESC" as description
FROM "CODING"
WHERE "SUB_CODE" LIKE '24%'
ORDER BY code;
