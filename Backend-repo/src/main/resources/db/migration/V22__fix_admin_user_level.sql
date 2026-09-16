-- SecurityUtils.isAdmin() checks "A".equals(getCurrentUserLevel()) — the exact same
-- convention the (now-removed) frontend isAdmin check used. V12 seeded the default
-- admin with user_level = '1', which satisfies neither check, so every admin-gated
-- action (including "الغاء الطلب" here and the app's other admin-only operations)
-- returns 409/403 for the only account this dev environment has.
UPDATE "config" SET "user_level" = 'A' WHERE "user_no" = 'ADM';
