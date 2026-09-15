package com.startupstack.app.modules.pictures.service;

import com.startupstack.app.modules.pictures.dto.PictureRequest;
import com.startupstack.app.modules.pictures.dto.PictureResponse;
import com.startupstack.app.modules.pictures.entity.PictureEntity;
import com.startupstack.app.modules.pictures.mapper.PictureMapper;
import com.startupstack.app.modules.pictures.repository.PictureRepository;
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
class PictureServiceTest {

    @Mock
    private PictureRepository pictureRepository;
    @Mock
    private PictureMapper pictureMapper;
    @InjectMocks
    private PictureService pictureService;

    private PictureEntity entity;
    private PictureResponse response;

    @BeforeEach
    void setUp() {
        entity = new PictureEntity();
        entity.setPicNo("PIC0001");
        entity.setPicTit("صورة أرشيفية");

        response = new PictureResponse();
        response.setPicNo("PIC0001");
        response.setPicTit("صورة أرشيفية");
    }

    @Test
    void findAll_delegatesToRepositoryWithSpecificationAndMapsPage() {
        Page<PictureEntity> page = new PageImpl<>(List.of(entity));
        when(pictureRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
        when(pictureMapper.toResponse(entity)).thenReturn(response);

        Page<PictureResponse> result = pictureService.findAll(null, null, null, null, null, Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
        assertEquals("PIC0001", result.getContent().get(0).getPicNo());
    }

    @Test
    void findById_existing_returnsResponse() {
        when(pictureRepository.findById("PIC0001")).thenReturn(Optional.of(entity));
        when(pictureMapper.toResponse(entity)).thenReturn(response);

        PictureResponse result = pictureService.findById("PIC0001");

        assertEquals("صورة أرشيفية", result.getPicTit());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(pictureRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> pictureService.findById("MISSING"));
    }

    @Test
    void create_mapsAndSaves() {
        PictureRequest request = new PictureRequest();
        request.setPicNo("PIC0001");
        request.setPicTit("صورة أرشيفية");
        when(pictureMapper.toEntity(request)).thenReturn(entity);
        when(pictureRepository.save(entity)).thenReturn(entity);
        when(pictureMapper.toResponse(entity)).thenReturn(response);

        PictureResponse result = pictureService.create(request);

        assertNotNull(result);
        verify(pictureRepository).save(entity);
    }

    @Test
    void update_existing_updatesAndSaves() {
        PictureRequest request = new PictureRequest();
        request.setPicTit("عنوان محدث");
        when(pictureRepository.findById("PIC0001")).thenReturn(Optional.of(entity));
        when(pictureRepository.save(entity)).thenReturn(entity);
        when(pictureMapper.toResponse(entity)).thenReturn(response);

        pictureService.update("PIC0001", request);

        verify(pictureMapper).updateEntity(request, entity);
        verify(pictureRepository).save(entity);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        PictureRequest request = new PictureRequest();
        when(pictureRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> pictureService.update("MISSING", request));
    }

    @Test
    void delete_existing_deletes() {
        when(pictureRepository.existsById("PIC0001")).thenReturn(true);

        pictureService.delete("PIC0001");

        verify(pictureRepository).deleteById("PIC0001");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(pictureRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> pictureService.delete("MISSING"));
        verify(pictureRepository, never()).deleteById(any());
    }
}
