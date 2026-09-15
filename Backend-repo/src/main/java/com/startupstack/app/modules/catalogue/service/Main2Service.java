package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.Main2Request;
import com.startupstack.app.modules.catalogue.dto.Main2Response;
import com.startupstack.app.modules.catalogue.entity.Main2Entity;
import com.startupstack.app.modules.catalogue.mapper.Main2Mapper;
import com.startupstack.app.modules.catalogue.repository.Main2Repository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class Main2Service {

    private final Main2Repository main2Repository;
    private final Main2Mapper main2Mapper;

    public Main2Service(Main2Repository main2Repository, Main2Mapper main2Mapper) {
        this.main2Repository = main2Repository;
        this.main2Mapper = main2Mapper;
    }

    @Transactional(readOnly = true)
    public Page<Main2Response> findAll(Pageable pageable) {
        return main2Repository.findAll(pageable).map(main2Mapper::toResponse);
    }

    @Transactional(readOnly = true)
    public Main2Response findById(String appNo) {
        return main2Mapper.toResponse(
                main2Repository.findById(appNo)
                        .orElseThrow(() -> new ResourceNotFoundException("Extended info not found for: " + appNo)));
    }

    @Transactional
    public Main2Response create(String appNo, Main2Request request) {
        if (main2Repository.existsById(appNo)) {
            throw new BusinessException("Extended info already exists for: " + appNo);
        }
        Main2Entity entity = main2Mapper.toEntity(request);
        entity.setAppNo(appNo);
        return main2Mapper.toResponse(main2Repository.save(entity));
    }

    @Transactional
    public Main2Response update(String appNo, Main2Request request) {
        Main2Entity entity = main2Repository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Extended info not found for: " + appNo));
        main2Mapper.updateEntity(request, entity);
        return main2Mapper.toResponse(main2Repository.save(entity));
    }
}
