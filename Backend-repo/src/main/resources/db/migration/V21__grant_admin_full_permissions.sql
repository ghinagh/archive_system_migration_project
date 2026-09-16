-- V12 seeded the default admin (ADM) with user_permition = 1 (PERM_VIEW only),
-- which contradicts this app's own documented convention that a full
-- administrator holds every bit (PermissionConstants.PERM_ALL = 255). With the
-- seeded value, every @Permission-gated write endpoint (including the existing
-- updateResult/deleteResult and the new by-result-no equivalents used by
-- "معالجة طلبات معينة") returns 403 for the only account this dev environment
-- has, even though SecurityUtils.isAdmin() separately reports it as an admin.
UPDATE "config" SET "user_permition" = 255 WHERE "user_no" = 'ADM';
