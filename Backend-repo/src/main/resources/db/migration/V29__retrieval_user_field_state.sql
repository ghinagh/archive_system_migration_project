-- Persists the per-user "حقول العرض في الجدول" state that legacy keeps in
-- view_user_bnkout/user_bnkout, scoped by user_no (sort_form.frm Form_Load, lines 2078-2081):
--   BNKOUT2.sql = "select * from view_user_bnkout where (user_no = '<box_user_no>')
--                  and (user_out_choice = 1 or user_out_choice = 2) and (user_ist_no = '01')
--                  order by user_out_index"
-- i.e. the list only ever shows fields THAT user has already marked (display and/or order),
-- and that mark survives across logins/page loads. This table mirrors the real legacy columns
-- (user_no, user_out_choice -> display, user_out_choi1 -> order_mark) scoped to our app's own
-- user identity (the JWT subject / username) in place of legacy's "user_no" primary key.
CREATE TABLE retrieval_user_field (
    id          UUID         NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    user_no     VARCHAR(100) NOT NULL,
    field_key   VARCHAR(50)  NOT NULL,
    display     BOOLEAN      NOT NULL DEFAULT FALSE, -- legacy user_out_choice
    order_mark  BOOLEAN      NOT NULL DEFAULT FALSE,  -- legacy user_out_choi1 (F10)
    created_at  TIMESTAMP    NOT NULL DEFAULT now(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX idx_retrieval_user_field_user_key ON retrieval_user_field(user_no, field_key);

-- The F2 "#" marker (DBList2_77) toggles out_chioce/out_chio1 on the bnkout CATALOGUE row
-- itself (confirmed earlier: these columns live on bnkout, not user_bnkout — i.e. it is a
-- global per-field flag, not per-user). Reproduced here as columns on retrieval_field.
ALTER TABLE retrieval_field ADD COLUMN hash_marked BOOLEAN NOT NULL DEFAULT FALSE; -- out_chioce
ALTER TABLE retrieval_field ADD COLUMN hash_chio1 INT; -- out_chio1 (1, 2, or NULL/unset)
