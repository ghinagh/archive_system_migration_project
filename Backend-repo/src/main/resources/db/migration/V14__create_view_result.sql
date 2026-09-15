-- Create view_result view for archive search results
-- This view replicates the legacy SQL Server view_result used by USER_INTERFACE1.frm DataGrid1
-- Maps all 19 columns expected by the legacy search results grid

DROP VIEW IF EXISTS view_result;

CREATE VIEW view_result AS
SELECT
  -- Column 0: res_res_no (Responsible Person ID from RES table)
  COALESCE(CAST(r."RES_RES_NO" AS INTEGER), 0) AS res_res_no,

  -- Columns 1-3: Main record info (from main/catalogue table)
  m."MN_APP_NO" AS mn_app_no,
  COALESCE(m."MN_ACT_TTL", '') AS mn_act_ttl,
  COALESCE(m."MN_ADD_TTL", '') AS mn_add_ttl,

  -- Column 4: dig_typ2 / docTypeDescription (Document Type description - from CODING table)
  COALESCE(c."SUB_DESC", COALESCE(d."DIG_TYP1", '')) AS dig_typ2,

  -- Column 5: art_dte (Date - from ARTICLE table)
  a."ART_DTE" AS art_dte,

  -- Column 6: art_pg_no (Page Number - from ARTICLE table)
  COALESCE(a."ART_PG_NO", '') AS art_pg_no,

  -- Column 7: art_per_no / periodicalName (Source/Periodical Name - from PERIOD table)
  COALESCE(p."PER_PER_NA", '') AS art_per_no,

  -- Column 8: dig_dig_no (Digital Number - from DIGIT table)
  COALESCE(d."DIG_DIG_NO", '') AS dig_dig_no,

  -- Column 9: dig_typ (File Type - from DIGIT table)
  COALESCE(d."DIG_TYP", '') AS dig_typ,

  -- Column 10: dig_typ1 (Document Type code - from DIGIT table)
  COALESCE(d."DIG_TYP1", '') AS dig_typ1,

  -- Column 11: dig_choice (hidden - from DIGIT table)
  COALESCE(CAST(d."dig_choice" AS INTEGER), 0) AS dig_choice,

  -- Columns 12-14: Time From (seconds, hours, minutes)
  COALESCE(CAST(d."DIG_S" AS INTEGER), 0) AS dig_s,      -- From Seconds
  COALESCE(CAST(d."DIG_O" AS INTEGER), 0) AS dig_o,      -- From Hours
  COALESCE(CAST(d."DIG_M" AS INTEGER), 0) AS dig_m,      -- From Minutes

  -- Columns 15-17: Time To (seconds, hours, minutes)
  COALESCE(CAST(d."DIG_S1" AS INTEGER), 0) AS dig_s1,    -- To Seconds
  COALESCE(CAST(d."DIG_O1" AS INTEGER), 0) AS dig_o1,    -- To Hours
  COALESCE(CAST(d."DIG_M1" AS INTEGER), 0) AS dig_m1,    -- To Minutes

  -- Column 18: aut_nam (Responsible Person Name - from AUTHER table)
  COALESCE(au."AUT_NAM", '') AS aut_nam

FROM "main" m
LEFT JOIN "ARTICLE" a ON m."MN_APP_NO" = a."ART_APP_NO"
LEFT JOIN "DIGIT" d ON m."MN_APP_NO" = d."DIG_NO"
LEFT JOIN "RES" r ON m."MN_APP_NO" = r."RES_APP_NO"
LEFT JOIN "PERIOD" p ON a."ART_PER_NO" = p."PER_PER_NO"
LEFT JOIN "AUTHER" au ON CAST(r."RES_RES_NO" AS float) = au."AUT_NO"
LEFT JOIN "CODING" c ON CONCAT('24', d."DIG_TYP1") = c."SUB_CODE"
ORDER BY a."ART_DTE" DESC;

-- Add comment documenting the view
COMMENT ON VIEW view_result IS
  'Legacy archive search results view. Used by archive-search-cockpit component to display search results.
   Replicates the SQL Server view_result from USER_INTERFACE1.frm DataGrid1.
   Maps ARTICLE + DIGIT + RES + PERIOD + CODING tables to provide all 18 columns needed for the results grid.';
