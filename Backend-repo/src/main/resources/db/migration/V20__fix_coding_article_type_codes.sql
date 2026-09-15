-- Fix article type codes to start with '03' prefix (legacy VIEW_coding filter requirement)
-- This corrects the codes from 01, 02, 03 to 0301, 0302, 0303

-- Delete the old article type codes (01, 02, 03 without the 03 prefix)
DELETE FROM "CODING" WHERE "SUB_CODE" IN ('01', '02', '03');

-- Insert corrected article type codes with '03' prefix
INSERT INTO "CODING" ("SUB_CODE", "SUB_DESC", "SUB_LEVE") VALUES
('0301', 'دراسة', '2'),
('0302', 'تقرير', '2'),
('0303', 'بحث', '2');
