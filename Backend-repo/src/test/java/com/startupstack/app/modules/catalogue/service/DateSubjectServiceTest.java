package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.DateSubjectRequest;
import com.startupstack.app.modules.catalogue.dto.DateSubjectResponse;
import com.startupstack.app.modules.catalogue.entity.DateSubjectEntity;
import com.startupstack.app.modules.catalogue.entity.DateSubjectId;
import com.startupstack.app.modules.catalogue.repository.DateSubjectRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class DateSubjectServiceTest {

    @Mock
    private DateSubjectRepository dateSubjectRepository;
    @InjectMocks
    private DateSubjectService dateSubjectService;

    @Test
    void getByAppNo_mapsAllEntities() {
        DateSubjectEntity entity = new DateSubjectEntity();
        entity.setDteAppNo("MN000001");
        entity.setDteSerNo("01");
        entity.setDteRelNo("01");
        when(dateSubjectRepository.findByDteAppNo("MN000001")).thenReturn(List.of(entity));

        List<DateSubjectResponse> result = dateSubjectService.getByAppNo("MN000001");

        assertEquals(1, result.size());
        assertEquals("MN000001", result.get(0).appNo());
    }

    @Test
    void addDateSubject_newComposite_savesEntity() {
        DateSubjectRequest request = new DateSubjectRequest("01", "02", "DESC", null, null);
        when(dateSubjectRepository.existsById(any(DateSubjectId.class))).thenReturn(false);
        when(dateSubjectRepository.save(any(DateSubjectEntity.class)))
                .thenAnswer(inv -> inv.getArgument(0));

        DateSubjectResponse result = dateSubjectService.addDateSubject("MN000001", request);

        assertEquals("MN000001", result.appNo());
        verify(dateSubjectRepository).save(any(DateSubjectEntity.class));
    }

    @Test
    void addDateSubject_existingComposite_returnsExistingWithoutSaving() {
        DateSubjectRequest request = new DateSubjectRequest("01", "02", "DESC", null, null);
        DateSubjectEntity existing = new DateSubjectEntity();
        existing.setDteAppNo("MN000001");
        existing.setDteSerNo("01");
        existing.setDteRelNo("02");
        when(dateSubjectRepository.existsById(any(DateSubjectId.class))).thenReturn(true);
        when(dateSubjectRepository.findById(any(DateSubjectId.class))).thenReturn(Optional.of(existing));

        DateSubjectResponse result = dateSubjectService.addDateSubject("MN000001", request);

        assertEquals("MN000001", result.appNo());
        verify(dateSubjectRepository, never()).save(any());
    }

    @Test
    void deleteDateSubject_existing_deletesByCompositeKey() {
        when(dateSubjectRepository.existsById(any(DateSubjectId.class))).thenReturn(true);

        dateSubjectService.deleteDateSubject("MN000001", "01", "02");

        verify(dateSubjectRepository).deleteByCompositeKey("MN000001", "01", "02");
    }

    @Test
    void deleteDateSubject_nonExistent_throwsResourceNotFound() {
        when(dateSubjectRepository.existsById(any(DateSubjectId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> dateSubjectService.deleteDateSubject("MN000001", "01", "02"));
        verify(dateSubjectRepository, never()).deleteByCompositeKey(any(), any(), any());
    }
}
