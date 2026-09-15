package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.AbbreviationRequest;
import com.startupstack.app.modules.catalogue.dto.AbbreviationResponse;
import com.startupstack.app.modules.catalogue.entity.AbbreviationEntity;
import com.startupstack.app.modules.catalogue.entity.AbbreviationId;
import com.startupstack.app.modules.catalogue.repository.AbbreviationRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AbbreviationService {

    private final AbbreviationRepository abbreviationRepository;

    public AbbreviationService(AbbreviationRepository abbreviationRepository) {
        this.abbreviationRepository = abbreviationRepository;
    }

    @Transactional(readOnly = true)
    public List<AbbreviationResponse> getByAppNo(String appNo) {
        return abbreviationRepository.findByRelAppNo(appNo).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public AbbreviationResponse add(String appNo, AbbreviationRequest request) {
        AbbreviationId id = new AbbreviationId();
        id.setRelAppNo(appNo);
        id.setRelSerNo(request.relSerNo());
        id.setRelRltvN(request.relRltvN());
        if (abbreviationRepository.existsById(id)) {
            return toResponse(abbreviationRepository.findById(id).orElseThrow());
        }
        AbbreviationEntity entity = new AbbreviationEntity();
        entity.setRelAppNo(appNo);
        entity.setRelSerNo(request.relSerNo());
        entity.setRelRltvN(request.relRltvN());
        entity.setRelDescN(request.relDescN());
        entity.setRelRltvT(request.relRltvT());
        entity.setRelRelNo(request.relRelNo());
        return toResponse(abbreviationRepository.save(entity));
    }

    @Transactional
    public void delete(String appNo, String serNo, String rltvN) {
        AbbreviationId id = new AbbreviationId();
        id.setRelAppNo(appNo);
        id.setRelSerNo(serNo);
        id.setRelRltvN(rltvN);
        if (!abbreviationRepository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "Abbreviation not found for appNo=" + appNo + ", serNo=" + serNo + ", rltvN=" + rltvN);
        }
        abbreviationRepository.deleteByCompositeKey(appNo, serNo, rltvN);
    }

    private AbbreviationResponse toResponse(AbbreviationEntity entity) {
        AbbreviationResponse r = new AbbreviationResponse();
        r.setAppNo(entity.getRelAppNo());
        r.setSerNo(entity.getRelSerNo());
        r.setRltvN(entity.getRelRltvN());
        r.setDescN(entity.getRelDescN());
        r.setRltvT(entity.getRelRltvT());
        r.setRelNo(entity.getRelRelNo());
        return r;
    }
}
