package com.startupstack.app.modules.paysform.service;

import com.startupstack.app.modules.paysform.dto.PaysFormResponse;
import com.startupstack.app.modules.paysform.entity.PaysFormEntity;
import com.startupstack.app.modules.paysform.mapper.PaysFormMapper;
import com.startupstack.app.modules.paysform.repository.PaysFormRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class PaysFormService {

    private final PaysFormRepository paysFormRepository;
    private final PaysFormMapper paysFormMapper;

    public PaysFormService(PaysFormRepository paysFormRepository, PaysFormMapper paysFormMapper) {
        this.paysFormRepository = paysFormRepository;
        this.paysFormMapper = paysFormMapper;
    }

    public Page<PaysFormResponse> findAll(String name, Pageable pageable) {
        Page<PaysFormEntity> page = (name == null || name.isBlank())
                ? paysFormRepository.findAll(pageable)
                : paysFormRepository.findByNameContainingIgnoreCase(name, pageable);
        return page.map(paysFormMapper::toResponse);
    }

    public PaysFormResponse findById(String formNo) {
        PaysFormEntity entity = paysFormRepository.findById(formNo)
                .orElseThrow(() -> new ResourceNotFoundException("Pays form not found: " + formNo));
        return paysFormMapper.toResponse(entity);
    }
}
