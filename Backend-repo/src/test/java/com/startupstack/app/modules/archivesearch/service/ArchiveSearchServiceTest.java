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
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

/** The legacy USER_INTERFACE1 query: native SELECT DISTINCT over view_result, paginated in memory. */
@ExtendWith(MockitoExtension.class)
class ArchiveSearchServiceTest {

    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    @InjectMocks
    private ArchiveSearchService service;

    /** One row in the SELECT's column order (res_res_no … dig_typ_high, mn_result). */
    private Object[] sampleRow(String appNo) {
        return new Object[] {
                1, appNo, "عنوان تجريبي", "عنوان اضافي", "فيديو", LocalDateTime.of(2013, 1, 1, 0, 0), "12", "النهار",
                "000005", "avi", "04", 0,
                30, 0, 1, 45, 0, 1, "مؤلف", null, "مستخلص"
        };
    }

    private String runAndCaptureSql(ArchiveSearchRequest request, List<Object> rows, int page) {
        when(entityManager.createNativeQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(rows);
        service.search(request, PageRequest.of(page, 10));
        ArgumentCaptor<String> sql = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createNativeQuery(sql.capture());
        return sql.getValue();
    }

    @Test
    void search_withNoFilters_omitsWhereClause() {
        String sql = runAndCaptureSql(new ArchiveSearchRequest(), List.of(), 0);

        assertTrue(sql.contains("FROM view_result v"));
        // the only WHERE is inside the dig_typ_high column subquery, never after FROM view_result
        assertFalse(sql.contains("FROM view_result v WHERE"), "no filters set should produce no WHERE clause");
    }

    @Test
    void search_withWordFilter_addsLikeClauseOnTitleAndAbstract() {
        ArchiveSearchRequest request = new ArchiveSearchRequest();
        request.setWord("عباس");

        String sql = runAndCaptureSql(request, List.of(), 0);

        assertTrue(sql.contains("v.mn_result"));
        assertTrue(sql.contains("v.mn_act_ttl"));
        assertTrue(sql.contains("LIKE :word0"));
        verify(query).setParameter("word0", "%عباس%");
    }

    @Test
    void search_withDescriptorNo_joinsAnalisAndRelative() {
        ArchiveSearchRequest request = new ArchiveSearchRequest();
        request.setDescriptorNo("020000000");

        String sql = runAndCaptureSql(request, List.of(), 0);

        assertTrue(sql.contains("LEFT JOIN \"ANALIS\" an"));
        assertTrue(sql.contains("LEFT JOIN \"RELATIVE\" rel"));
        assertTrue(sql.contains("an.\"AN_DESC_NO\" = :descriptorNo OR rel.\"REL_REL_NO\" = :descriptorNo"));
    }

    @Test
    void search_mapsRowsIntoResponseAndPaginatesInMemory() {
        ArchiveSearchRequest request = new ArchiveSearchRequest();
        request.setWord("x");
        when(entityManager.createNativeQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.<Object>of((Object) sampleRow("ق000050")));

        Page<ArchiveSearchResultResponse> page = service.search(request, PageRequest.of(0, 10));

        assertEquals(1, page.getTotalElements());
        ArchiveSearchResultResponse r = page.getContent().get(0);
        assertEquals("ق000050", r.getAppNo());
        assertEquals("عنوان تجريبي", r.getActiveTitleAr());
        assertEquals("000005", r.getDigitNo());
        assertEquals("000005", r.getMachineStock());
        assertEquals(30, r.getDurationSeconds());
        assertEquals("مؤلف", r.getResponsiblePersonName());
    }

    @Test
    void search_secondPage_returnsRemainder() {
        ArchiveSearchRequest request = new ArchiveSearchRequest();
        request.setWord("x");
        List<Object> rows = new ArrayList<>();
        for (int i = 0; i < 13; i++) {
            rows.add(sampleRow(String.format("ق%06d", i)));
        }
        when(entityManager.createNativeQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(rows);

        Page<ArchiveSearchResultResponse> page = service.search(request, PageRequest.of(1, 10));

        assertEquals(13, page.getTotalElements());
        assertEquals(3, page.getContent().size());
        assertEquals("ق000010", page.getContent().get(0).getAppNo());
    }
}
