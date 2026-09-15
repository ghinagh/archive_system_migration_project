package com.startupstack.app.shared;

import com.startupstack.app.modules.users.entity.UserEntity;
import org.springframework.stereotype.Service;

/**
 * Evaluates whether a user holds a required permission bit.
 *
 * The permission model is a bitmask stored in config.user_permition.
 * Use {@link com.startupstack.app.shared.constants.PermissionConstants}
 * for the named bit values.
 *
 * Admin users (userLevel = "A") always pass, regardless of the bitmask,
 * so callers that want to enforce admin-only access should combine this
 * check with a level check.
 */
@Service
public class PermissionService {

    /**
     * Returns true when the user's permission integer contains all bits
     * set in {@code requiredPermission}.
     *
     * @param user               the authenticated UserEntity loaded from config table
     * @param requiredPermission bitmask constant from PermissionConstants (e.g. PERM_DELETE = 8)
     */
    public boolean hasPermission(UserEntity user, int requiredPermission) {
        int granted = user.getUserPermission() != null ? user.getUserPermission() : 0;
        return (granted & requiredPermission) != 0;
    }
}
