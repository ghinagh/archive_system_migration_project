package com.startupstack.app.modules.periodicals.service;

import com.startupstack.app.modules.periodicals.dto.PeriodicalRequest;
import com.startupstack.app.modules.periodicals.dto.PeriodicalResponse;
import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import com.startupstack.app.modules.periodicals.mapper.PeriodicalMapper;
import com.startupstack.app.modules.periodicals.repository.PeriodicalRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class PeriodicalServiceTest {

    @Mock
    private PeriodicalRepository periodicalRepository;
    @Mock
    private PeriodicalMapper periodicalMapper;
    @InjectMocks
    private PeriodicalService periodicalService;

    private PeriodicalEntity testEntity;
    private PeriodicalResponse testResponse;

    @BeforeEach
    void setUp() {
        testEntity = new PeriodicalEntity();
        testEntity.setPerNo(1.0);
        testEntity.setName("مجلة العلوم");

        testResponse = new PeriodicalResponse();
        testResponse.setPerNo(1.0);
        testResponse.setName("مجلة العلوم");
    }

    @Test
    void findById_existingPeriodical_returnsResponse() {
        when(periodicalRepository.findById(1.0)).thenReturn(Optional.of(testEntity));
        when(periodicalMapper.toResponse(testEntity)).thenReturn(testResponse);

        PeriodicalResponse result = periodicalService.findById(1.0);

        assertEquals("مجلة العلوم", result.getName());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(periodicalRepository.findById(999.0)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> periodicalService.findById(999.0));
    }

    @Test
    void create_validRequest_savesAndReturns() {
        PeriodicalRequest request = new PeriodicalRequest();
        request.setPerNo(2.0);
        request.setName("مجلة الأدب");

        when(periodicalMapper.toEntity(request)).thenReturn(testEntity);
        when(periodicalRepository.save(testEntity)).thenReturn(testEntity);
        when(periodicalMapper.toResponse(testEntity)).thenReturn(testResponse);

        PeriodicalResponse result = periodicalService.create(request);

        assertNotNull(result);
        verify(periodicalRepository).save(testEntity);
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(periodicalRepository.existsById(999.0)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> periodicalService.delete(999.0));
    }
}
