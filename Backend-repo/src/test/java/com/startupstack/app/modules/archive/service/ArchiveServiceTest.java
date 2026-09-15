package com.startupstack.app.modules.archive.service;

import com.startupstack.app.modules.archive.dto.ChartOperationRequest;
import com.startupstack.app.modules.archive.dto.ChartOperationResponse;
import com.startupstack.app.modules.archive.dto.ChartRequest;
import com.startupstack.app.modules.archive.dto.ChartResponse;
import com.startupstack.app.modules.archive.entity.ChartEntity;
import com.startupstack.app.modules.archive.entity.ChartOperationEntity;
import com.startupstack.app.modules.archive.mapper.ChartMapper;
import com.startupstack.app.modules.archive.mapper.ChartOperationMapper;
import com.startupstack.app.modules.archive.repository.ChartOperationRepository;
import com.startupstack.app.modules.archive.repository.ChartRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import org.mockito.ArgumentCaptor;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ArchiveServiceTest {

    @Mock
    private ChartRepository chartRepository;
    @Mock
    private ChartOperationRepository operationRepository;
    @Mock
    private ChartMapper chartMapper;
    @Mock
    private ChartOperationMapper operationMapper;
    @InjectMocks
    private ArchiveService archiveService;

    private ChartEntity testChart;

    @BeforeEach
    void setUp() {
        testChart = new ChartEntity();
        testChart.setId(1);
        testChart.setChaNo("CH0001");
        testChart.setTitle("ملف أرشيف");
    }

    @Test
    void createOperation_linksToParentChart() {
        ChartOperationRequest request = new ChartOperationRequest();
        request.setTitle("نقل ملف");
        request.setTransferred(true);

        ChartOperationEntity opEntity = new ChartOperationEntity();
        ChartOperationResponse opResponse = new ChartOperationResponse();

        when(chartRepository.findById(1)).thenReturn(Optional.of(testChart));
        when(operationMapper.toEntity(request)).thenReturn(opEntity);
        when(operationRepository.save(opEntity)).thenReturn(opEntity);
        when(operationMapper.toResponse(opEntity)).thenReturn(opResponse);

        archiveService.createOperation(1, request);

        verify(operationRepository).save(opEntity);
        assertEquals(testChart, opEntity.getChart());
    }

    @Test
    void createOperation_withInvalidChart_throwsResourceNotFound() {
        when(chartRepository.findById(999)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> archiveService.createOperation(999, new ChartOperationRequest()));
    }

    @Test
    void updateOperation_cascadesStatusFieldsToChart() {
        ChartOperationEntity opEntity = new ChartOperationEntity();
        opEntity.setFromSite("SITE_A");
        opEntity.setToSite("SITE_B");
        opEntity.setFromPerson("PRS_A");
        opEntity.setToPerson("PRS_B");

        when(chartRepository.findById(1)).thenReturn(Optional.of(testChart));
        when(operationRepository.findById(5)).thenReturn(Optional.of(opEntity));
        when(operationRepository.save(opEntity)).thenReturn(opEntity);
        when(operationMapper.toResponse(opEntity)).thenReturn(new ChartOperationResponse());

        archiveService.updateOperation(1, 5, new ChartOperationRequest());

        assertEquals("SITE_A", testChart.getFromSite());
        assertEquals("SITE_B", testChart.getToSite());
        assertEquals("PRS_A", testChart.getFromPerson());
        assertEquals("PRS_B", testChart.getToPerson());
        verify(chartRepository).save(testChart);
    }

    @Test
    void createChart_withStock_createsBootstrapOperation() {
        ChartRequest request = new ChartRequest();
        request.setStock(42.0);
        request.setFromSite("S01");
        request.setToSite("S02");
        request.setFromPerson("P01");
        request.setToPerson("P02");
        request.setTitle("ملف رصيد");

        ChartEntity chartEntity = new ChartEntity();

        when(chartRepository.existsByStock(42.0)).thenReturn(false);
        when(chartRepository.findMaxChaNoAsInteger()).thenReturn(0);
        when(chartMapper.toEntity(request)).thenReturn(chartEntity);
        when(chartRepository.save(any(ChartEntity.class))).thenReturn(chartEntity);
        when(operationRepository.findMaxSerialByChaNo("000001")).thenReturn(0.0);
        when(operationRepository.save(any(ChartOperationEntity.class))).thenReturn(new ChartOperationEntity());
        when(chartMapper.toResponse(any(ChartEntity.class))).thenReturn(new ChartResponse());

        archiveService.createChart(request);

        ArgumentCaptor<ChartOperationEntity> captor = ArgumentCaptor.forClass(ChartOperationEntity.class);
        verify(operationRepository, times(1)).save(captor.capture());

        ChartOperationEntity captured = captor.getValue();
        assertEquals("000001", captured.getChart().getChaNo());
        assertEquals(1.0, captured.getSerial());
    }

    @Test
    void deleteChart_nonExistent_throwsResourceNotFound() {
        when(chartRepository.existsById(999)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> archiveService.deleteChart(999));
    }
}
