package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.RelFormRequest;
import com.startupstack.app.modules.sites.dto.RelFormResponse;
import com.startupstack.app.modules.sites.entity.RelFormEntity;
import com.startupstack.app.modules.sites.entity.RelFormId;
import com.startupstack.app.modules.sites.repository.RelFormRepository;
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
class RelFormServiceTest {

    @Mock
    private RelFormRepository relFormRepository;
    @InjectMocks
    private RelFormService relFormService;

    @Test
    void getByFormNo_mapsAllEntities() {
        RelFormEntity entity = new RelFormEntity();
        entity.setRlfForm1("F0000001");
        entity.setRlfForm2("F0000002");
        when(relFormRepository.findByRlfForm1("F0000001")).thenReturn(List.of(entity));

        List<RelFormResponse> result = relFormService.getByFormNo("F0000001");

        assertEquals(1, result.size());
        assertEquals("F0000001", result.get(0).form1No());
    }

    @Test
    void addRelatedForm_newComposite_savesEntity() {
        RelFormRequest request = new RelFormRequest("F0000002", null, null, "01");
        when(relFormRepository.existsById(any(RelFormId.class))).thenReturn(false);
        when(relFormRepository.save(any(RelFormEntity.class))).thenAnswer(inv -> inv.getArgument(0));

        RelFormResponse result = relFormService.addRelatedForm("F0000001", request);

        assertEquals("F0000001", result.form1No());
        assertEquals("F0000002", result.form2No());
        verify(relFormRepository).save(any(RelFormEntity.class));
    }

    @Test
    void addRelatedForm_existingComposite_returnsExistingWithoutSaving() {
        RelFormRequest request = new RelFormRequest("F0000002", null, null, "01");
        RelFormEntity existing = new RelFormEntity();
        existing.setRlfForm1("F0000001");
        existing.setRlfForm2("F0000002");
        when(relFormRepository.existsById(any(RelFormId.class))).thenReturn(true);
        when(relFormRepository.findById(any(RelFormId.class))).thenReturn(Optional.of(existing));

        RelFormResponse result = relFormService.addRelatedForm("F0000001", request);

        assertEquals("F0000001", result.form1No());
        verify(relFormRepository, never()).save(any());
    }

    @Test
    void deleteRelatedForm_existing_deletesByCompositeKey() {
        when(relFormRepository.existsById(any(RelFormId.class))).thenReturn(true);

        relFormService.deleteRelatedForm("F0000001", "F0000002");

        verify(relFormRepository).deleteByRlfForm1AndRlfForm2("F0000001", "F0000002");
    }

    @Test
    void deleteRelatedForm_nonExistent_throwsResourceNotFound() {
        when(relFormRepository.existsById(any(RelFormId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> relFormService.deleteRelatedForm("F0000001", "F0000002"));
        verify(relFormRepository, never()).deleteByRlfForm1AndRlfForm2(any(), any());
    }
}
