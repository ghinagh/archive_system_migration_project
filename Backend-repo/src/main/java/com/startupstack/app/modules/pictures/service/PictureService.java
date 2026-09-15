package com.startupstack.app.modules.pictures.service;

import com.startupstack.app.modules.pictures.dto.PictureRequest;
import com.startupstack.app.modules.pictures.dto.PictureResponse;
import com.startupstack.app.modules.pictures.entity.PictureEntity;
import com.startupstack.app.modules.pictures.mapper.PictureMapper;
import com.startupstack.app.modules.pictures.repository.PictureRepository;
import com.startupstack.app.modules.pictures.specification.PictureSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class PictureService {

    private final PictureRepository pictureRepository;
    private final PictureMapper pictureMapper;

    public PictureService(PictureRepository pictureRepository,
                          PictureMapper pictureMapper) {
        this.pictureRepository = pictureRepository;
        this.pictureMapper = pictureMapper;
    }

    @Transactional(readOnly = true)
    public Page<PictureResponse> findAll(Double type,
                                         String entity,
                                         LocalDateTime dateFrom,
                                         LocalDateTime dateTo,
                                         String person,
                                         Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<PictureEntity> spec = PictureSpecification.belongsToUserEntity(userEnt)
                .and(PictureSpecification.hasType(type))
                .and(PictureSpecification.hasEntity(entity))
                .and(PictureSpecification.dateFrom(dateFrom))
                .and(PictureSpecification.dateTo(dateTo))
                .and(PictureSpecification.hasPerson(person));
        return pictureRepository.findAll(spec, pageable).map(pictureMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public PictureResponse findById(String picNo) {
        PictureEntity entity = pictureRepository.findById(picNo)
                .orElseThrow(() -> new ResourceNotFoundException("Picture record not found: " + picNo));
        return pictureMapper.toResponse(entity);
    }

    @Transactional
    public PictureResponse create(PictureRequest request) {
        PictureEntity entity = pictureMapper.toEntity(request);
        return pictureMapper.toResponse(pictureRepository.save(entity));
    }

    @Transactional
    public PictureResponse update(String picNo, PictureRequest request) {
        PictureEntity entity = pictureRepository.findById(picNo)
                .orElseThrow(() -> new ResourceNotFoundException("Picture record not found: " + picNo));
        pictureMapper.updateEntity(request, entity);
        return pictureMapper.toResponse(pictureRepository.save(entity));
    }

    @Transactional
    public void delete(String picNo) {
        if (!pictureRepository.existsById(picNo)) {
            throw new ResourceNotFoundException("Picture record not found: " + picNo);
        }
        pictureRepository.deleteById(picNo);
    }
}
