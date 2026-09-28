package com.startupstack.app.modules.periodicals.service;

import com.startupstack.app.modules.periodicals.dto.PeriodicalRequest;
import com.startupstack.app.modules.periodicals.dto.PeriodicalResponse;
import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import com.startupstack.app.modules.periodicals.mapper.PeriodicalMapper;
import com.startupstack.app.modules.periodicals.repository.PeriodicalRepository;
import com.startupstack.app.modules.periodicals.specification.PeriodicalSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.specification.GenericSpecificationBuilder;
import com.startupstack.app.shared.specification.SearchCondition;
import com.startupstack.app.shared.specification.SearchField;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class PeriodicalService {

    private final PeriodicalRepository periodicalRepository;
    private final PeriodicalMapper periodicalMapper;

    public PeriodicalService(PeriodicalRepository periodicalRepository,
                             PeriodicalMapper periodicalMapper) {
        this.periodicalRepository = periodicalRepository;
        this.periodicalMapper = periodicalMapper;
    }

    @Cacheable(value = "periodicals-all")
    @Transactional(readOnly = true)
    public List<PeriodicalResponse> getAllPeriodicals() {
        return periodicalRepository.findAllByOrderByNameAsc().stream()
                .map(periodicalMapper::toResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<PeriodicalResponse> searchByNameContains(String query) {
        if (query == null || query.isBlank()) {
            return getAllPeriodicals();
        }
        Specification<PeriodicalEntity> spec = PeriodicalSpecification.nameContains(query);
        return periodicalRepository.findAll(spec).stream()
                .map(periodicalMapper::toResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public Page<PeriodicalResponse> findAll(String name, String lang, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<PeriodicalEntity> spec = PeriodicalSpecification.belongsToUserEntity(userEnt)
                .and(PeriodicalSpecification.nameContains(name))
                .and(PeriodicalSpecification.hasLang(lang));
        return periodicalRepository.findAll(spec, pageable).map(periodicalMapper::toResponse);
    }

    /**
     * Fields a client may filter on via {@code POST /api/periodicals/search} — the same
     * flat AND/OR "cumulative questions" model as the legacy sort_from.frm builder.
     */
    private static final Map<String, SearchField> ADVANCED_SEARCH_FIELDS = Map.of(
            "name", new SearchField("name", SearchField.FieldType.STRING),
            "lang", new SearchField("lang", SearchField.FieldType.STRING),
            "frequency", new SearchField("frequency", SearchField.FieldType.STRING),
            "startDate", new SearchField("startDate", SearchField.FieldType.DATE));

    @Transactional(readOnly = true)
    public Page<PeriodicalResponse> advancedSearch(List<SearchCondition> conditions, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<PeriodicalEntity> scope = PeriodicalSpecification.belongsToUserEntity(userEnt);
        Specification<PeriodicalEntity> spec =
                scope.and(GenericSpecificationBuilder.build(conditions, ADVANCED_SEARCH_FIELDS));
        return periodicalRepository.findAll(spec, pageable).map(periodicalMapper::toResponse);
    }

    /**
     * Legacy اضافة (Add) button behavior: next PER_PER_NO = max(existing) + 1.
     */
    @Transactional(readOnly = true)
    public Double nextPerNo() {
        return periodicalRepository.findFirstByOrderByPerNoDesc()
                .map(e -> e.getPerNo() + 1)
                .orElse(1.0);
    }

    /**
     * Legacy لاحق (Next / Command6_Click) button: {@code m_no = M_PER_NO + 1} then
     * {@code exec SERCH_period '<m_no>'} — an EXACT match on PER_PER_NO+1, not "nearest
     * higher existing record". If PER_PER_NO+1 doesn't exist (e.g. it was deleted), the
     * legacy form shows "هذاالرقم غير موجود" and does not skip ahead to the next existing
     * gap-filled record. We replicate the exact-match lookup rather than the previous
     * "first greater than" specification, which incorrectly skipped over gaps.
     */
    @Transactional(readOnly = true)
    public PeriodicalResponse findNext(Double perNo) {
        Double target = perNo + 1;
        PeriodicalEntity entity = periodicalRepository.findById(target)
                .orElseThrow(() -> new ResourceNotFoundException("No next periodical after: " + perNo));
        return periodicalMapper.toResponse(entity);
    }

    /**
     * Legacy سابق (Previous / Command5_Click) button: {@code m_no = M_PER_NO - 1}; the
     * VB code only proceeds {@code If m_no > 1} (an exact-match {@code SERCH_period '<m_no>'}
     * lookup, not "nearest lower existing record" — gaps are NOT skipped, same as Next).
     * The legacy {@code m_no > 1} guard is an apparent off-by-one quirk of the original
     * form that silently blocks ever landing on record #1 via this button; we deliberately
     * do NOT replicate that specific quirk (it would make periodical #1 unreachable via
     * Previous for no functional reason), but DO replicate the core exact-match/no-gap-skip
     * behavior and the "not found" outcome once PER_PER_NO-1 drops below the valid range.
     */
    @Transactional(readOnly = true)
    public PeriodicalResponse findPrevious(Double perNo) {
        Double target = perNo - 1;
        if (target < 1) {
            throw new ResourceNotFoundException("No previous periodical before: " + perNo);
        }
        PeriodicalEntity entity = periodicalRepository.findById(target)
                .orElseThrow(() -> new ResourceNotFoundException("No previous periodical before: " + perNo));
        return periodicalMapper.toResponse(entity);
    }

    @Transactional(readOnly = true)
    public PeriodicalResponse findById(Double perNo) {
        PeriodicalEntity entity = periodicalRepository.findById(perNo)
                .orElseThrow(() -> new ResourceNotFoundException("Periodical not found: " + perNo));
        return periodicalMapper.toResponse(entity);
    }

    /**
     * PERIOD1.frm hardcodes {@code m_per_loc = 0} and (on update) {@code m_typ = 0}
     * before every INSR_period/UPD_period call — PER_PUB_LO and PER_TYP are never
     * user-editable on this form, just always reset to 0 on save.
     */
    private static void applyLegacyHardcodedZeroFields(PeriodicalEntity entity) {
        entity.setPublishLocation(0.0);
        entity.setType(0.0);
    }

    @Transactional
    public PeriodicalResponse create(PeriodicalRequest request) {
        PeriodicalEntity entity = periodicalMapper.toEntity(request);
        applyLegacyHardcodedZeroFields(entity);
        return periodicalMapper.toResponse(periodicalRepository.save(entity));
    }

    @Transactional
    public PeriodicalResponse update(Double perNo, PeriodicalRequest request) {
        PeriodicalEntity entity = periodicalRepository.findById(perNo)
                .orElseThrow(() -> new ResourceNotFoundException("Periodical not found: " + perNo));
        periodicalMapper.updateEntity(request, entity);
        applyLegacyHardcodedZeroFields(entity);
        return periodicalMapper.toResponse(periodicalRepository.save(entity));
    }

    @Transactional
    public void delete(Double perNo) {
        if (!periodicalRepository.existsById(perNo)) {
            throw new ResourceNotFoundException("Periodical not found: " + perNo);
        }
        periodicalRepository.deleteById(perNo);
    }
}
