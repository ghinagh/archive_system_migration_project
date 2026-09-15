package com.startupstack.app.shared.aspect;

import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.PermissionService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.exception.PermissionDeniedException;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

/**
 * Intercepts controller methods annotated with {@link Permission} and enforces
 * the required bitmask against the authenticated user's config.user_permition value.
 *
 * Evaluation order:
 *   1. Verify a valid, non-anonymous authentication exists.
 *   2. Load the UserEntity by username (the JWT subject).
 *   3. Admin users (userLevel = "A") bypass the check unconditionally.
 *   4. Call {@link PermissionService#hasPermission} for all other users.
 *   5. Throw {@link PermissionDeniedException} (→ HTTP 403) if the check fails.
 */
@Aspect
@Component
public class PermissionAspect {

    private final UserRepository    userRepository;
    private final PermissionService permissionService;

    public PermissionAspect(UserRepository userRepository,
                            PermissionService permissionService) {
        this.userRepository    = userRepository;
        this.permissionService = permissionService;
    }

    @Around("@annotation(permission)")
    public Object checkPermission(ProceedingJoinPoint joinPoint,
                                  Permission permission) throws Throwable {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()
                || "anonymousUser".equals(auth.getPrincipal())) {
            throw new PermissionDeniedException("Authentication required");
        }

        String username = (String) auth.getPrincipal();

        UserEntity user = userRepository.findByUserName(username)
                .orElseThrow(() -> new PermissionDeniedException(
                        "Authenticated user not found in database: " + username));

        // Admins bypass all bitmask checks
        String level = user.getUserLevel() != null ? user.getUserLevel().trim() : "";
        if ("A".equals(level)) {
            return joinPoint.proceed();
        }

        if (!permissionService.hasPermission(user, permission.value())) {
            throw new PermissionDeniedException(
                    "User '" + username + "' lacks required permission bit " + permission.value());
        }

        return joinPoint.proceed();
    }
}
