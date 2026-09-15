-- Seed default admin user if it doesn't exist
-- Username: admin
-- Password: admin123 (plain text - will be auto-migrated to BCrypt on first login)

INSERT INTO "config" (
    "user_no",
    "user_name",
    "user_password",
    "user_level",
    "user_permition",
    "user_ent",
    "user_doc",
    "USER_PWD"
) VALUES (
    'ADM',
    'admin',
    'admin123',
    '1',
    1,
    NULL,
    NULL,
    0
) ON CONFLICT ("user_no") DO NOTHING;
