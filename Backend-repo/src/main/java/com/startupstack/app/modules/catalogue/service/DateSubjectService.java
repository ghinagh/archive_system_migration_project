package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.DateSubjectRequest;
import com.startupstack.app.modules.catalogue.dto.DateSubjectResponse;
import com.startupstack.app.modules.catalogue.entity.DateSubjectEntity;
import com.startupstack.app.modules.catalogue.entity.DateSubjectId;
import com.startupstack.app.modules.catalogue.repository.DateSubjectRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DateSubjectService {

    private final DateSubjectRepository dateSubjectRepository;
    private final CatalogueLockGuard lockGuard;

    public DateSubjectService(DateSubjectRepository dateSubjectRepository, CatalogueLockGuard lockGuard) {
        this.dateSubjectRepository = dateSubjectRepository;
        this.lockGuard = lockGuard;
    }

    @Transactional(readOnly = true)
    public List<DateSubjectResponse> getByAppNo(String appNo) {
        return dateSubjectRepository.findByDteAppNo(appNo).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public DateSubjectResponse addDateSubject(String appNo, DateSubjectRequest request) {
        DateSubjectId id = new DateSubjectId();
        id.setDteAppNo(appNo);
        id.setDteSerNo(request.dteSerNo());
        id.setDteRelNo(request.dteRelNo());
        lockGuard.assertEditable(appNo);
        // Form2.frm m_dte_deb/m_dte_fin Enter: insr_dte_subject when none, otherwise upd_dte_subject.
        DateSubjectEntity entity = dateSubjectRepository.findById(id).orElseGet(DateSubjectEntity::new);
        entity.setDteAppNo(appNo);
        entity.setDteSerNo(request.dteSerNo());
        entity.setDteRelNo(request.dteRelNo());
        entity.setDteDescNo(request.dteDescNo());
        entity.setDteDteDeb(request.dteDteDeb());
        entity.setDteDteFin(request.dteDteFin());
        return toResponse(dateSubjectRepository.save(entity));
    }

    @Transactional
    public void deleteDateSubject(String appNo, String serNo, String relNo) {
        lockGuard.assertEditable(appNo);
        DateSubjectId id = new DateSubjectId();
        id.setDteAppNo(appNo);
        id.setDteSerNo(serNo);
        id.setDteRelNo(relNo);
        if (!dateSubjectRepository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "Date subject not found for appNo=" + appNo + ", serNo=" + serNo + ", relNo=" + relNo);
        }
        dateSubjectRepository.deleteByCompositeKey(appNo, serNo, relNo);
    }

    private DateSubjectResponse toResponse(DateSubjectEntity entity) {
        return new DateSubjectResponse(
                entity.getDteAppNo(),
                entity.getDteSerNo(),
                entity.getDteRelNo(),
                entity.getDteDescNo(),
                entity.getDteDteDeb(),
                entity.getDteDteFin()
        );
    }
}
