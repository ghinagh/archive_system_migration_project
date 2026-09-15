/**
 * Bitmask permission flags — mirrors the backend PermissionConstants.java.
 *
 * Stored in the JWT `perm` claim and in config.user_permition (Integer).
 * Test with bitwise AND: (userPerm & PERM_DELETE) !== 0
 *
 * Bit layout:
 *   bit 0  (1)   – VIEW     : read-only access to records
 *   bit 1  (2)   – CREATE   : create new records
 *   bit 2  (4)   – UPDATE   : edit existing records
 *   bit 3  (8)   – DELETE   : remove records permanently
 *   bit 4  (16)  – ADMIN    : user-management and system configuration
 *   bit 5  (32)  – REPORTS  : generate and export reports
 *   bit 6  (64)  – EXPORT   : export data to external formats
 *   bit 7  (128) – BORROW   : issue and manage borrowing transactions
 */
export const PERM_VIEW    = 1;
export const PERM_CREATE  = 2;
export const PERM_UPDATE  = 4;
export const PERM_DELETE  = 8;
export const PERM_ADMIN   = 16;
export const PERM_REPORTS = 32;
export const PERM_EXPORT  = 64;
export const PERM_BORROW  = 128;
export const PERM_ALL     = 255;
