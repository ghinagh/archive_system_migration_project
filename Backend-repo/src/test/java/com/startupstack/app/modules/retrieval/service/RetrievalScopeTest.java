package com.startupstack.app.modules.retrieval.service;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/** Legacy sort_from.frm arr_table / tm_innerjoin construction for the periodicals screen. */
class RetrievalScopeTest {

    private static final RetrievalScope P = RetrievalScope.PERIODICALS;

    @Test
    void firstConditionOnPeriodRootsOnPeriodAndLeftJoinsTrans() {
        assertEquals(" FROM PeriodicalEntity p LEFT JOIN TransEntity t ON t.trsNo = p.perNo ",
                P.fromClause(List.of("p", "t"), List.of("t")));
    }

    @Test
    void firstConditionOnTransRootsOnTransEvenWhenAPeriodConditionFollows() {
        assertEquals(" FROM TransEntity t LEFT JOIN PeriodicalEntity p ON t.trsNo = p.perNo ",
                P.fromClause(List.of("t", "p"), List.of("p")));
    }

    @Test
    void singleTableIsSelectedAlone() {
        assertEquals(" FROM TransEntity t ", P.fromClause(List.of("t"), List.of("t")));
        assertEquals(" FROM PeriodicalEntity p ", P.fromClause(List.of("p"), List.of("p")));
    }

    @Test
    void displayedTableIsAppendedAfterConditionTables() {
        assertEquals(" FROM TransEntity t LEFT JOIN PeriodicalEntity p ON t.trsNo = p.perNo ",
                P.fromClause(List.of("t"), List.of("p", "t")));
    }

    @Test
    void placeOfIssueBringsPeriodAndTheFormJoin() {
        assertEquals(" FROM TransEntity t LEFT JOIN PeriodicalEntity p ON t.trsNo = p.perNo "
                        + "LEFT JOIN FormEntity g ON g.formNo = p.geo ",
                P.fromClause(List.of("t"), List.of("g")));
    }

    @Test
    void placeOfIssueIsPickedByNameButComparedByPeriodCode() {
        RetrievalScope.CodedCondition coded = P.codedCondition("issue_place");
        assertEquals("g.formNo", coded.codeColumn());
        assertEquals("p.geo", coded.conditionColumn());
        assertEquals("p", coded.conditionAlias());
        assertNull(P.codedCondition("periodical_name"));
        assertNull(RetrievalScope.BANK.codedCondition("issue_place"));
        assertNull(RetrievalScope.ADDITIONAL_FILES.codedCondition("issue_place"));
    }

    @Test
    void onlyPeriodicalsDistinctsOnOutputOnlyAndOtherScopesKeepTheirSkeleton() {
        assertTrue(P.distinctOnOutputOnly());
        assertFalse(RetrievalScope.BANK.distinctOnOutputOnly());
        assertFalse(RetrievalScope.ADDITIONAL_FILES.distinctOnOutputOnly());
        assertEquals(RetrievalScope.BANK.joinSkeleton(), RetrievalScope.BANK.fromClause(List.of("t"), List.of()));
        assertEquals(RetrievalScope.ADDITIONAL_FILES.joinSkeleton(),
                RetrievalScope.ADDITIONAL_FILES.fromClause(List.of("f"), List.of()));
    }
}
