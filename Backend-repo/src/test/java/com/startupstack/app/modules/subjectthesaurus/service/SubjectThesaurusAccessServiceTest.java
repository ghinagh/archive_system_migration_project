package com.startupstack.app.modules.subjectthesaurus.service;

import com.startupstack.app.modules.subjectthesaurus.config.SubjectThesaurusProperties;
import com.startupstack.app.modules.subjectthesaurus.dto.AccessGrantResponse;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.PermissionDeniedException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.Clock;
import java.time.Duration;
import java.time.Instant;
import java.time.ZoneOffset;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class SubjectThesaurusAccessServiceTest {

    private final SubjectThesaurusProperties properties = new SubjectThesaurusProperties();
    private SubjectThesaurusAccessService service;
    private MutableClock clock;

    @BeforeEach
    void setUp() {
        clock = new MutableClock(Instant.parse("2026-10-05T10:00:00Z"));
        service = new SubjectThesaurusAccessService(properties, clock);
        signInAs("alice");
    }

    @AfterEach
    void clear() {
        SecurityContextHolder.clearContext();
    }

    private static void signInAs(String username) {
        SecurityContextHolder.getContext().setAuthentication(
                new UsernamePasswordAuthenticationToken(username, null, List.of()));
    }

    @Test
    void legacyKey_isTheDefault() {
        assertEquals("891045", properties.getAccessKey());
    }

    @Test
    void correctKey_grantsAccess_leadingBlanksIgnoredLikeLTrim() {
        AccessGrantResponse grant = service.grant("  891045");
        assertDoesNotThrow(() -> service.verify(grant.token()));
    }

    @Test
    void wrongKey_orTrailingBlank_isRejected() {
        assertThrows(BusinessException.class, () -> service.grant("891046"));
        assertThrows(BusinessException.class, () -> service.grant("891045 "));
        assertThrows(BusinessException.class, () -> service.grant(""));
        assertThrows(BusinessException.class, () -> service.grant(null));
    }

    @Test
    void missingOrForeignOrExpiredOrRevokedGrant_isDenied() {
        assertThrows(PermissionDeniedException.class, () -> service.verify(null));
        assertThrows(PermissionDeniedException.class, () -> service.verify("made-up"));

        String token = service.grant("891045").token();
        signInAs("bob");
        assertThrows(PermissionDeniedException.class, () -> service.verify(token));

        signInAs("alice");
        clock.advance(properties.getAccessTtl().plusSeconds(1));
        assertThrows(PermissionDeniedException.class, () -> service.verify(token));

        String second = service.grant("891045").token();
        service.revoke(second);
        assertThrows(PermissionDeniedException.class, () -> service.verify(second));
    }

    private static final class MutableClock extends Clock {
        private Instant now;

        MutableClock(Instant now) {
            this.now = now;
        }

        void advance(Duration d) {
            now = now.plus(d);
        }

        @Override
        public ZoneOffset getZone() {
            return ZoneOffset.UTC;
        }

        @Override
        public Clock withZone(java.time.ZoneId zone) {
            return this;
        }

        @Override
        public Instant instant() {
            return now;
        }
    }
}
