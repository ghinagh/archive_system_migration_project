package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.SubjectLinkRequest;
import com.startupstack.app.modules.sites.dto.SubjectLinkResponse;
import com.startupstack.app.modules.sites.entity.SubjectLinkEntity;
import com.startupstack.app.modules.sites.entity.SubjectLinkId;
import com.startupstack.app.modules.sites.repository.SubjectLinkRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SubjectLinkService {

    private final SubjectLinkRepository subjectLinkRepository;

    public SubjectLinkService(SubjectLinkRepository subjectLinkRepository) {
        this.subjectLinkRepository = subjectLinkRepository;
    }

    @Transactional(readOnly = true)
    public List<SubjectLinkResponse> getByFormNo(String formNo) {
        return subjectLinkRepository.findBySubForm(formNo).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public SubjectLinkResponse addSubject(String formNo, SubjectLinkRequest request) {
        SubjectLinkId id = new SubjectLinkId();
        id.setSubForm(formNo);
        id.setSubMcnz(request.mcnzCode());
        if (subjectLinkRepository.existsById(id)) {
            return toResponse(subjectLinkRepository.findById(id).orElseThrow());
        }
        SubjectLinkEntity entity = new SubjectLinkEntity();
        entity.setSubForm(formNo);
        entity.setSubMcnz(request.mcnzCode());
        entity.setSubDte(request.subDte());
        entity.setSubDte1(request.subDte1());
        entity.setSubRel(request.subRel());
        return toResponse(subjectLinkRepository.save(entity));
    }

    @Transactional
    public SubjectLinkResponse updateSubject(String formNo, String mcnzCode, SubjectLinkRequest request) {
        SubjectLinkId id = new SubjectLinkId();
        id.setSubForm(formNo);
        id.setSubMcnz(mcnzCode);
        SubjectLinkEntity entity = subjectLinkRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Subject link not found for form " + formNo + " and MACNZ " + mcnzCode));
        entity.setSubDte(request.subDte());
        entity.setSubDte1(request.subDte1());
        entity.setSubRel(request.subRel());
        return toResponse(subjectLinkRepository.save(entity));
    }

    @Transactional
    public void deleteSubject(String formNo, String mcnzCode) {
        SubjectLinkId id = new SubjectLinkId();
        id.setSubForm(formNo);
        id.setSubMcnz(mcnzCode);
        if (!subjectLinkRepository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "Subject link not found for form " + formNo + " and MACNZ " + mcnzCode);
        }
        subjectLinkRepository.deleteBySubFormAndSubMcnz(formNo, mcnzCode);
    }

    private SubjectLinkResponse toResponse(SubjectLinkEntity entity) {
        String mcnzDesc = entity.getMacnz() != null ? entity.getMacnz().getSubDesc() : null;
        return new SubjectLinkResponse(
                entity.getSubForm(),
                entity.getSubMcnz(),
                mcnzDesc,
                entity.getSubDte(),
                entity.getSubDte1(),
                entity.getSubRel()
        );
    }
}
