package com.startupstack.app.shared.util;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Static helpers to read JWT claims stored as request attributes by
 * {@code JwtAuthenticationFilter}.  Call only from request-scoped code
 * (controllers, services, aspects) — never from background threads.
 */
public final class SecurityUtils {

    private SecurityUtils() {
    }

    /** Returns the {@code user_ent} claim for the current request, or {@code null}. */
    public static String getCurrentUserEnt() {
        return getAttribute("userEnt");
    }

    /** Returns the {@code user_doc} claim for the current request, or {@code null}. */
    public static String getCurrentUserDoc() {
        return getAttribute("userDoc");
    }

    /**
     * Returns the username (JWT {@code sub} claim) for the current request,
     * or {@code null} when the request is unauthenticated.
     */
    public static String getCurrentUsername() {
        var ctx = SecurityContextHolder.getContext();
        if (ctx != null) {
            var auth = ctx.getAuthentication();
            if (auth != null && auth.isAuthenticated()) {
                return auth.getName();
            }
        }
        return null;
    }

    /** Returns the {@code user_level} claim for the current request, or {@code null}. */
    public static String getCurrentUserLevel() {
        return getAttribute("userLevel");
    }

    /**
     * Returns {@code true} when the authenticated user has admin level ("A").
     * Admins bypass entity-scoped data filters.
     */
    public static boolean isAdmin() {
        return "A".equals(getCurrentUserLevel());
    }

    /**
     * Returns the {@code site_wly} (wilaya number) claim for the current request,
     * or {@code null} when the user is an admin (wilaya restriction does not apply
     * to admins) or when the claim is absent from the token.
     */
    public static Integer getCurrentUserWilaya() {
        if (isAdmin()) return null;
        var attrs = RequestContextHolder.getRequestAttributes();
        if (attrs instanceof ServletRequestAttributes sra) {
            Object val = sra.getRequest().getAttribute("siteWly");
            if (val instanceof Integer i) return i;
            if (val != null) {
                try { return Integer.valueOf(val.toString()); }
                catch (NumberFormatException ignored) { return null; }
            }
        }
        return null;
    }

    private static String getAttribute(String name) {
        var attrs = RequestContextHolder.getRequestAttributes();
        if (attrs instanceof ServletRequestAttributes sra) {
            Object val = sra.getRequest().getAttribute(name);
            return val != null ? val.toString() : null;
        }
        return null;
    }
}
