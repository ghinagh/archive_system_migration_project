package com.startupstack.app.modules.catalogue.service;

import org.hibernate.resource.jdbc.spi.StatementInspector;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Pageable;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Verifies that CatalogueService.findAll() injects a LEFT JOIN to the sites table
 * and a WHERE predicate on sit_wly_no when the authenticated user's JWT carries a
 * non-null siteWly claim.
 *
 * SQL is captured via Hibernate's StatementInspector, registered through a test-specific
 * Spring Boot property so this context is isolated from other @SpringBootTest contexts.
 * Requires the "test" profile datasource (macnz_manar_test) to be running.
 */
@SpringBootTest(
        webEnvironment = SpringBootTest.WebEnvironment.NONE,
        properties = "spring.jpa.properties.hibernate.session_factory.statement_inspector=" +
                     "com.startupstack.app.modules.catalogue.service.CatalogueWilayaIntegrationTest$SqlCaptor"
)
@ActiveProfiles("test")
class CatalogueWilayaIntegrationTest {

    @Autowired
    private CatalogueService catalogueService;

    @BeforeEach
    void clearCapturedSql() {
        SqlCaptor.CAPTURED.get().clear();
    }

    @AfterEach
    void resetRequestContext() {
        RequestContextHolder.resetRequestAttributes();
    }

    @Test
    void findAll_withSiteWlyClaim_joinsToSitesAndFiltersOnWilyaNo() {
        // Simulate a non-admin JWT with siteWly = 3
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setAttribute("userLevel", "U");   // not admin
        request.setAttribute("siteWly", 3);
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));

        catalogueService.findAll(null, null, null, Pageable.ofSize(1));

        List<String> sqls = SqlCaptor.CAPTURED.get().stream()
                .map(String::toLowerCase)
                .toList();

        assertTrue(
                sqls.stream().anyMatch(s -> s.contains("join") && s.contains("sites")),
                "Expected the generated SQL to contain a JOIN to the 'sites' table. " +
                "Captured SQL: " + sqls
        );
        assertTrue(
                sqls.stream().anyMatch(s -> s.contains("sit_wly_no")),
                "Expected the generated SQL to contain a predicate on 'sit_wly_no'. " +
                "Captured SQL: " + sqls
        );
    }

    @Test
    void findAll_withAdminUser_doesNotJoinToSites() {
        // Admin users bypass all scoped filters — no JOIN should be emitted
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setAttribute("userLevel", "A");   // admin
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));

        catalogueService.findAll(null, null, null, Pageable.ofSize(1));

        List<String> sqls = SqlCaptor.CAPTURED.get().stream()
                .map(String::toLowerCase)
                .toList();

        assertTrue(
                sqls.stream().noneMatch(s -> s.contains("sit_wly_no")),
                "Admin queries must not filter on sit_wly_no. Captured SQL: " + sqls
        );
    }

    // --- SQL capturing infrastructure ---

    public static class SqlCaptor implements StatementInspector {

        static final ThreadLocal<List<String>> CAPTURED = ThreadLocal.withInitial(ArrayList::new);

        public SqlCaptor() {
        }

        @Override
        public String inspect(String sql) {
            CAPTURED.get().add(sql);
            return sql;
        }
    }
}
