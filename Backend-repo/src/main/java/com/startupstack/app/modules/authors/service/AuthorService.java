package com.startupstack.app.modules.authors.service;

import com.startupstack.app.modules.authors.dto.AuthorOptionResponse;
import com.startupstack.app.modules.authors.dto.AuthorRequest;
import com.startupstack.app.modules.authors.dto.AuthorResponse;
import com.startupstack.app.modules.authors.entity.AuthorEntity;
import com.startupstack.app.modules.authors.mapper.AuthorMapper;
import com.startupstack.app.modules.authors.repository.AuthorRepository;
import com.startupstack.app.modules.authors.specification.AuthorSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AuthorService {

    private final AuthorRepository authorRepository;
    private final AuthorMapper authorMapper;

    public AuthorService(AuthorRepository authorRepository, AuthorMapper authorMapper) {
        this.authorRepository = authorRepository;
        this.authorMapper = authorMapper;
    }

    @Transactional(readOnly = true)
    public Page<AuthorResponse> findAll(String name, String type, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<AuthorEntity> spec = AuthorSpecification.belongsToUserEntity(userEnt)
                .and(AuthorSpecification.nameContains(name))
                .and(AuthorSpecification.hasType(type));
        return authorRepository.findAll(spec, pageable).map(authorMapper::toResponse);
    }

    /** Legacy m_res_no DataCombo's live-narrowing lookup ("المسؤول عن العمل"). */
    @Transactional(readOnly = true)
    public List<AuthorOptionResponse> search(String q, int size) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<AuthorEntity> spec = AuthorSpecification.belongsToUserEntity(userEnt)
                .and(AuthorSpecification.nameContains(q));
        return authorRepository.findAll(spec, PageRequest.of(0, size))
                .map(entity -> new AuthorOptionResponse(entity.getAutNo(), entity.getAutName()))
                .getContent();
    }

    @Transactional(readOnly = true)
    public AuthorResponse findById(Double autNo) {
        AuthorEntity entity = authorRepository.findById(autNo)
                .orElseThrow(() -> new ResourceNotFoundException("Author not found: " + autNo));
        return authorMapper.toResponse(entity);
    }

    @Transactional
    public AuthorResponse create(AuthorRequest request) {
        AuthorEntity entity = authorMapper.toEntity(request);
        return authorMapper.toResponse(authorRepository.save(entity));
    }

    @Transactional
    public AuthorResponse update(Double autNo, AuthorRequest request) {
        AuthorEntity entity = authorRepository.findById(autNo)
                .orElseThrow(() -> new ResourceNotFoundException("Author not found: " + autNo));
        authorMapper.updateEntity(request, entity);
        return authorMapper.toResponse(authorRepository.save(entity));
    }

    @Transactional
    public void delete(Double autNo) {
        if (!authorRepository.existsById(autNo)) {
            throw new ResourceNotFoundException("Author not found: " + autNo);
        }
        authorRepository.deleteById(autNo);
    }
}
