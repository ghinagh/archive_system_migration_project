package com.startupstack.app.modules.retrieval.service;

import com.startupstack.app.modules.retrieval.dto.RetrievalConditionNode;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchRequest;
import com.startupstack.app.modules.retrieval.repository.RetrievalUserFieldRepository;
import com.startupstack.app.modules.retrievalfields.entity.RetrievalFieldEntity;
import com.startupstack.app.modules.retrievalfields.repository.RetrievalFieldRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

/** "استـرجـاع الصحف والمجلات": مكان الصدور is compared by its code, like legacy add_question. */
@ExtendWith(MockitoExtension.class)
class RetrievalServicePeriodicalsTest {

    @Mock
    private RetrievalFieldRepository fieldRepository;
    @Mock
    private RetrievalUserFieldRepository userFieldRepository;
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    @InjectMocks
    private RetrievalService service;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(service, "entityManager", entityManager);
        when(fieldRepository.findByModuleAndEnabledTrue("PERIODICALS_RETRIEVAL")).thenReturn(List.of(
                field("periodical_name", "name", null),
                field("issue_place", "name", "g")));
        when(entityManager.createQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.of());
    }

    @Test
    void placeOfIssueConditionComparesTheStoredCodeNotTheName() {
        RetrievalConditionNode cond = new RetrievalConditionNode();
        cond.setType("FIELD");
        cond.setConjunction("AND");
        cond.setFieldKey("issue_place");
        cond.setOperator("EQUALS");
        cond.setValue("ZZ900000");

        service.search(RetrievalScope.PERIODICALS, request(cond, List.of("periodical_name")));

        ArgumentCaptor<String> jpql = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createQuery(jpql.capture());
        assertEquals("SELECT DISTINCT p.name FROM PeriodicalEntity p  WHERE p.geo = :v0", jpql.getValue());
        verify(query).setParameter("v0", "ZZ900000");
    }

    @Test
    void displayedPlaceOfIssueStillShowsTheFormName() {
        RetrievalConditionNode cond = new RetrievalConditionNode();
        cond.setType("FIELD");
        cond.setConjunction("AND");
        cond.setFieldKey("issue_place");
        cond.setOperator("EQUALS");
        cond.setValue("ZZ900000");

        service.search(RetrievalScope.PERIODICALS, request(cond, List.of("issue_place")));

        ArgumentCaptor<String> jpql = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createQuery(jpql.capture());
        assertEquals("SELECT DISTINCT g.name FROM PeriodicalEntity p LEFT JOIN FormEntity g ON g.formNo = p.geo "
                + " WHERE p.geo = :v0", jpql.getValue());
    }

    private static RetrievalSearchRequest request(RetrievalConditionNode cond, List<String> outputs) {
        RetrievalSearchRequest r = new RetrievalSearchRequest();
        r.setRootCondition(cond);
        r.setOutputFieldKeys(outputs);
        r.setPage(0);
        r.setSize(25);
        return r;
    }

    private static RetrievalFieldEntity field(String key, String path, String join) {
        RetrievalFieldEntity f = new RetrievalFieldEntity();
        f.setFieldKey(key);
        f.setEntityPath(path);
        f.setJoinPath(join);
        f.setFieldType("STRING");
        f.setLabel(key);
        f.setEnabled(true);
        return f;
    }
}
