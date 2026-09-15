package com.startupstack.app.config.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class JwtUtilTest {

    private JwtUtil jwtUtil;

    @BeforeEach
    void setUp() {
        jwtUtil = new JwtUtil("test-only-secret-key-that-is-at-least-32-bytes-long", 86400000L);
    }

    @Test
    void generateToken_producesNonNullToken() {
        String token = jwtUtil.generateToken("admin", 255, "01", "01", "A", null);

        assertNotNull(token);
        assertFalse(token.isEmpty());
    }

    @Test
    void extractUsername_returnsCorrectUsername() {
        String token = jwtUtil.generateToken("admin", 255, "01", "01", "A", null);

        String username = jwtUtil.extractUsername(token);

        assertEquals("admin", username);
    }

    @Test
    void validateToken_validToken_returnsTrue() {
        String token = jwtUtil.generateToken("admin", 255, "01", "01", "A", null);

        assertTrue(jwtUtil.validateToken(token));
    }

    @Test
    void validateToken_invalidToken_returnsFalse() {
        assertFalse(jwtUtil.validateToken("invalid.token.value"));
    }

    @Test
    void validateToken_tamperedToken_returnsFalse() {
        String token = jwtUtil.generateToken("admin", 255, "01", "01", "A", null);
        String tampered = token.substring(0, token.length() - 5) + "XXXXX";

        assertFalse(jwtUtil.validateToken(tampered));
    }

    @Test
    void differentUsers_produceDifferentTokens() {
        String token1 = jwtUtil.generateToken("user1", 255, "01", "01", "A", null);
        String token2 = jwtUtil.generateToken("user2", 255, "01", "01", "A", null);

        assertNotEquals(token1, token2);
        assertEquals("user1", jwtUtil.extractUsername(token1));
        assertEquals("user2", jwtUtil.extractUsername(token2));
    }
}
