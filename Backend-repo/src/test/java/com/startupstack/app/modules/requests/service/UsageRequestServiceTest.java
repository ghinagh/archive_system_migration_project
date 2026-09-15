package com.startupstack.app.modules.requests.service;

import com.startupstack.app.modules.requests.dto.UsageRequestRequest;
import com.startupstack.app.modules.requests.dto.UsageRequestResponse;
import com.startupstack.app.modules.requests.entity.UsageRequestEntity;
import com.startupstack.app.modules.requests.mapper.UsageRequestMapper;
import com.startupstack.app.modules.requests.repository.UsageRequestRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
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
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UsageRequestServiceTest {

    @Mock
    private UsageRequestRepository usageRequestRepository;
    @Mock
    private UsageRequestMapper usageRequestMapper;
    @InjectMocks
    private UsageRequestService usageRequestService;

    private UUID testId;
    private UsageRequestEntity testEntity;
    private UsageRequestResponse testResponse;

    @BeforeEach
    void setUp() {
        testId = UUID.randomUUID();

        testEntity = new UsageRequestEntity();
        testEntity.setId(testId);
        testEntity.setRequestNo("REQ-001");
        testEntity.setRequester("Ahmad Ali");
        testEntity.setPermitNo("P-100");
        testEntity.setCote("A/1/2");
        testEntity.setRequestDate(LocalDateTime.now());
        testEntity.setStatus("PENDING");

        testResponse = new UsageRequestResponse();
        testResponse.setId(testId);
        testResponse.setRequestNo("REQ-001");
        testResponse.setRequester("Ahmad Ali");
        testResponse.setStatus("PENDING");
    }

    @Test
    void findById_existingRequest_returnsResponse() {
        when(usageRequestRepository.findById(testId)).thenReturn(Optional.of(testEntity));
        when(usageRequestMapper.toResponse(testEntity)).thenReturn(testResponse);

        UsageRequestResponse result = usageRequestService.findById(testId);

        assertEquals("REQ-001", result.getRequestNo());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        when(usageRequestRepository.findById(missingId)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> usageRequestService.findById(missingId));
    }

    @Test
    void create_validRequest_savesAndReturns() {
        UsageRequestRequest request = new UsageRequestRequest();
        request.setRequestNo("REQ-002");
        request.setRequester("Sara Khaled");
        request.setRequestDate(LocalDateTime.now());
        request.setStatus("PENDING");

        when(usageRequestRepository.existsByRequestNo("REQ-002")).thenReturn(false);
        when(usageRequestMapper.toEntity(request)).thenReturn(testEntity);
        when(usageRequestRepository.save(testEntity)).thenReturn(testEntity);
        when(usageRequestMapper.toResponse(testEntity)).thenReturn(testResponse);

        UsageRequestResponse result = usageRequestService.create(request);

        assertNotNull(result);
        verify(usageRequestRepository).save(testEntity);
    }

    @Test
    void create_duplicateRequestNo_throwsBusinessException() {
        UsageRequestRequest request = new UsageRequestRequest();
        request.setRequestNo("REQ-001");
        request.setRequester("Sara Khaled");
        request.setRequestDate(LocalDateTime.now());

        when(usageRequestRepository.existsByRequestNo("REQ-001")).thenReturn(true);

        assertThrows(BusinessException.class, () -> usageRequestService.create(request));
        verify(usageRequestRepository, never()).save(any());
    }

    @Test
    void update_existingRequest_updatesAndReturns() {
        UsageRequestRequest request = new UsageRequestRequest();
        request.setRequestNo("REQ-001");
        request.setRequester("Ahmad Ali Updated");
        request.setRequestDate(LocalDateTime.now());
        request.setStatus("APPROVED");

        when(usageRequestRepository.findById(testId)).thenReturn(Optional.of(testEntity));
        when(usageRequestRepository.save(testEntity)).thenReturn(testEntity);
        when(usageRequestMapper.toResponse(testEntity)).thenReturn(testResponse);

        UsageRequestResponse result = usageRequestService.update(testId, request);

        assertNotNull(result);
        verify(usageRequestMapper).updateEntity(request, testEntity);
        verify(usageRequestRepository).save(testEntity);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        UsageRequestRequest request = new UsageRequestRequest();
        request.setRequestNo("REQ-999");
        request.setRequester("Someone");
        request.setRequestDate(LocalDateTime.now());

        when(usageRequestRepository.findById(missingId)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> usageRequestService.update(missingId, request));
    }

    @Test
    void delete_existingRequest_deletesSuccessfully() {
        when(usageRequestRepository.existsById(testId)).thenReturn(true);

        usageRequestService.delete(testId);

        verify(usageRequestRepository).deleteById(testId);
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        when(usageRequestRepository.existsById(missingId)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> usageRequestService.delete(missingId));
    }

    @Test
    void updateStatus_existingRequest_updatesStatus() {
        when(usageRequestRepository.findById(testId)).thenReturn(Optional.of(testEntity));
        when(usageRequestRepository.save(testEntity)).thenReturn(testEntity);
        when(usageRequestMapper.toResponse(testEntity)).thenReturn(testResponse);

        UsageRequestResponse result = usageRequestService.updateStatus(testId, "APPROVED");

        assertNotNull(result);
        assertEquals("APPROVED", testEntity.getStatus());
        verify(usageRequestRepository).save(testEntity);
    }

    @Test
    void updateStatus_nonExistent_throwsResourceNotFound() {
        UUID missingId = UUID.randomUUID();
        when(usageRequestRepository.findById(missingId)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> usageRequestService.updateStatus(missingId, "APPROVED"));
    }
}
