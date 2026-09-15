package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.FormRequest;
import com.startupstack.app.modules.sites.dto.FormResponse;
import com.startupstack.app.modules.sites.entity.FormEntity;
import com.startupstack.app.modules.sites.mapper.FormMapper;
import com.startupstack.app.modules.sites.repository.FormRepository;
import com.startupstack.app.modules.sites.specification.SitesSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FormService {

    private final FormRepository formRepository;
    private final FormMapper formMapper;

    public FormService(FormRepository formRepository, FormMapper formMapper) {
        this.formRepository = formRepository;
        this.formMapper = formMapper;
    }

    @Transactional(readOnly = true)
    public Page<FormResponse> findAll(String name, String type, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<FormEntity> spec = SitesSpecification.formBelongsToUserEntity(userEnt)
                .and(SitesSpecification.formNameContains(name))
                .and(SitesSpecification.formHasType(type));
        return formRepository.findAll(spec, pageable).map(formMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public Page<FormResponse> findInstitutions(Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<FormEntity> spec = SitesSpecification.formBelongsToUserEntity(userEnt)
                .and(SitesSpecification.formHasType("03"));
        return formRepository.findAll(spec, pageable).map(formMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public FormResponse findById(String formNo) {
        FormEntity entity = formRepository.findById(formNo)
                .orElseThrow(() -> new ResourceNotFoundException("Form not found: " + formNo));
        return formMapper.toResponse(entity);
    }

    @Transactional
    public FormResponse create(FormRequest request) {
        FormEntity entity = formMapper.toEntity(request);
        return formMapper.toResponse(formRepository.save(entity));
    }

    @Transactional
    public FormResponse update(String formNo, FormRequest request) {
        FormEntity entity = formRepository.findById(formNo)
                .orElseThrow(() -> new ResourceNotFoundException("Form not found: " + formNo));
        formMapper.updateEntity(request, entity);
        return formMapper.toResponse(formRepository.save(entity));
    }

    @Transactional
    public void delete(String formNo) {
        if (!formRepository.existsById(formNo)) {
            throw new ResourceNotFoundException("Form not found: " + formNo);
        }
        formRepository.deleteById(formNo);
    }
}
