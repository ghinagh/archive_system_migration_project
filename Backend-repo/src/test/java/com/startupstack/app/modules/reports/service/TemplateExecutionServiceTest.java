package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.reports.dto.TemplateExecutionResponse;
import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import com.startupstack.app.modules.reports.repository.ReportTemplateRepository;
import com.startupstack.app.shared.exception.ReportGenerationException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TemplateExecutionServiceTest {

    @Mock
    private ReportTemplateRepository templateRepository;
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    @InjectMocks
    private TemplateExecutionService templateExecutionService;

    @BeforeEach
    void setUp() {
        lenient().when(entityManager.createNativeQuery(anyString())).thenReturn(query);
        lenient().when(query.setParameter(anyString(), any())).thenReturn(query);
    }

    private ReportTemplateEntity baseRow() {
        ReportTemplateEntity row = new ReportTemplateEntity();
        row.setOutputNum(1.0);
        row.setDescription("تقرير الكتب");
        row.setSelectClause("main");
        row.setName("APP_NO");
        row.setSubCondition("main.[MN_APP_NO]");
        row.setNature("1");
        return row;
    }

    @Test
    void execute_noTemplatesFound_throwsResourceNotFound() {
        when(templateRepository.findByOutputNumOrderByIdAsc(99.0)).thenReturn(List.of());

        assertThrows(ResourceNotFoundException.class,
                () -> templateExecutionService.execute(99, Map.of()));
        verifyNoInteractions(entityManager);
    }

    @Test
    void execute_regularField_buildsQuotedColumnExpression() {
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(baseRow()));
        when(query.getResultList()).thenReturn(List.of(new Object[] { "MN000001" }));

        TemplateExecutionResponse result = templateExecutionService.execute(1, Map.of());

        ArgumentCaptor<String> sqlCaptor = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createNativeQuery(sqlCaptor.capture());
        String sql = sqlCaptor.getValue();

        assertTrue(sql.contains("\"main\".\"MN_APP_NO\" AS \"APP_NO\""));
        assertTrue(sql.contains("FROM \"main\""));
        assertEquals(1, result.columns().size());
        assertEquals("APP_NO", result.columns().get(0).fieldName());
        assertEquals(1, result.rows().size());
        assertEquals("MN000001", result.rows().get(0).get("APP_NO"));
    }

    @Test
    void execute_sqlInjectionInMainCondition_isStrippedFromQuery() {
        ReportTemplateEntity row = baseRow();
        row.setMainCondition("1=1; DROP TABLE main; --");
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(row));
        when(query.getResultList()).thenReturn(List.of());

        templateExecutionService.execute(1, Map.of());

        ArgumentCaptor<String> sqlCaptor = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createNativeQuery(sqlCaptor.capture());
        String sql = sqlCaptor.getValue().toUpperCase();

        assertFalse(sql.contains("DROP"));
        assertFalse(sql.contains(";"));
    }

    @Test
    void execute_disallowedTableName_isIgnoredAndFallsBackToMain() {
        ReportTemplateEntity row = baseRow();
        row.setSelectClause("sys.objects"); // not in ALLOWED_TABLES
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(row));
        when(query.getResultList()).thenReturn(List.of());

        templateExecutionService.execute(1, Map.of());

        ArgumentCaptor<String> sqlCaptor = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createNativeQuery(sqlCaptor.capture());
        String sql = sqlCaptor.getValue();

        assertTrue(sql.contains("FROM \"main\""));
    }

    @Test
    void execute_noUsableColumns_fallsBackToDefaultAppNoAndTitle() {
        ReportTemplateEntity row = new ReportTemplateEntity();
        row.setOutputNum(1.0);
        row.setSelectClause("main");
        // no name/subCondition set -> selectParts stays empty
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(row));
        when(query.getResultList()).thenReturn(List.of());

        TemplateExecutionResponse result = templateExecutionService.execute(1, Map.of());

        assertEquals(2, result.columns().size());
        assertEquals("MN_APP_NO", result.columns().get(0).fieldName());
    }

    @Test
    void execute_lookupJoinNature2_buildsLeftJoinAndSelectsDisplayField() {
        ReportTemplateEntity row = new ReportTemplateEntity();
        row.setOutputNum(1.0);
        row.setSelectClause("main");
        row.setNature("2");
        row.setName("PUBLISHER");
        row.setSelectClause1("auther");
        row.setSubCondition1("main.[MN_APP_NO] = auther.[AUT_NO]");
        row.setCodeName("AUT_NAME");
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(row));
        when(query.getResultList()).thenReturn(List.of());

        templateExecutionService.execute(1, Map.of());

        ArgumentCaptor<String> sqlCaptor = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createNativeQuery(sqlCaptor.capture());
        String sql = sqlCaptor.getValue();

        assertTrue(sql.contains("LEFT JOIN \"auther\""));
        assertTrue(sql.contains("\"auther\".\"AUT_NAME\" AS \"PUBLISHER\""));
    }

    @Test
    void execute_allowedUserFilter_addsParameterizedIlikeCondition() {
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(baseRow()));
        when(query.getResultList()).thenReturn(List.of());

        templateExecutionService.execute(1, Map.of("MN_TYP", "B"));

        ArgumentCaptor<String> sqlCaptor = ArgumentCaptor.forClass(String.class);
        verify(entityManager).createNativeQuery(sqlCaptor.capture());
        verify(query).setParameter(eq("p0"), eq("%B%"));
        assertTrue(sqlCaptor.getValue().contains("ILIKE :p0"));
    }

    @Test
    void execute_maliciousUserFilterColumn_isSkipped() {
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(baseRow()));
        when(query.getResultList()).thenReturn(List.of());

        templateExecutionService.execute(1, Map.of("col; DROP TABLE main; --", "x"));

        verify(query, never()).setParameter(anyString(), any());
    }

    @Test
    void execute_queryFailure_wrapsInReportGenerationException() {
        when(templateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of(baseRow()));
        when(query.getResultList()).thenThrow(new RuntimeException("db down"));

        assertThrows(ReportGenerationException.class, () -> templateExecutionService.execute(1, Map.of()));
    }
}
