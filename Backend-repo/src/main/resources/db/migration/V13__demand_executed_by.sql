-- Legacy USER_INTERFACE1.frm Command5_Click (:4095-4405) records who actually ran a delivery
-- by calling `upd_dmd_user_do <dmd_no>, <dmd_ser>, <box_user_no>` alongside setting
-- dmd_chek = 2. The demand row therefore carries two distinct users: dmd_user, who requested
-- the scene, and this one, who executed it. The migrated schema kept only dmd_user, so the
-- executing user had nowhere to land.
--
-- char(3) to match dmd_user and config.user_no exactly.
ALTER TABLE "demand" ADD COLUMN "dmd_user_do" char(3);

COMMENT ON COLUMN "demand"."dmd_user_do" IS
    'User who executed the delivery (legacy upd_dmd_user_do); distinct from dmd_user, who requested it.';
