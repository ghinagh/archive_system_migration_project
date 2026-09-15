package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.PositionRequest;
import com.startupstack.app.modules.sites.dto.PositionResponse;
import com.startupstack.app.modules.sites.entity.PositionEntity;
import com.startupstack.app.modules.sites.mapper.PositionMapper;
import com.startupstack.app.modules.sites.repository.PositionRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PositionService {

    private final PositionRepository positionRepository;
    private final PositionMapper positionMapper;

    public PositionService(PositionRepository positionRepository, PositionMapper positionMapper) {
        this.positionRepository = positionRepository;
        this.positionMapper = positionMapper;
    }

    @Transactional(readOnly = true)
    public Page<PositionResponse> findAll(String name, Pageable pageable) {
        Specification<PositionEntity> spec = (root, query, cb) ->
                name == null ? cb.conjunction()
                        : cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%");
        return positionRepository.findAll(spec, pageable).map(positionMapper::toResponse);
    }

    /**
     * Positions attached to a form entry — the migrated form of legacy {@code proc_pos}, which
     * USER_INTERFACE1.frm:5156-5168 runs on F2 over the form lookup and renders in DBList3
     * ({@code ListField = "pos_nam"}).
     *
     * <p><b>The procedure's body does not survive in the legacy source</b> — only its call
     * sites (USER_INTERFACE1.frm, Form3.frm, form2.frm, coding.frm), which uniformly pass
     * {@code SUB_TYP || SUB_NO}. The predicate below is reconstructed from two pieces of
     * evidence: that argument is exactly 10 characters, and {@code POSITION.POS_NO} is exactly
     * {@code nvarchar(10)}. Worth re-confirming against live data before relying on it.
     */
    @Transactional(readOnly = true)
    public List<PositionResponse> findByFormCode(String formCode) {
        if (formCode == null || formCode.isBlank()) {
            return List.of();
        }
        return positionRepository.findByFormCode(formCode.trim())
                .stream()
                .map(positionMapper::toResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public PositionResponse findById(String posNo) {
        return positionMapper.toResponse(positionRepository.findById(posNo)
                .orElseThrow(() -> new ResourceNotFoundException("Position not found: " + posNo)));
    }

    @Transactional
    public PositionResponse create(PositionRequest request) {
        PositionEntity entity = positionMapper.toEntity(request);
        return positionMapper.toResponse(positionRepository.save(entity));
    }

    @Transactional
    public PositionResponse update(String posNo, PositionRequest request) {
        PositionEntity entity = positionRepository.findById(posNo)
                .orElseThrow(() -> new ResourceNotFoundException("Position not found: " + posNo));
        positionMapper.updateEntity(request, entity);
        return positionMapper.toResponse(positionRepository.save(entity));
    }

    @Transactional
    public void delete(String posNo) {
        if (!positionRepository.existsById(posNo)) {
            throw new ResourceNotFoundException("Position not found: " + posNo);
        }
        positionRepository.deleteById(posNo);
    }
}
