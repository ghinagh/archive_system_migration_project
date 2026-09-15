-- W12 Verification Test: Position Drill-Down (proc_pos)
-- 
-- Legacy Behavior:
-- 1. User selects a form entry from catalogue lookup (view_form)
-- 2. Form entry has SUB_TYP (2 chars) + SUB_NO (8 chars) = 10-char form code
-- 3. User presses F2
-- 4. Legacy executes: "execute proc_pos '<form_code>'"
-- 5. Result: List of POS_NAM values for that form
--
-- Migrated Behavior:
-- GET /api/positions/by-form/{formCode}
-- Query: SELECT p FROM PositionEntity WHERE TRIM(p.posNo) = TRIM(formCode) ORDER BY name
--
-- Test Data Setup:
-- Insert test form code and associated positions

-- 1. Verify form table structure
SELECT COUNT(*) as form_count FROM "form" LIMIT 1;

-- 2. Verify POSITION table structure  
SELECT COUNT(*) as position_count FROM "POSITION" LIMIT 1;

-- 3. Test query with actual data
-- Find a sample form code (SUB_TYP || SUB_NO)
SELECT 
  CONCAT("SUB_TYP", "SUB_NO") as form_code,
  COUNT(*) as form_count
FROM "form"
GROUP BY CONCAT("SUB_TYP", "SUB_NO")
LIMIT 5;

-- 4. Find positions with matching codes
SELECT "POS_NO", "POS_NAM" 
FROM "POSITION"
WHERE LENGTH(TRIM("POS_NO")) = 10
LIMIT 5;

-- 5. Test the migrated query pattern
-- This should find positions for a given form code
SELECT p."POS_NO", p."POS_NAM", p."DAT_REC"
FROM "POSITION" p
WHERE TRIM(p."POS_NO") = TRIM('9901')  -- Example: SUB_TYP='99' + SUB_NO='01'
ORDER BY p."POS_NAM";

-- 6. Verify through REL_FORM relationship (if positions are linked through REL_FORM)
SELECT DISTINCT r."RLF_FORM1", p."POS_NO", p."POS_NAM"
FROM "REL_FORM" r
JOIN "POSITION" p ON r."RLF_FORM1" = p."POS_NO"
WHERE r."RLF_FORM1" LIKE '%01'  -- Example: check form codes ending in 01
LIMIT 10;
