package com.startupstack.app.config.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JwtUtil {

    private final SecretKey signingKey;
    private final long expirationMs;

    public JwtUtil(@Value("${app.jwt.secret}") String secret,
                   @Value("${app.jwt.expiration-ms:86400000}") long expirationMs) {
        this.signingKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.expirationMs = expirationMs;
    }

    /**
     * Generates a JWT containing the username, permission bitmask, and the user's
     * entity ({@code user_ent}), document type ({@code user_doc}), access level
     * ({@code user_level}), and wilaya number ({@code site_wly}) as custom claims.
     * {@code site_wly} is omitted from the token when {@code siteWly} is null.
     */
    public String generateToken(String username, Integer permission,
                                String userEnt, String userDoc, String userLevel,
                                Integer siteWly) {
        Date now = new Date();
        var builder = Jwts.builder()
                .subject(username)
                .claim("perm",       permission != null ? permission : 0)
                .claim("user_ent",   userEnt   != null ? userEnt.trim()   : "")
                .claim("user_doc",   userDoc   != null ? userDoc.trim()   : "")
                .claim("user_level", userLevel != null ? userLevel.trim() : "G");
        if (siteWly != null) {
            builder.claim("site_wly", siteWly);
        }
        return builder
                .issuedAt(now)
                .expiration(new Date(now.getTime() + expirationMs))
                .signWith(signingKey)
                .compact();
    }

    public String extractUsername(String token) {
        return extractClaims(token).getSubject();
    }

    /** Extracts the {@code perm} claim; returns 0 if absent. */
    public int extractPermission(String token) {
        Object raw = extractClaims(token).get("perm");
        if (raw instanceof Integer i) return i;
        if (raw instanceof Long l)    return l.intValue();
        return 0;
    }

    /** Extracts the {@code user_ent} claim; returns empty string if absent. */
    public String extractUserEnt(String token) {
        Object raw = extractClaims(token).get("user_ent");
        return raw != null ? raw.toString() : "";
    }

    /** Extracts the {@code user_doc} claim; returns empty string if absent. */
    public String extractUserDoc(String token) {
        Object raw = extractClaims(token).get("user_doc");
        return raw != null ? raw.toString() : "";
    }

    /** Extracts the {@code user_level} claim; returns "G" if absent. */
    public String extractUserLevel(String token) {
        Object raw = extractClaims(token).get("user_level");
        return raw != null ? raw.toString() : "G";
    }

    /** Extracts the {@code site_wly} (wilaya number) claim; returns {@code null} if absent. */
    public Integer extractSiteWly(String token) {
        Object raw = extractClaims(token).get("site_wly");
        if (raw instanceof Integer i) return i;
        if (raw instanceof Long l)    return l.intValue();
        return null;
    }

    /** Generates a scoped 10-minute OTP token used only for the change-password flow. */
    public String generateOtpToken(String username) {
        Date now = new Date();
        return Jwts.builder()
                .subject(username)
                .claim("scope", "pwd_change")
                .issuedAt(now)
                .expiration(new Date(now.getTime() + 10 * 60 * 1000L))
                .signWith(signingKey)
                .compact();
    }

    /** Returns true only if the token is valid AND carries the pwd_change scope. */
    public boolean validateOtpToken(String token) {
        try {
            Claims claims = extractClaims(token);
            return "pwd_change".equals(claims.get("scope"));
        } catch (Exception e) {
            return false;
        }
    }

    public boolean validateToken(String token) {
        try {
            extractClaims(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private Claims extractClaims(String token) {
        return Jwts.parser()
                .verifyWith(signingKey)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
}
