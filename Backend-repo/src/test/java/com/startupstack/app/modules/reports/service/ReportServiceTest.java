package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.reports.dto.ReportTemplateResponse;
import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import com.startupstack.app.modules.reports.entity.UserOutputId;
import com.startupstack.app.modules.reports.mapper.ReportTemplateMapper;
import com.startupstack.app.modules.reports.mapper.UserOutputMapper;
import com.startupstack.app.modules.reports.repository.ReportTemplateRepository;
import com.startupstack.app.modules.reports.repository.UserOutputRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ReportServiceTest {

    @Mock private ReportTemplateRepository templateRepository;
    @Mock private UserOutputRepository userOutputRepository;
    @Mock private ReportTemplateMapper templateMapper;
    @Mock private UserOutputMapper userOutputMapper;
    @InjectMocks
    private ReportService reportService;

    @Test
    void findTemplateById_existingTemplate_returnsResponse() {
        ReportTemplateEntity entity = new ReportTemplateEntity();
        entity.setId(1);
        entity.setName("تقرير الكتب");

        ReportTemplateResponse response = new ReportTemplateResponse();
        response.setId(1);
        response.setName("تقرير الكتب");

        when(templateRepository.findById(1)).thenReturn(Optional.of(entity));
        when(templateMapper.toResponse(entity)).thenReturn(response);

        ReportTemplateResponse result = reportService.findTemplateById(1);

        assertEquals("تقرير الكتب", result.getName());
    }

    @Test
    void findTemplateById_nonExistent_throwsResourceNotFound() {
        when(templateRepository.findById(999)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> reportService.findTemplateById(999));
    }

    @Test
    void deleteTemplate_nonExistent_throwsResourceNotFound() {
        when(templateRepository.existsById(999)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> reportService.deleteTemplate(999));
    }

    @Test
    void deleteUserOutput_nonExistent_throwsResourceNotFound() {
        when(userOutputRepository.existsById(any(UserOutputId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> reportService.deleteUserOutput("01", "001", 1));
    }
}
