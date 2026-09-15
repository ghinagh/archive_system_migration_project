package com.startupstack.app.modules.corrections.service;

import com.startupstack.app.modules.corrections.dto.CorrectionLogResponse;
import com.startupstack.app.modules.corrections.entity.CorrectionLogEntity;
import com.startupstack.app.modules.corrections.repository.CorrectionLogRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CorrectionLogServiceTest {

    @Mock
    private CorrectionLogRepository repository;
    @InjectMocks
    private CorrectionLogService correctionLogService;

    @Test
    void logChange_savesEntryWithSystemUser_whenUnauthenticated() {
        correctionLogService.logChange("MN000001", "activeTitleAr", "old", "new", "typo fix");

        ArgumentCaptor<CorrectionLogEntity> captor = ArgumentCaptor.forClass(CorrectionLogEntity.class);
        verify(repository).save(captor.capture());
        CorrectionLogEntity saved = captor.getValue();

        assertEquals("MN000001", saved.getAppNo());
        assertEquals("activeTitleAr", saved.getFieldName());
        assertEquals("old", saved.getOldValue());
        assertEquals("new", saved.getNewValue());
        assertEquals("typo fix", saved.getCorrectionReason());
        assertEquals("system", saved.getCorrectedByUser());
        assertNotNull(saved.getCorrectedAt());
    }

    @Test
    void getCorrections_mapsEntitiesToResponsesInOrder() {
        CorrectionLogEntity entry = new CorrectionLogEntity();
        entry.setAppNo("MN000001");
        entry.setCorrectedAt(LocalDateTime.now());
        entry.setCorrectedByUser("librarian1");
        entry.setFieldName("activeTitleAr");
        entry.setOldValue("old");
        entry.setNewValue("new");
        entry.setCorrectionReason("typo fix");
        when(repository.findByAppNoOrderByCorrectedAtDesc("MN000001")).thenReturn(List.of(entry));

        List<CorrectionLogResponse> result = correctionLogService.getCorrections("MN000001");

        assertEquals(1, result.size());
        assertEquals("librarian1", result.get(0).getCorrectedByUser());
        assertEquals("new", result.get(0).getNewValue());
    }

    @Test
    void getCorrections_noHistory_returnsEmptyList() {
        when(repository.findByAppNoOrderByCorrectedAtDesc("MN999999")).thenReturn(List.of());

        List<CorrectionLogResponse> result = correctionLogService.getCorrections("MN999999");

        assertTrue(result.isEmpty());
    }
}
