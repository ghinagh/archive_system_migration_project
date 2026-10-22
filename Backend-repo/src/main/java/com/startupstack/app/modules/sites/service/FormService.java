package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.FormCodeNameResponse;
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
        return findAll(name, type, null, pageable);
    }

    /**
     * mode "prefix" = serh_allform (name starts with), anything else = serh_wrdform (contains).
     * A name search goes through {@link FormRepository#searchNames} so that a person (01) and an
     * institution (03) sharing a SUB_NO come back as two rows instead of one entity twice.
     */
    @Transactional(readOnly = true)
    public Page<FormResponse> findAll(String name, String type, String mode, Pageable pageable) {
        if (name != null && !name.isBlank()) {
            String q = name.strip().replace("\\", "\\\\").replace("%", "\\%").replace("_", "\\_");
            String pattern = "prefix".equalsIgnoreCase(mode) ? q + "%" : "%" + q + "%";
            Pageable unsorted = org.springframework.data.domain.PageRequest.of(pageable.getPageNumber(), pageable.getPageSize());
            return formRepository.searchNames(pattern, type == null || type.isBlank() ? null : type, unsorted).map(r -> {
                FormResponse resp = new FormResponse();
                resp.setFormType(r.getFormType());
                resp.setFormNo(r.getFormNo());
                resp.setName(r.getName() == null ? null : r.getName().trim());
                return resp;
            });
        }
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
    /** serh_sub_name: a name stored as SUB_TYP + SUB_NO (PERIOD people fields, PERIOD1.frm:1597). */
    public FormCodeNameResponse findByCode(String code) {
        String c = code == null ? "" : code.trim();
        String name = c.length() > 2
                ? formRepository.findNameByTypeAndNumber(c.substring(0, 2), c.substring(2)).orElse(null)
                : null;
        if (name == null) {
            throw new ResourceNotFoundException("Form not found: " + code);
        }
        return new FormCodeNameResponse(c, name.trim());
    }

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
