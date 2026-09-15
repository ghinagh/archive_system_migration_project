package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.SubjectLinkRequest;
import com.startupstack.app.modules.sites.dto.SubjectLinkResponse;
import com.startupstack.app.modules.sites.entity.SubjectLinkEntity;
import com.startupstack.app.modules.sites.entity.SubjectLinkId;
import com.startupstack.app.modules.sites.repository.SubjectLinkRepository;
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
class SubjectLinkServiceTest {

    @Mock
    private SubjectLinkRepository subjectLinkRepository;
    @InjectMocks
    private SubjectLinkService subjectLinkService;

    @Test
    void getByFormNo_mapsAllEntities() {
        SubjectLinkEntity entity = new SubjectLinkEntity();
        entity.setSubForm("F0000001");
        entity.setSubMcnz("MCZ000001");
        when(subjectLinkRepository.findBySubForm("F0000001")).thenReturn(List.of(entity));

        List<SubjectLinkResponse> result = subjectLinkService.getByFormNo("F0000001");

        assertEquals(1, result.size());
        assertEquals("F0000001", result.get(0).formNo());
    }

    @Test
    void addSubject_newComposite_savesEntity() {
        SubjectLinkRequest request = new SubjectLinkRequest("MCZ000001", null, null, "01");
        when(subjectLinkRepository.existsById(any(SubjectLinkId.class))).thenReturn(false);
        when(subjectLinkRepository.save(any(SubjectLinkEntity.class))).thenAnswer(inv -> inv.getArgument(0));

        SubjectLinkResponse result = subjectLinkService.addSubject("F0000001", request);

        assertEquals("F0000001", result.formNo());
        assertEquals("MCZ000001", result.mcnzCode());
        verify(subjectLinkRepository).save(any(SubjectLinkEntity.class));
    }

    @Test
    void addSubject_existingComposite_returnsExistingWithoutSaving() {
        SubjectLinkRequest request = new SubjectLinkRequest("MCZ000001", null, null, "01");
        SubjectLinkEntity existing = new SubjectLinkEntity();
        existing.setSubForm("F0000001");
        existing.setSubMcnz("MCZ000001");
        when(subjectLinkRepository.existsById(any(SubjectLinkId.class))).thenReturn(true);
        when(subjectLinkRepository.findById(any(SubjectLinkId.class))).thenReturn(Optional.of(existing));

        SubjectLinkResponse result = subjectLinkService.addSubject("F0000001", request);

        assertEquals("F0000001", result.formNo());
        verify(subjectLinkRepository, never()).save(any());
    }

    @Test
    void deleteSubject_existing_deletesByCompositeKey() {
        when(subjectLinkRepository.existsById(any(SubjectLinkId.class))).thenReturn(true);

        subjectLinkService.deleteSubject("F0000001", "MCZ000001");

        verify(subjectLinkRepository).deleteBySubFormAndSubMcnz("F0000001", "MCZ000001");
    }

    @Test
    void deleteSubject_nonExistent_throwsResourceNotFound() {
        when(subjectLinkRepository.existsById(any(SubjectLinkId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> subjectLinkService.deleteSubject("F0000001", "MCZ000001"));
        verify(subjectLinkRepository, never()).deleteBySubFormAndSubMcnz(any(), any());
    }
}
