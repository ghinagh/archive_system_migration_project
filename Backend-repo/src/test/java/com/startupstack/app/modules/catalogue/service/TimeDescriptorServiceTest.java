package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.TimeDescriptorRequest;
import com.startupstack.app.modules.catalogue.dto.TimeDescriptorResponse;
import com.startupstack.app.modules.catalogue.entity.TimeDescriptorEntity;
import com.startupstack.app.modules.catalogue.entity.TimeDescriptorId;
import com.startupstack.app.modules.catalogue.repository.TimeDescriptorRepository;
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
class TimeDescriptorServiceTest {

    @Mock
    private TimeDescriptorRepository timeDescriptorRepository;
    @InjectMocks
    private TimeDescriptorService timeDescriptorService;

    @Test
    void getByAppNo_mapsAllEntities() {
        TimeDescriptorEntity entity = new TimeDescriptorEntity();
        entity.setTmAppNo("MN000001");
        entity.setTmSerNo("01");
        entity.setTmRltvNo("01");
        when(timeDescriptorRepository.findByTmAppNo("MN000001")).thenReturn(List.of(entity));

        List<TimeDescriptorResponse> result = timeDescriptorService.getByAppNo("MN000001");

        assertEquals(1, result.size());
        assertEquals("MN000001", result.get(0).getAppNo());
    }

    @Test
    void add_newComposite_savesEntity() {
        TimeDescriptorRequest request = new TimeDescriptorRequest("01", "02", "DESC", 1.0, 0.0, 0.0, 1.0, 30.0, 0.0);
        when(timeDescriptorRepository.existsById(any(TimeDescriptorId.class))).thenReturn(false);
        when(timeDescriptorRepository.save(any(TimeDescriptorEntity.class))).thenAnswer(inv -> inv.getArgument(0));

        TimeDescriptorResponse result = timeDescriptorService.add("MN000001", request);

        assertEquals("MN000001", result.getAppNo());
        assertEquals(1.0, result.getStartHour());
        verify(timeDescriptorRepository).save(any(TimeDescriptorEntity.class));
    }

    @Test
    void add_existingComposite_returnsExistingWithoutSaving() {
        TimeDescriptorRequest request = new TimeDescriptorRequest("01", "02", "DESC", 1.0, 0.0, 0.0, 1.0, 30.0, 0.0);
        TimeDescriptorEntity existing = new TimeDescriptorEntity();
        existing.setTmAppNo("MN000001");
        existing.setTmSerNo("01");
        existing.setTmRltvNo("02");
        when(timeDescriptorRepository.existsById(any(TimeDescriptorId.class))).thenReturn(true);
        when(timeDescriptorRepository.findById(any(TimeDescriptorId.class))).thenReturn(Optional.of(existing));

        TimeDescriptorResponse result = timeDescriptorService.add("MN000001", request);

        assertEquals("MN000001", result.getAppNo());
        verify(timeDescriptorRepository, never()).save(any());
    }

    @Test
    void delete_existing_deletesByCompositeKey() {
        when(timeDescriptorRepository.existsById(any(TimeDescriptorId.class))).thenReturn(true);

        timeDescriptorService.delete("MN000001", "01", "02");

        verify(timeDescriptorRepository).deleteByCompositeKey("MN000001", "01", "02");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(timeDescriptorRepository.existsById(any(TimeDescriptorId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> timeDescriptorService.delete("MN000001", "01", "02"));
        verify(timeDescriptorRepository, never()).deleteByCompositeKey(any(), any(), any());
    }
}
