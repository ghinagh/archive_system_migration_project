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

    @Transactional(readOnly = true)
    public PeriodicalResponse findById(Double perNo) {
        PeriodicalEntity entity = periodicalRepository.findById(perNo)
                .orElseThrow(() -> new ResourceNotFoundException("Periodical not found: " + perNo));
        return periodicalMapper.toResponse(entity);
    }

    @Transactional
    public PeriodicalResponse create(PeriodicalRequest request) {
        PeriodicalEntity entity = periodicalMapper.toEntity(request);
        return periodicalMapper.toResponse(periodicalRepository.save(entity));
    }

    @Transactional
    public PeriodicalResponse update(Double perNo, PeriodicalRequest request) {
        PeriodicalEntity entity = periodicalRepository.findById(perNo)
                .orElseThrow(() -> new ResourceNotFoundException("Periodical not found: " + perNo));
        periodicalMapper.updateEntity(request, entity);
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
