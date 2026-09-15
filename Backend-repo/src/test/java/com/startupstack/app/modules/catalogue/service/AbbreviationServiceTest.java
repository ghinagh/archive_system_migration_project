package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.AbbreviationRequest;
import com.startupstack.app.modules.catalogue.dto.AbbreviationResponse;
import com.startupstack.app.modules.catalogue.entity.AbbreviationEntity;
import com.startupstack.app.modules.catalogue.entity.AbbreviationId;
import com.startupstack.app.modules.catalogue.repository.AbbreviationRepository;
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
class AbbreviationServiceTest {

    @Mock
    private AbbreviationRepository abbreviationRepository;
    @InjectMocks
    private AbbreviationService abbreviationService;

    @Test
    void getByAppNo_mapsAllEntities() {
        AbbreviationEntity entity = new AbbreviationEntity();
        entity.setRelAppNo("MN000001");
        entity.setRelSerNo("01");
        entity.setRelRltvN("01");
        when(abbreviationRepository.findByRelAppNo("MN000001")).thenReturn(List.of(entity));

        List<AbbreviationResponse> result = abbreviationService.getByAppNo("MN000001");

        assertEquals(1, result.size());
        assertEquals("MN000001", result.get(0).getAppNo());
    }

    @Test
    void add_newComposite_savesEntity() {
        AbbreviationRequest request = new AbbreviationRequest("01", "02", "DESC", "T", "REL");
        when(abbreviationRepository.existsById(any(AbbreviationId.class))).thenReturn(false);
        when(abbreviationRepository.save(any(AbbreviationEntity.class)))
                .thenAnswer(inv -> inv.getArgument(0));

        AbbreviationResponse result = abbreviationService.add("MN000001", request);

        assertEquals("MN000001", result.getAppNo());
        assertEquals("02", result.getRltvN());
        verify(abbreviationRepository).save(any(AbbreviationEntity.class));
    }

    @Test
    void add_existingComposite_returnsExistingWithoutSaving() {
        AbbreviationRequest request = new AbbreviationRequest("01", "02", "DESC", "T", "REL");
        AbbreviationEntity existing = new AbbreviationEntity();
        existing.setRelAppNo("MN000001");
        existing.setRelSerNo("01");
        existing.setRelRltvN("02");
        when(abbreviationRepository.existsById(any(AbbreviationId.class))).thenReturn(true);
        when(abbreviationRepository.findById(any(AbbreviationId.class))).thenReturn(Optional.of(existing));

        AbbreviationResponse result = abbreviationService.add("MN000001", request);

        assertEquals("MN000001", result.getAppNo());
        verify(abbreviationRepository, never()).save(any());
    }

    @Test
    void delete_existing_deletesByCompositeKey() {
        when(abbreviationRepository.existsById(any(AbbreviationId.class))).thenReturn(true);

        abbreviationService.delete("MN000001", "01", "02");

        verify(abbreviationRepository).deleteByCompositeKey("MN000001", "01", "02");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(abbreviationRepository.existsById(any(AbbreviationId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> abbreviationService.delete("MN000001", "01", "02"));
        verify(abbreviationRepository, never()).deleteByCompositeKey(any(), any(), any());
    }
}
