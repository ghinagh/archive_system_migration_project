package com.startupstack.app.modules.transactions.service;

import com.startupstack.app.modules.transactions.dto.TransRequest;
import com.startupstack.app.modules.transactions.dto.TransResponse;
import com.startupstack.app.modules.transactions.entity.TransEntity;
import com.startupstack.app.modules.transactions.entity.TransEntityId;
import com.startupstack.app.modules.transactions.mapper.TransMapper;
import com.startupstack.app.modules.transactions.repository.TransRepository;
import com.startupstack.app.modules.transactions.specification.TransSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TransService {

    private final TransRepository transRepository;
    private final TransMapper transMapper;

    public TransService(TransRepository transRepository,
                        TransMapper transMapper) {
        this.transRepository = transRepository;
        this.transMapper = transMapper;
    }

    @Transactional(readOnly = true)
    public Page<TransResponse> findAll(Double periodicalId, Double year, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<TransEntity> spec = TransSpecification.belongsToUserEntity(userEnt)
                .and(TransSpecification.hasPeriodical(periodicalId))
                .and(TransSpecification.hasYear(year));
        return transRepository.findAll(spec, pageable).map(transMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public TransResponse findById(Double opno, Double no) {
        TransEntity entity = transRepository.findById(buildId(opno, no))
                .orElseThrow(() -> new ResourceNotFoundException("Transaction not found: " + opno + "/" + no));
        return transMapper.toResponse(entity);
    }

    @Transactional
    public TransResponse create(TransRequest request) {
        TransEntity entity = transMapper.toEntity(request);
        return transMapper.toResponse(transRepository.save(entity));
    }

    @Transactional
    public TransResponse update(Double opno, Double no, TransRequest request) {
        TransEntity entity = transRepository.findById(buildId(opno, no))
                .orElseThrow(() -> new ResourceNotFoundException("Transaction not found: " + opno + "/" + no));
        transMapper.updateEntity(request, entity);
        return transMapper.toResponse(transRepository.save(entity));
    }

    @Transactional
    public void delete(Double opno, Double no) {
        TransEntityId id = buildId(opno, no);
        if (!transRepository.existsById(id)) {
            throw new ResourceNotFoundException("Transaction not found: " + opno + "/" + no);
        }
        transRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public Page<TransResponse> findByPeriodical(Double periodicalId, Pageable pageable) {
        return transRepository.findByTrsNo(periodicalId, pageable).map(transMapper::toResponse);
    }

    private TransEntityId buildId(Double opno, Double no) {
        TransEntityId id = new TransEntityId();
        id.setTrsOpno(opno);
        id.setTrsNo(no);
        return id;
    }
}
