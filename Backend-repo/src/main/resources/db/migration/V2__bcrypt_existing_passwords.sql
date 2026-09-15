-- Widen the password column to accommodate BCrypt hashes (60 chars).
-- Legacy passwords were stored as plain text in char(15).
ALTER TABLE "config" ALTER COLUMN "user_password" TYPE varchar(72);

-- IMPORTANT: This migration only changes the column size.
-- It does NOT convert existing plain-text passwords to BCrypt hashes.
-- PostgreSQL has no native BCrypt function, so the actual password hashing
-- must be performed by the application.
--
-- After deploying the new system, an administrator must call the one-time
-- migration endpoint:
--
--   POST /api/admin/migrate-passwords
--
-- That endpoint reads every user, detects plain-text passwords (those not
-- starting with "$2a$" or "$2b$"), hashes them with BCryptPasswordEncoder,
-- and saves the result back. Until this endpoint is run, the login service
-- supports both plain-text and BCrypt comparison as a transitional measure.
