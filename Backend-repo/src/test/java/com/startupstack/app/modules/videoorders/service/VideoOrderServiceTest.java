package com.startupstack.app.modules.videoorders.service;

import com.startupstack.app.modules.archive.repository.ChartRepository;
import com.startupstack.app.modules.videoorders.dto.VideoOrderRequest;
import com.startupstack.app.modules.videoorders.dto.VideoOrderResponse;
import com.startupstack.app.modules.videoorders.entity.VideoOrderEntity;
import com.startupstack.app.modules.videoorders.mapper.VideoOrderMapper;
import com.startupstack.app.modules.videoorders.repository.VideoOrderRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.media.MediaService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class VideoOrderServiceTest {

    @Mock
    private VideoOrderRepository videoOrderRepository;
    @Mock
    private ChartRepository chartRepository;
    @Mock
    private VideoOrderMapper videoOrderMapper;
    @Mock
    private MediaService mediaService;
    @InjectMocks
    private VideoOrderService videoOrderService;

    private UUID orderId;
    private VideoOrderEntity testEntity;
    private VideoOrderResponse testResponse;

    @BeforeEach
    void setUp() {
        orderId = UUID.randomUUID();

        testEntity = new VideoOrderEntity();
        testEntity.setId(orderId);
        testEntity.setOrderNo("VO-0001");
        testEntity.setStockNo("123456");
        testEntity.setRequestedBy("hasan");
        testEntity.setRequestDate(LocalDateTime.now());
        testEntity.setStatus("PENDING");

        testResponse = new VideoOrderResponse();
        testResponse.setId(orderId);
        testResponse.setOrderNo("VO-0001");
        testResponse.setStockNo("123456");
        testResponse.setRequestedBy("hasan");
        testResponse.setStatus("PENDING");
    }

    @Test
    void findById_existingOrder_returnsResponse() {
        when(videoOrderRepository.findById(orderId)).thenReturn(Optional.of(testEntity));
        when(videoOrderMapper.toResponse(testEntity)).thenReturn(testResponse);
        when(mediaService.fileExists("123456")).thenReturn(true);

        VideoOrderResponse result = videoOrderService.findById(orderId);

        assertEquals("VO-0001", result.getOrderNo());
        assertTrue(result.isMediaAvailable());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        when(videoOrderRepository.findById(missingId)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> videoOrderService.findById(missingId));
    }

    @Test
    void create_validRequest_savesAndReturns() {
        VideoOrderRequest request = new VideoOrderRequest();
        request.setOrderNo("VO-0002");
        request.setStockNo("654321");
        request.setRequestedBy("sara");
        request.setRequestDate(LocalDateTime.now());

        VideoOrderEntity newEntity = new VideoOrderEntity();
        newEntity.setOrderNo("VO-0002");
        newEntity.setStockNo("654321");

        when(videoOrderRepository.existsByOrderNo("VO-0002")).thenReturn(false);
        when(videoOrderMapper.toEntity(request)).thenReturn(newEntity);
        when(videoOrderRepository.save(newEntity)).thenReturn(newEntity);
        when(videoOrderMapper.toResponse(newEntity)).thenReturn(testResponse);
        when(mediaService.fileExists("654321")).thenReturn(false);

        VideoOrderResponse result = videoOrderService.create(request);

        assertNotNull(result);
        assertEquals("PENDING", newEntity.getStatus());
        verify(videoOrderRepository).save(newEntity);
    }

    @Test
    void create_duplicateOrderNo_throwsBusinessException() {
        VideoOrderRequest request = new VideoOrderRequest();
        request.setOrderNo("VO-0001");
        request.setStockNo("123456");
        request.setRequestedBy("hasan");
        request.setRequestDate(LocalDateTime.now());

        when(videoOrderRepository.existsByOrderNo("VO-0001")).thenReturn(true);

        assertThrows(BusinessException.class, () -> videoOrderService.create(request));
        verify(videoOrderRepository, never()).save(any());
    }

    @Test
    void update_existingOrder_updatesAndReturns() {
        VideoOrderRequest request = new VideoOrderRequest();
        request.setOrderNo("VO-0001");
        request.setStockNo("123456");
        request.setRequestedBy("hasan");
        request.setRequestDate(LocalDateTime.now());
        request.setStatus("APPROVED");

        when(videoOrderRepository.findById(orderId)).thenReturn(Optional.of(testEntity));
        when(videoOrderRepository.save(testEntity)).thenReturn(testEntity);
        when(videoOrderMapper.toResponse(testEntity)).thenReturn(testResponse);
        when(mediaService.fileExists("123456")).thenReturn(true);

        VideoOrderResponse result = videoOrderService.update(orderId, request);

        assertNotNull(result);
        verify(videoOrderMapper).updateEntity(request, testEntity);
        verify(videoOrderRepository).save(testEntity);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        VideoOrderRequest request = new VideoOrderRequest();
        request.setOrderNo("VO-9999");
        request.setStockNo("111111");
        request.setRequestedBy("hasan");
        request.setRequestDate(LocalDateTime.now());

        when(videoOrderRepository.findById(missingId)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> videoOrderService.update(missingId, request));
    }

    @Test
    void delete_existingOrder_deletesSuccessfully() {
        when(videoOrderRepository.existsById(orderId)).thenReturn(true);

        videoOrderService.delete(orderId);

        verify(videoOrderRepository).deleteById(orderId);
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        when(videoOrderRepository.existsById(missingId)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> videoOrderService.delete(missingId));
    }

    @Test
    void updateStatus_existingOrder_updatesStatus() {
        when(videoOrderRepository.findById(orderId)).thenReturn(Optional.of(testEntity));
        when(videoOrderRepository.save(testEntity)).thenReturn(testEntity);
        when(videoOrderMapper.toResponse(testEntity)).thenReturn(testResponse);
        when(mediaService.fileExists("123456")).thenReturn(true);

        VideoOrderResponse result = videoOrderService.updateStatus(orderId, "COMPLETED");

        assertNotNull(result);
        assertEquals("COMPLETED", testEntity.getStatus());
        verify(videoOrderRepository).save(testEntity);
    }

    @Test
    void updateStatus_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        when(videoOrderRepository.findById(missingId)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> videoOrderService.updateStatus(missingId, "APPROVED"));
    }
}
