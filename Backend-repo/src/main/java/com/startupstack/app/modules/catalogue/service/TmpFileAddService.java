package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.TmpFileAddRequest;
import com.startupstack.app.modules.catalogue.dto.TmpFileAddResponse;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddId;
import com.startupstack.app.modules.catalogue.repository.TmpFileAddRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class TmpFileAddService {

    private final TmpFileAddRepository tmpFileAddRepository;

    public TmpFileAddService(TmpFileAddRepository tmpFileAddRepository) {
        this.tmpFileAddRepository = tmpFileAddRepository;
    }

    @Transactional(readOnly = true)
    public List<TmpFileAddResponse> findAll(String fadNo, String userNo, Integer finalStatus) {
        Specification<TmpFileAddEntity> spec = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            if (fadNo != null) predicates.add(cb.equal(root.get("tmpFadNo"), fadNo));
            if (userNo != null) predicates.add(cb.equal(root.get("tmpUserNo"), userNo));
            if (finalStatus != null) predicates.add(cb.equal(root.get("tmpFinal"), finalStatus));
            return cb.and(predicates.toArray(new Predicate[0]));
        };
        return tmpFileAddRepository.findAll(spec).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public TmpFileAddResponse create(TmpFileAddRequest request) {
        String userNo = SecurityContextHolder.getContext().getAuthentication().getName();

        double nextSer = tmpFileAddRepository.findByTmpFadNo(request.tmpFadNo())
                .stream()
                .mapToDouble(TmpFileAddEntity::getTmpSer)
                .max()
                .orElse(0.0) + 1.0;

        TmpFileAddEntity entity = new TmpFileAddEntity();
        entity.setTmpFadNo(request.tmpFadNo());
        entity.setTmpSer(nextSer);
        entity.setTmpFileName(request.tmpFileName());
        entity.setTmpRmrk(request.tmpRmrk());
        entity.setTmpMk(request.tmpMk());
        entity.setTmpDate(request.tmpDate());
        entity.setTmpUserNo(userNo);
        entity.setTmpFinal(0);

        return toResponse(tmpFileAddRepository.save(entity));
    }

    @Transactional
    public TmpFileAddResponse finalize(String fadNo, Double ser) {
        TmpFileAddId id = buildId(fadNo, ser);
        TmpFileAddEntity entity = tmpFileAddRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "TmpFileAdd not found: fadNo=" + fadNo + ", ser=" + ser));
        entity.setTmpFinal(1);
        return toResponse(tmpFileAddRepository.save(entity));
    }

    @Transactional
    public void delete(String fadNo, Double ser) {
        TmpFileAddId id = buildId(fadNo, ser);
        if (!tmpFileAddRepository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "TmpFileAdd not found: fadNo=" + fadNo + ", ser=" + ser);
        }
        tmpFileAddRepository.deleteById(id);
    }

    private TmpFileAddId buildId(String fadNo, Double ser) {
        TmpFileAddId id = new TmpFileAddId();
        id.setTmpFadNo(fadNo);
        id.setTmpSer(ser);
        return id;
    }

    private TmpFileAddResponse toResponse(TmpFileAddEntity entity) {
        String userName = entity.getUser() != null ? entity.getUser().getUserName() : null;
        return new TmpFileAddResponse(
                entity.getTmpFadNo(),
                entity.getTmpSer(),
                entity.getTmpFileName(),
                entity.getTmpRmrk(),
                entity.getTmpMk(),
                entity.getTmpDate(),
                entity.getTmpUserNo(),
                userName,
                entity.getTmpFinal()
        );
    }
}
