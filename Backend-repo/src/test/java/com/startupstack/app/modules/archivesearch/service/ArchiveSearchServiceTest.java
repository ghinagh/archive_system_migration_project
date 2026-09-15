package com.startupstack.app.modules.archivesearch.service;

import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchRequest;
import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchResultResponse;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ArchiveSearchServiceTest {

    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    @InjectMocks
    private ArchiveSearchService service;

    private Object[] sampleRow() {
        return new Object[] {
                "0000001", "عنوان تجريبي", "عنوان اضافي", LocalDateTime.now(), "12", "دورية تجريبية",
                "DIG001", "T", "01", "وصف النوع", 1, "H01", 1234.0,
                0, 1, 30, 0, 1, 45, "مؤلف"
        };
    }

    @Test
    void search_withNoFilters_omitsWhereClause() {
        when(entityManager.createQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.of());

        service.search(new ArchiveSearchRequest(), PageRequest.of(0, 10));

        ArgumentCaptor<String> jpql = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createQuery(jpql.capture());
        assertFalse(jpql.getValue().contains("WHERE"), "no filters set should produce no WHERE clause");
    }

    @Test
    void search_withWordFilter_addsLikeClauseOnTitleFields() {
        ArchiveSearchRequest req = new ArchiveSearchRequest();
        req.setWord("harvest");
        when(entityManager.createQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.of());

        service.search(req, PageRequest.of(0, 10));

        ArgumentCaptor<String> jpql = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createQuery(jpql.capture());
        assertTrue(jpql.getValue().contains("c.activeTitleAr LIKE :word0"));
        verify(query).setParameter("word0", "%harvest%");
    }

    @Test
    void search_withDescriptorNo_usesExistsSubqueryAcrossAnalisAndRelative() {
        ArchiveSearchRequest req = new ArchiveSearchRequest();
        req.setDescriptorNo("D100");
        when(entityManager.createQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.of());

        service.search(req, PageRequest.of(0, 10));

        ArgumentCaptor<String> jpql = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createQuery(jpql.capture());
        assertTrue(jpql.getValue().contains("SubjectAnalysisEntity"));
        assertTrue(jpql.getValue().contains("RelativeEntity"));
        verify(query).setParameter("descriptorNo", "D100");
    }

    @Test
    void search_mapsRowsIntoResponseAndPaginatesInMemory() {
        when(entityManager.createQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.of(sampleRow(), sampleRow(), sampleRow()));

        Page<ArchiveSearchResultResponse> page = service.search(new ArchiveSearchRequest(), PageRequest.of(0, 2));

        assertEquals(3, page.getTotalElements());
        assertEquals(2, page.getContent().size());
        assertEquals("0000001", page.getContent().get(0).getAppNo());
        assertEquals("1234", page.getContent().get(0).getMachineStock());
    }

    @Test
    void search_secondPage_returnsRemainder() {
        when(entityManager.createQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.of(sampleRow(), sampleRow(), sampleRow()));

        Page<ArchiveSearchResultResponse> page = service.search(new ArchiveSearchRequest(), PageRequest.of(1, 2));

        assertEquals(3, page.getTotalElements());
        assertEquals(1, page.getContent().size());
    }
}
