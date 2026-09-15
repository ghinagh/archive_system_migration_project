package com.startupstack.app.modules.transactions.service;

import com.startupstack.app.modules.transactions.dto.TransRequest;
import com.startupstack.app.modules.transactions.dto.TransResponse;
import com.startupstack.app.modules.transactions.entity.TransEntity;
import com.startupstack.app.modules.transactions.entity.TransEntityId;
import com.startupstack.app.modules.transactions.mapper.TransMapper;
import com.startupstack.app.modules.transactions.repository.TransRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
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
class TransServiceTest {

    @Mock
    private TransRepository transRepository;
    @Mock
    private TransMapper transMapper;
    @InjectMocks
    private TransService transService;

    private TransEntity entity;
    private TransResponse response;

    @BeforeEach
    void setUp() {
        entity = new TransEntity();
        entity.setTrsOpno(100.0);
        entity.setTrsNo(1.0);
        entity.setTrsYear(2026.0);

        response = new TransResponse();
        response.setTrsOpno(100.0);
        response.setTrsNo(1.0);
    }

    @Test
    void findAll_delegatesToRepositoryWithSpecificationAndMapsPage() {
        Page<TransEntity> page = new PageImpl<>(List.of(entity));
        when(transRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
        when(transMapper.toResponse(entity)).thenReturn(response);

        Page<TransResponse> result = transService.findAll(100.0, 2026.0, Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
    }

    @Test
    void findById_existing_returnsResponse() {
        TransEntityId id = new TransEntityId();
        id.setTrsOpno(100.0);
        id.setTrsNo(1.0);
        when(transRepository.findById(id)).thenReturn(Optional.of(entity));
        when(transMapper.toResponse(entity)).thenReturn(response);

        TransResponse result = transService.findById(100.0, 1.0);

        assertEquals(100.0, result.getTrsOpno());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(transRepository.findById(any(TransEntityId.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> transService.findById(999.0, 1.0));
    }

    @Test
    void create_mapsAndSaves() {
        TransRequest request = new TransRequest();
        request.setTrsOpno(100.0);
        request.setTrsNo(1.0);
        when(transMapper.toEntity(request)).thenReturn(entity);
        when(transRepository.save(entity)).thenReturn(entity);
        when(transMapper.toResponse(entity)).thenReturn(response);

        TransResponse result = transService.create(request);

        assertNotNull(result);
        verify(transRepository).save(entity);
    }

    @Test
    void update_existing_updatesAndSaves() {
        TransRequest request = new TransRequest();
        request.setTrsYear(2027.0);
        when(transRepository.findById(any(TransEntityId.class))).thenReturn(Optional.of(entity));
        when(transRepository.save(entity)).thenReturn(entity);
        when(transMapper.toResponse(entity)).thenReturn(response);

        transService.update(100.0, 1.0, request);

        verify(transMapper).updateEntity(request, entity);
        verify(transRepository).save(entity);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        TransRequest request = new TransRequest();
        when(transRepository.findById(any(TransEntityId.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> transService.update(999.0, 1.0, request));
    }

    @Test
    void delete_existing_deletes() {
        when(transRepository.existsById(any(TransEntityId.class))).thenReturn(true);

        transService.delete(100.0, 1.0);

        ArgumentCaptor<TransEntityId> captor = ArgumentCaptor.forClass(TransEntityId.class);
        verify(transRepository).deleteById(captor.capture());
        assertEquals(100.0, captor.getValue().getTrsOpno());
        assertEquals(1.0, captor.getValue().getTrsNo());
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(transRepository.existsById(any(TransEntityId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> transService.delete(999.0, 1.0));
        verify(transRepository, never()).deleteById(any());
    }

    @Test
    void findByPeriodical_delegatesToRepositoryAndMapsPage() {
        Page<TransEntity> page = new PageImpl<>(List.of(entity));
        when(transRepository.findByTrsNo(100.0, Pageable.unpaged())).thenReturn(page);
        when(transMapper.toResponse(entity)).thenReturn(response);

        Page<TransResponse> result = transService.findByPeriodical(100.0, Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
    }
}
