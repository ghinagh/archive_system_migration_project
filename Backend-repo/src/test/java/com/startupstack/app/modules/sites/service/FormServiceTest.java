package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.FormResponse;
import com.startupstack.app.modules.sites.entity.FormEntity;
import com.startupstack.app.modules.sites.mapper.FormMapper;
import com.startupstack.app.modules.sites.repository.FormRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class FormServiceTest {

    @Mock
    private FormRepository formRepository;
    @Mock
    private FormMapper formMapper;
    @InjectMocks
    private FormService formService;

    @Test
    void findById_existingForm_returnsResponse() {
        FormEntity entity = new FormEntity();
        entity.setFormNo("FORM001");
        entity.setName("استمارة الموقع");

        FormResponse response = new FormResponse();
        response.setFormNo("FORM001");
        response.setName("استمارة الموقع");

        when(formRepository.findById("FORM001")).thenReturn(Optional.of(entity));
        when(formMapper.toResponse(entity)).thenReturn(response);

        FormResponse result = formService.findById("FORM001");

        assertEquals("استمارة الموقع", result.getName());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(formRepository.findById("NONE")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> formService.findById("NONE"));
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(formRepository.existsById("NONE")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> formService.delete("NONE"));
    }
}
