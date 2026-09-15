package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.TimeDescriptorRequest;
import com.startupstack.app.modules.catalogue.dto.TimeDescriptorResponse;
import com.startupstack.app.modules.catalogue.entity.TimeDescriptorEntity;
import com.startupstack.app.modules.catalogue.entity.TimeDescriptorId;
import com.startupstack.app.modules.catalogue.repository.TimeDescriptorRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TimeDescriptorService {

    private final TimeDescriptorRepository timeDescriptorRepository;

    public TimeDescriptorService(TimeDescriptorRepository timeDescriptorRepository) {
        this.timeDescriptorRepository = timeDescriptorRepository;
    }

    @Transactional(readOnly = true)
    public List<TimeDescriptorResponse> getByAppNo(String appNo) {
        return timeDescriptorRepository.findByTmAppNo(appNo).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public TimeDescriptorResponse add(String appNo, TimeDescriptorRequest request) {
        TimeDescriptorId id = new TimeDescriptorId();
        id.setTmAppNo(appNo);
        id.setTmSerNo(request.tmSerNo());
        id.setTmRltvNo(request.tmRltvNo());
        if (timeDescriptorRepository.existsById(id)) {
            return toResponse(timeDescriptorRepository.findById(id).orElseThrow());
        }
        TimeDescriptorEntity entity = new TimeDescriptorEntity();
        entity.setTmAppNo(appNo);
        entity.setTmSerNo(request.tmSerNo());
        entity.setTmRltvNo(request.tmRltvNo());
        entity.setTmDescNo(request.tmDescNo());
        entity.setTmO(request.tmO());
        entity.setTmM(request.tmM());
        entity.setTmS(request.tmS());
        entity.setTmO1(request.tmO1());
        entity.setTmM1(request.tmM1());
        entity.setTmS1(request.tmS1());
        return toResponse(timeDescriptorRepository.save(entity));
    }

    @Transactional
    public void delete(String appNo, String serNo, String rltvNo) {
        TimeDescriptorId id = new TimeDescriptorId();
        id.setTmAppNo(appNo);
        id.setTmSerNo(serNo);
        id.setTmRltvNo(rltvNo);
        if (!timeDescriptorRepository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "Time descriptor not found for appNo=" + appNo + ", serNo=" + serNo + ", rltvNo=" + rltvNo);
        }
        timeDescriptorRepository.deleteByCompositeKey(appNo, serNo, rltvNo);
    }

    private TimeDescriptorResponse toResponse(TimeDescriptorEntity entity) {
        TimeDescriptorResponse r = new TimeDescriptorResponse();
        r.setAppNo(entity.getTmAppNo());
        r.setSerNo(entity.getTmSerNo());
        r.setRltvNo(entity.getTmRltvNo());
        r.setDescNo(entity.getTmDescNo());
        r.setStartHour(entity.getTmO());
        r.setStartMinute(entity.getTmM());
        r.setStartSecond(entity.getTmS());
        r.setEndHour(entity.getTmO1());
        r.setEndMinute(entity.getTmM1());
        r.setEndSecond(entity.getTmS1());
        return r;
    }
}
