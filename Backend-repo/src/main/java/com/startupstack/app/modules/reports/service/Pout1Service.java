package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.reports.dto.Pout1Request;
import com.startupstack.app.modules.reports.dto.Pout1Response;
import com.startupstack.app.modules.reports.entity.Pout1Entity;
import com.startupstack.app.modules.reports.entity.Pout1Id;
import com.startupstack.app.modules.reports.repository.Pout1Repository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class Pout1Service {

    private final Pout1Repository pout1Repository;

    public Pout1Service(Pout1Repository pout1Repository) {
        this.pout1Repository = pout1Repository;
    }

    @Transactional(readOnly = true)
    public Page<Pout1Response> findAll(Pageable pageable) {
        return pout1Repository.findAll(pageable).map(this::toResponse);
    }

    @Transactional(readOnly = true)
    public Pout1Response findById(String outIst, Double outNum) {
        Pout1Id id = buildId(outIst, outNum);
        return toResponse(pout1Repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "POUT1 entry not found: " + outIst + "/" + outNum)));
    }

    @Transactional
    public Pout1Response create(String institution, Pout1Request request) {
        Pout1Entity entity = new Pout1Entity();
        entity.setInstitution(institution);
        mapRequestToEntity(request, entity);
        return toResponse(pout1Repository.save(entity));
    }

    @Transactional
    public Pout1Response update(String outIst, Double outNum, Pout1Request request) {
        Pout1Entity entity = pout1Repository.findById(buildId(outIst, outNum))
                .orElseThrow(() -> new ResourceNotFoundException(
                        "POUT1 entry not found: " + outIst + "/" + outNum));
        mapRequestToEntity(request, entity);
        return toResponse(pout1Repository.save(entity));
    }

    @Transactional
    public void delete(String outIst, Double outNum) {
        Pout1Id id = buildId(outIst, outNum);
        if (!pout1Repository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "POUT1 entry not found: " + outIst + "/" + outNum);
        }
        pout1Repository.deleteById(id);
    }

    private Pout1Id buildId(String outIst, Double outNum) {
        Pout1Id id = new Pout1Id();
        id.setInstitution(outIst);
        id.setOutputNum(outNum);
        return id;
    }

    private void mapRequestToEntity(Pout1Request req, Pout1Entity e) {
        if (req.getOutputNum() != null) e.setOutputNum(req.getOutputNum());
        e.setDescription(req.getDescription());
        e.setName(req.getName());
        e.setField(req.getField());
        e.setSubCondition0(req.getSubCondition0());
        e.setSubCondition(req.getSubCondition());
        e.setSubCondition1(req.getSubCondition1());
        e.setMainCondition(req.getMainCondition());
        e.setMainCondition1(req.getMainCondition1());
        e.setLength(req.getLength());
        e.setLength1(req.getLength1());
        e.setCondition(req.getCondition());
        e.setSelectClause(req.getSelectClause());
        e.setIndex(req.getIndex());
        e.setIndex3(req.getIndex3());
        e.setSeek(req.getSeek());
        e.setIfCondition(req.getIfCondition());
        e.setChoice(req.getChoice());
        e.setNature(req.getNature());
        e.setSelectClause1(req.getSelectClause1());
        e.setIndex1(req.getIndex1());
        e.setCode(req.getCode());
        e.setValueCode(req.getValueCode());
        e.setCodeName(req.getCodeName());
        e.setCodeName1(req.getCodeName1());
        e.setRecurrence(req.getRecurrence());
        e.setIndex12(req.getIndex12());
        e.setCondition1(req.getCondition1());
        e.setType(req.getType());
        e.setRelation(req.getRelation());
        e.setChoice1(req.getChoice1());
        e.setSerial(req.getSerial());
        e.setRelation1(req.getRelation1());
        e.setRelation2(req.getRelation2());
        e.setRelation3(req.getRelation3());
    }

    private Pout1Response toResponse(Pout1Entity e) {
        Pout1Response r = new Pout1Response();
        r.setInstitution(e.getInstitution());
        r.setOutputNum(e.getOutputNum());
        r.setDescription(e.getDescription());
        r.setName(e.getName());
        r.setField(e.getField());
        r.setSubCondition0(e.getSubCondition0());
        r.setSubCondition(e.getSubCondition());
        r.setSubCondition1(e.getSubCondition1());
        r.setMainCondition(e.getMainCondition());
        r.setMainCondition1(e.getMainCondition1());
        r.setLength(e.getLength());
        r.setLength1(e.getLength1());
        r.setCondition(e.getCondition());
        r.setSelectClause(e.getSelectClause());
        r.setIndex(e.getIndex());
        r.setIndex3(e.getIndex3());
        r.setSeek(e.getSeek());
        r.setIfCondition(e.getIfCondition());
        r.setChoice(e.getChoice());
        r.setNature(e.getNature());
        r.setSelectClause1(e.getSelectClause1());
        r.setIndex1(e.getIndex1());
        r.setCode(e.getCode());
        r.setValueCode(e.getValueCode());
        r.setCodeName(e.getCodeName());
        r.setCodeName1(e.getCodeName1());
        r.setRecurrence(e.getRecurrence());
        r.setIndex12(e.getIndex12());
        r.setCondition1(e.getCondition1());
        r.setType(e.getType());
        r.setRelation(e.getRelation());
        r.setChoice1(e.getChoice1());
        r.setSerial(e.getSerial());
        r.setRelation1(e.getRelation1());
        r.setRelation2(e.getRelation2());
        r.setRelation3(e.getRelation3());
        return r;
    }
}
