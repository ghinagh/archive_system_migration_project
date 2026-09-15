package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.reports.dto.CategoryRequest;
import com.startupstack.app.modules.reports.dto.CategoryResponse;
import com.startupstack.app.modules.reports.dto.ReportTemplateRequest;
import com.startupstack.app.modules.reports.dto.ReportTemplateResponse;
import com.startupstack.app.modules.reports.dto.UserOutputRequest;
import com.startupstack.app.modules.reports.dto.UserOutputResponse;
import com.startupstack.app.modules.reports.entity.CategoryEntity;
import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import com.startupstack.app.modules.reports.entity.UserOutputEntity;
import com.startupstack.app.modules.reports.entity.UserOutputId;
import com.startupstack.app.modules.reports.mapper.ReportTemplateMapper;
import com.startupstack.app.modules.reports.mapper.UserOutputMapper;
import com.startupstack.app.modules.reports.repository.CategoryRepository;
import com.startupstack.app.modules.reports.repository.ReportTemplateRepository;
import com.startupstack.app.modules.reports.repository.UserOutputRepository;
import com.startupstack.app.modules.reports.specification.ReportSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReportService {

    private final ReportTemplateRepository templateRepository;
    private final UserOutputRepository userOutputRepository;
    private final CategoryRepository categoryRepository;
    private final ReportTemplateMapper templateMapper;
    private final UserOutputMapper userOutputMapper;

    public ReportService(ReportTemplateRepository templateRepository,
                         UserOutputRepository userOutputRepository,
                         CategoryRepository categoryRepository,
                         ReportTemplateMapper templateMapper,
                         UserOutputMapper userOutputMapper) {
        this.templateRepository = templateRepository;
        this.userOutputRepository = userOutputRepository;
        this.categoryRepository = categoryRepository;
        this.templateMapper = templateMapper;
        this.userOutputMapper = userOutputMapper;
    }

    @Transactional(readOnly = true)
    public Page<ReportTemplateResponse> findAllTemplates(String name, String type,
                                                         String category, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<ReportTemplateEntity> spec = ReportSpecification.templateBelongsToUserEntity(userEnt)
                .and(ReportSpecification.nameContains(name))
                .and(ReportSpecification.hasType(type))
                .and(ReportSpecification.hasCategory(category));
        return templateRepository.findAll(spec, pageable).map(templateMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public ReportTemplateResponse findTemplateById(Integer id) {
        ReportTemplateEntity entity = templateRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Report template not found: " + id));
        return templateMapper.toResponse(entity);
    }

    @Transactional
    public ReportTemplateResponse createTemplate(ReportTemplateRequest request) {
        ReportTemplateEntity entity = templateMapper.toEntity(request);
        return templateMapper.toResponse(templateRepository.save(entity));
    }

    @Transactional
    public ReportTemplateResponse updateTemplate(Integer id, ReportTemplateRequest request) {
        ReportTemplateEntity entity = templateRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Report template not found: " + id));
        templateMapper.updateEntity(request, entity);
        return templateMapper.toResponse(templateRepository.save(entity));
    }

    @Transactional
    public void deleteTemplate(Integer id) {
        if (!templateRepository.existsById(id)) {
            throw new ResourceNotFoundException("Report template not found: " + id);
        }
        templateRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public Page<UserOutputResponse> findAllUserOutputs(String userNo, String institutionNo,
                                                        Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<UserOutputEntity> spec = ReportSpecification.outputBelongsToUserEntity(userEnt)
                .and(ReportSpecification.userOutputHasUser(userNo))
                .and(ReportSpecification.userOutputHasInstitution(institutionNo));
        return userOutputRepository.findAll(spec, pageable).map(userOutputMapper::toResponse);
    }

    @Transactional
    public UserOutputResponse createUserOutput(UserOutputRequest request) {
        UserOutputEntity entity = userOutputMapper.toEntity(request);
        return userOutputMapper.toResponse(userOutputRepository.save(entity));
    }

    @Transactional
    public void deleteUserOutput(String institutionNo, String userNo, Integer outputNum) {
        UserOutputId id = new UserOutputId();
        id.setInstitutionNo(institutionNo);
        id.setUserNo(userNo);
        id.setOutputNum(outputNum);
        if (!userOutputRepository.existsById(id)) {
            throw new ResourceNotFoundException("User output not found");
        }
        userOutputRepository.deleteById(id);
    }

    // --- Category ---

    @Transactional(readOnly = true)
    public List<CategoryResponse> findAllCategories() {
        return categoryRepository.findAll().stream()
                .map(e -> new CategoryResponse(e.getId(), e.getCategoryNo(), e.getOutputNum()))
                .toList();
    }

    @Transactional
    public CategoryResponse createCategory(CategoryRequest request) {
        CategoryEntity entity = new CategoryEntity();
        entity.setCategoryNo(request.categoryNo());
        entity.setOutputNum(request.outputNum());
        CategoryEntity saved = categoryRepository.save(entity);
        return new CategoryResponse(saved.getId(), saved.getCategoryNo(), saved.getOutputNum());
    }

    @Transactional
    public void deleteCategory(Integer auto) {
        if (!categoryRepository.existsById(auto)) {
            throw new ResourceNotFoundException("Category not found: " + auto);
        }
        categoryRepository.deleteById(auto);
    }
}
