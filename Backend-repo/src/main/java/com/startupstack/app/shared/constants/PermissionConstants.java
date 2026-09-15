package com.startupstack.app.shared.constants;

/**
 * Bitmask permission flags stored in config.user_permition (Integer).
 *
 * Each value is a distinct power of two so that combinations can be stored
 * as a single integer and tested with bitwise AND:
 *   hasPermission = (user.userPermission & PERM_DELETE) != 0
 *
 * Legacy mapping (VB6 config_users.frm):
 *   The original system stored an integer permission level in the config table.
 *   These constants formalise that integer as explicit named bits so that
 *   each feature's access level can be checked independently.
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
 *
 * Example – a standard librarian: PERM_VIEW | PERM_CREATE | PERM_UPDATE | PERM_BORROW = 135
 * Example – a full administrator: all bits set = 255
 */
public final class PermissionConstants {

    private PermissionConstants() {}

    /** Read-only access to all catalogue records. */
    public static final int PERM_VIEW = 1;

    /** Create new catalogue, book, article, or related records. */
    public static final int PERM_CREATE = 2;

    /** Edit and update existing records. */
    public static final int PERM_UPDATE = 4;

    /** Permanently delete records. */
    public static final int PERM_DELETE = 8;

    /** Access user-management screens and system configuration. */
    public static final int PERM_ADMIN = 16;

    /** Generate, preview, and print reports from bnkout templates. */
    public static final int PERM_REPORTS = 32;

    /** Export data to CSV, Excel, or PDF formats. */
    public static final int PERM_EXPORT = 64;

    /** Issue, extend, and close borrowing (ISTARA) transactions. */
    public static final int PERM_BORROW = 128;

    /** Convenience mask: all permissions granted. */
    public static final int PERM_ALL = 255;
}
