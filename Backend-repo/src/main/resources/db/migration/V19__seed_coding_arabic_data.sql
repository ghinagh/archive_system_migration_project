-- Seed CODING table with Arabic article types and document types
-- Article Types: codes 01-03
-- Document Types: codes 2401-2403

-- Delete existing test data if it exists
DELETE FROM "CODING" WHERE "SUB_LEVE" = '2' AND ("SUB_CODE" IN ('01', '02', '03', '2401', '2402', '2403'));

-- Insert Article Types (SUB_LEVE = '2')
INSERT INTO "CODING" ("SUB_CODE", "SUB_DESC", "SUB_LEVE") VALUES
('01', 'دراسة', '2'),
('02', 'تقرير', '2'),
('03', 'بحث', '2');

-- Insert Document Types (SUB_LEVE = '2', codes starting with 24)
INSERT INTO "CODING" ("SUB_CODE", "SUB_DESC", "SUB_LEVE") VALUES
('2401', 'فيديو', '2'),
('2402', 'صوت', '2'),
('2403', 'صورة', '2');
