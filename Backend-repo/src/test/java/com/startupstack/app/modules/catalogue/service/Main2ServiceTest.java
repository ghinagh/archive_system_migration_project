package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.Main2Request;
import com.startupstack.app.modules.catalogue.dto.Main2Response;
import com.startupstack.app.modules.catalogue.entity.Main2Entity;
import com.startupstack.app.modules.catalogue.mapper.Main2Mapper;
import com.startupstack.app.modules.catalogue.repository.Main2Repository;
import com.startupstack.app.shared.exception.BusinessException;
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

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class Main2ServiceTest {

    @Mock
    private Main2Repository main2Repository;
    @Mock
    private Main2Mapper main2Mapper;
    @InjectMocks
    private Main2Service main2Service;

    private Main2Entity entity;
    private Main2Response response;
    private Main2Request request;

    @BeforeEach
    void setUp() {
        entity = new Main2Entity();
        entity.setAppNo("MN000001");

        response = new Main2Response("MN000001", null, null, null, null, null, null, null, null, null,
                null, null, null, null, null, null, null, null, null, null, null, null);

        request = new Main2Request(null, null, null, null, null, null, null, null, null, null, null, null);
    }

    @Test
    void findAll_mapsPage() {
        Page<Main2Entity> page = new PageImpl<>(List.of(entity));
        when(main2Repository.findAll(Pageable.unpaged())).thenReturn(page);
        when(main2Mapper.toResponse(entity)).thenReturn(response);

        Page<Main2Response> result = main2Service.findAll(Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
    }

    @Test
    void findById_existing_returnsResponse() {
        when(main2Repository.findById("MN000001")).thenReturn(Optional.of(entity));
        when(main2Mapper.toResponse(entity)).thenReturn(response);

        Main2Response result = main2Service.findById("MN000001");

        assertEquals("MN000001", result.appNo());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(main2Repository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> main2Service.findById("MISSING"));
    }

    @Test
    void create_whenNotExists_savesEntity() {
        when(main2Repository.existsById("MN000001")).thenReturn(false);
        when(main2Mapper.toEntity(request)).thenReturn(entity);
        when(main2Repository.save(entity)).thenReturn(entity);
        when(main2Mapper.toResponse(entity)).thenReturn(response);

        Main2Response result = main2Service.create("MN000001", request);

        assertEquals("MN000001", result.appNo());
        assertEquals("MN000001", entity.getAppNo());
    }

    @Test
    void create_whenAlreadyExists_throwsBusinessException() {
        when(main2Repository.existsById("MN000001")).thenReturn(true);

        assertThrows(BusinessException.class, () -> main2Service.create("MN000001", request));
        verify(main2Repository, never()).save(any());
    }

    @Test
    void update_existing_updatesAndSaves() {
        when(main2Repository.findById("MN000001")).thenReturn(Optional.of(entity));
        when(main2Repository.save(entity)).thenReturn(entity);
        when(main2Mapper.toResponse(entity)).thenReturn(response);

        main2Service.update("MN000001", request);

        verify(main2Mapper).updateEntity(request, entity);
        verify(main2Repository).save(entity);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        when(main2Repository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> main2Service.update("MISSING", request));
    }
}
