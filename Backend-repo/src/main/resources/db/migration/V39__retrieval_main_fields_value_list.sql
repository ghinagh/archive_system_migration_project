-- sort_from.frm:2249-2290: for out_slct1 = "main" fields, typing fills the c_getcond answer list
-- (exec SERH_main / SERH_wrd_main), so these main text fields offer a value picker like legacy.
UPDATE retrieval_field
SET lookup_enabled = TRUE
WHERE module = 'GRAPHICAL_RETRIEVAL'
  AND field_key IN ('doc_app_no', 'doc_title', 'doc_subtitle');
