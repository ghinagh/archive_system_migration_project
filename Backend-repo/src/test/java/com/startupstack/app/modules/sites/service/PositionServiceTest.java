package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.PositionRequest;
import com.startupstack.app.modules.sites.dto.PositionResponse;
import com.startupstack.app.modules.sites.entity.PositionEntity;
import com.startupstack.app.modules.sites.mapper.PositionMapper;
import com.startupstack.app.modules.sites.repository.PositionRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class PositionServiceTest {

    @Mock
    private PositionRepository positionRepository;
    @Mock
    private PositionMapper positionMapper;
    @InjectMocks
    private PositionService positionService;

    private PositionEntity entity;
    private PositionResponse response;

    @BeforeEach
    void setUp() {
        entity = new PositionEntity();
        entity.setPosNo("P001");
        entity.setName("رئيس القسم");

        response = new PositionResponse("P001", "رئيس القسم", null);
    }

    @Test
    void findAll_mapsPage() {
        Page<PositionEntity> page = new PageImpl<>(List.of(entity));
        when(positionRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
        when(positionMapper.toResponse(entity)).thenReturn(response);

        Page<PositionResponse> result = positionService.findAll("رئيس", Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
    }

    @Test
    void findById_existing_returnsResponse() {
        when(positionRepository.findById("P001")).thenReturn(Optional.of(entity));
        when(positionMapper.toResponse(entity)).thenReturn(response);

        PositionResponse result = positionService.findById("P001");

        assertEquals("رئيس القسم", result.name());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(positionRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> positionService.findById("MISSING"));
    }

    @Test
    void create_mapsAndSaves() {
        PositionRequest request = new PositionRequest("P001", "رئيس القسم", null);
        when(positionMapper.toEntity(request)).thenReturn(entity);
        when(positionRepository.save(entity)).thenReturn(entity);
        when(positionMapper.toResponse(entity)).thenReturn(response);

        PositionResponse result = positionService.create(request);

        assertNotNull(result);
        verify(positionRepository).save(entity);
    }

    @Test
    void update_existing_updatesAndSaves() {
        PositionRequest request = new PositionRequest("P001", "اسم جديد", null);
        when(positionRepository.findById("P001")).thenReturn(Optional.of(entity));
        when(positionRepository.save(entity)).thenReturn(entity);
        when(positionMapper.toResponse(entity)).thenReturn(response);

        positionService.update("P001", request);

        verify(positionMapper).updateEntity(request, entity);
        verify(positionRepository).save(entity);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        PositionRequest request = new PositionRequest("MISSING", "x", null);
        when(positionRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> positionService.update("MISSING", request));
    }

    @Test
    void delete_existing_deletes() {
        when(positionRepository.existsById("P001")).thenReturn(true);

        positionService.delete("P001");

        verify(positionRepository).deleteById("P001");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(positionRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> positionService.delete("MISSING"));
        verify(positionRepository, never()).deleteById(any());
    }
}
