package com.startupstack.app.modules.requests.service;

import com.startupstack.app.modules.requests.dto.UsageRequestRequest;
import com.startupstack.app.modules.requests.dto.UsageRequestResponse;
import com.startupstack.app.modules.requests.entity.UsageRequestEntity;
import com.startupstack.app.modules.requests.mapper.UsageRequestMapper;
import com.startupstack.app.modules.requests.repository.UsageRequestRepository;
import com.startupstack.app.modules.requests.specification.UsageRequestSpecification;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class UsageRequestService {

    private static final String DEFAULT_STATUS = "PENDING";

    private final UsageRequestRepository usageRequestRepository;
    private final UsageRequestMapper usageRequestMapper;

    public UsageRequestService(UsageRequestRepository usageRequestRepository, UsageRequestMapper usageRequestMapper) {
        this.usageRequestRepository = usageRequestRepository;
        this.usageRequestMapper = usageRequestMapper;
    }

    @Transactional(readOnly = true)
    public Page<UsageRequestResponse> findAll(String status, String requester, Pageable pageable) {
        Specification<UsageRequestEntity> spec = Specification.where(UsageRequestSpecification.hasStatus(status))
                .and(UsageRequestSpecification.requesterContains(requester));
        return usageRequestRepository.findAll(spec, pageable).map(usageRequestMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public UsageRequestResponse findById(UUID id) {
        UsageRequestEntity entity = getOrThrow(id);
        return usageRequestMapper.toResponse(entity);
    }

    @Transactional
    public UsageRequestResponse create(UsageRequestRequest request) {
        if (usageRequestRepository.existsByRequestNo(request.getRequestNo())) {
            throw new BusinessException("Request number " + request.getRequestNo() + " already exists");
        }
        UsageRequestEntity entity = usageRequestMapper.toEntity(request);
        if (entity.getStatus() == null || entity.getStatus().isBlank()) {
            entity.setStatus(DEFAULT_STATUS);
        }
        return usageRequestMapper.toResponse(usageRequestRepository.save(entity));
    }

    @Transactional
    public UsageRequestResponse update(UUID id, UsageRequestRequest request) {
        UsageRequestEntity entity = getOrThrow(id);
        if (!entity.getRequestNo().equals(request.getRequestNo())
                && usageRequestRepository.existsByRequestNo(request.getRequestNo())) {
            throw new BusinessException("Request number " + request.getRequestNo() + " already exists");
        }
        usageRequestMapper.updateEntity(request, entity);
        if (entity.getStatus() == null || entity.getStatus().isBlank()) {
            entity.setStatus(DEFAULT_STATUS);
        }
        return usageRequestMapper.toResponse(usageRequestRepository.save(entity));
    }

    @Transactional
    public void delete(UUID id) {
        if (!usageRequestRepository.existsById(id)) {
            throw new ResourceNotFoundException("Usage request not found: " + id);
        }
        usageRequestRepository.deleteById(id);
    }

    @Transactional
    public UsageRequestResponse updateStatus(UUID id, String newStatus) {
        UsageRequestEntity entity = getOrThrow(id);
        entity.setStatus(newStatus);
        return usageRequestMapper.toResponse(usageRequestRepository.save(entity));
    }

    private UsageRequestEntity getOrThrow(UUID id) {
        return usageRequestRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usage request not found: " + id));
    }
}
