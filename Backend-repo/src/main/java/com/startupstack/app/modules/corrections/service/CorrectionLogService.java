package com.startupstack.app.modules.corrections.service;

import com.startupstack.app.modules.corrections.dto.CorrectionLogResponse;
import com.startupstack.app.modules.corrections.entity.CorrectionLogEntity;
import com.startupstack.app.modules.corrections.repository.CorrectionLogRepository;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class CorrectionLogService {

    private final CorrectionLogRepository repository;

    public CorrectionLogService(CorrectionLogRepository repository) {
        this.repository = repository;
    }

    @Transactional
    public void logChange(String appNo,
                          String fieldName,
                          String oldValue,
                          String newValue,
                          String correctionReason) {
        CorrectionLogEntity entry = new CorrectionLogEntity();
        entry.setAppNo(appNo);
        entry.setCorrectedAt(LocalDateTime.now());
        entry.setCorrectedByUser(
                Optional.ofNullable(SecurityUtils.getCurrentUsername()).orElse("system"));
        entry.setFieldName(fieldName);
        entry.setOldValue(oldValue);
        entry.setNewValue(newValue);
        entry.setCorrectionReason(correctionReason);
        repository.save(entry);
    }

    @Transactional(readOnly = true)
    public List<CorrectionLogResponse> getCorrections(String appNo) {
        return repository.findByAppNoOrderByCorrectedAtDesc(appNo)
                .stream()
                .map(this::toResponse)
                .toList();
    }

    private CorrectionLogResponse toResponse(CorrectionLogEntity e) {
        CorrectionLogResponse r = new CorrectionLogResponse();
        r.setId(e.getId());
        r.setAppNo(e.getAppNo());
        r.setCorrectedAt(e.getCorrectedAt());
        r.setCorrectedByUser(e.getCorrectedByUser());
        r.setFieldName(e.getFieldName());
        r.setOldValue(e.getOldValue());
        r.setNewValue(e.getNewValue());
        r.setCorrectionReason(e.getCorrectionReason());
        return r;
    }
}
