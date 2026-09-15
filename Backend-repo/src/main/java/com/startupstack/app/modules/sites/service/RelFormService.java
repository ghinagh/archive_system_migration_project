package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.RelFormRequest;
import com.startupstack.app.modules.sites.dto.RelFormResponse;
import com.startupstack.app.modules.sites.entity.RelFormEntity;
import com.startupstack.app.modules.sites.entity.RelFormId;
import com.startupstack.app.modules.sites.repository.RelFormRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RelFormService {

    private final RelFormRepository relFormRepository;

    public RelFormService(RelFormRepository relFormRepository) {
        this.relFormRepository = relFormRepository;
    }

    @Transactional(readOnly = true)
    public List<RelFormResponse> getByFormNo(String formNo) {
        return relFormRepository.findByRlfForm1(formNo).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public RelFormResponse addRelatedForm(String formNo, RelFormRequest request) {
        RelFormId id = new RelFormId();
        id.setRlfForm1(formNo);
        id.setRlfForm2(request.form2No());
        if (relFormRepository.existsById(id)) {
            return toResponse(relFormRepository.findById(id).orElseThrow());
        }
        RelFormEntity entity = new RelFormEntity();
        entity.setRlfForm1(formNo);
        entity.setRlfForm2(request.form2No());
        entity.setRlfDte(request.rlfDte());
        entity.setRlfDte1(request.rlfDte1());
        entity.setRlfRel(request.rlfRel());
        return toResponse(relFormRepository.save(entity));
    }

    @Transactional
    public RelFormResponse updateRelatedForm(String formNo, String form2No, RelFormRequest request) {
        RelFormId id = new RelFormId();
        id.setRlfForm1(formNo);
        id.setRlfForm2(form2No);
        RelFormEntity entity = relFormRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Related form not found: " + formNo + " → " + form2No));
        entity.setRlfDte(request.rlfDte());
        entity.setRlfDte1(request.rlfDte1());
        entity.setRlfRel(request.rlfRel());
        return toResponse(relFormRepository.save(entity));
    }

    @Transactional
    public void deleteRelatedForm(String formNo, String form2No) {
        RelFormId id = new RelFormId();
        id.setRlfForm1(formNo);
        id.setRlfForm2(form2No);
        if (!relFormRepository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "Related form not found: " + formNo + " → " + form2No);
        }
        relFormRepository.deleteByRlfForm1AndRlfForm2(formNo, form2No);
    }

    private RelFormResponse toResponse(RelFormEntity entity) {
        String form2Name = entity.getForm2() != null ? entity.getForm2().getName() : null;
        return new RelFormResponse(
                entity.getRlfForm1(),
                entity.getRlfForm2(),
                form2Name,
                entity.getRlfDte(),
                entity.getRlfDte1(),
                entity.getRlfRel()
        );
    }
}
