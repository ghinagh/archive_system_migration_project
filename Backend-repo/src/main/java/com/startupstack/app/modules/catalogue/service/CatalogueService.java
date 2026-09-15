package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.CatalogueRequest;
import com.startupstack.app.modules.catalogue.dto.CatalogueResponse;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.mapper.CatalogueMapper;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.catalogue.specification.CatalogueSpecification;
import com.startupstack.app.modules.corrections.service.CorrectionLogService;
import com.startupstack.app.modules.retrievalfields.service.RetrievalFieldService;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.specification.GenericSpecificationBuilder;
import com.startupstack.app.shared.specification.SearchCondition;
import com.startupstack.app.shared.specification.SearchField;
import com.startupstack.app.shared.util.SecurityUtils;
import com.startupstack.app.shared.wordindex.WordIndexService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class CatalogueService {

    private final CatalogueRepository catalogueRepository;
    private final CatalogueMapper catalogueMapper;
    private final UserRepository userRepository;
    private final WordIndexService wordIndexService;
    private final CorrectionLogService correctionLogService;
    private final RetrievalFieldService retrievalFieldService;

    public CatalogueService(CatalogueRepository catalogueRepository,
                            CatalogueMapper catalogueMapper,
                            UserRepository userRepository,
                            WordIndexService wordIndexService,
                            CorrectionLogService correctionLogService,
                            RetrievalFieldService retrievalFieldService) {
        this.catalogueRepository = catalogueRepository;
        this.catalogueMapper = catalogueMapper;
        this.userRepository = userRepository;
        this.wordIndexService = wordIndexService;
        this.correctionLogService = correctionLogService;
        this.retrievalFieldService = retrievalFieldService;
    }

    @Transactional(readOnly = true)
    public Page<CatalogueResponse> findAll(String type,
                                           LocalDateTime dateFrom,
                                           LocalDateTime dateTo,
                                           Pageable pageable) {
        boolean isAdmin = SecurityUtils.isAdmin();
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        String userDoc = isAdmin ? null : SecurityUtils.getCurrentUserDoc();
        Integer userWilaya = isAdmin ? null : SecurityUtils.getCurrentUserWilaya();
        Specification<CatalogueEntity> spec =
                CatalogueSpecification.hasDocumentType(userDoc)
                        .and(CatalogueSpecification.belongsToUserEntity(userEnt))
                        .and(CatalogueSpecification.hasWilaya(userWilaya))
                        .and(CatalogueSpecification.hasType(type))
                        .and(CatalogueSpecification.entryDateFrom(dateFrom))
                        .and(CatalogueSpecification.entryDateTo(dateTo));
        return catalogueRepository.findAll(spec, pageable).map(catalogueMapper::toResponse);
    }

    /**
     * Fields a client may filter on via {@code POST /api/catalogue/search} — the same
     * flat AND/OR "cumulative questions" model as the legacy sort_from.frm builder.
     */
    private static final Map<String, SearchField> ADVANCED_SEARCH_FIELDS = Map.of(
            "title", new SearchField("activeTitleAr", SearchField.FieldType.STRING),
            "additionalTitle", new SearchField("additionalTitle", SearchField.FieldType.STRING),
            "type", new SearchField("type", SearchField.FieldType.STRING),
            "appDoc", new SearchField("appDoc", SearchField.FieldType.STRING),
            "entryDate", new SearchField("entryDate", SearchField.FieldType.DATE));

    @Transactional(readOnly = true)
    public Page<CatalogueResponse> advancedSearch(List<SearchCondition> conditions, Pageable pageable) {
        boolean isAdmin = SecurityUtils.isAdmin();
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        String userDoc = isAdmin ? null : SecurityUtils.getCurrentUserDoc();
        Integer userWilaya = isAdmin ? null : SecurityUtils.getCurrentUserWilaya();
        Specification<CatalogueEntity> scope =
                CatalogueSpecification.hasDocumentType(userDoc)
                        .and(CatalogueSpecification.belongsToUserEntity(userEnt))
                        .and(CatalogueSpecification.hasWilaya(userWilaya));
        Specification<CatalogueEntity> spec =
                scope.and(GenericSpecificationBuilder.build(conditions, allSearchFields()));
        return catalogueRepository.findAll(spec, pageable).map(catalogueMapper::toResponse);
    }

    /**
     * The hardcoded baseline fields plus any admin-defined {@link RetrievalFieldService}
     * entries for the "CATALOGUE" module — additive, so a bad admin-defined field can
     * never shadow or break a built-in one.
     */
    private Map<String, SearchField> allSearchFields() {
        Map<String, SearchField> fields = new LinkedHashMap<>(ADVANCED_SEARCH_FIELDS);
        retrievalFieldService.getSearchFieldsForModule("CATALOGUE").forEach(fields::putIfAbsent);
        return fields;
    }

    @Transactional(readOnly = true)
    public CatalogueResponse findById(String appNo) {
        CatalogueEntity entity = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));
        return catalogueMapper.toResponse(entity);
    }

    @Transactional
    public CatalogueResponse create(CatalogueRequest request) {
        CatalogueEntity entity = catalogueMapper.toEntity(request);
        CatalogueEntity saved = catalogueRepository.save(entity);
        wordIndexService.indexText(saved.getAppNo(), saved.getActiveTitleAr(), "T");
        return catalogueMapper.toResponse(saved);
    }

    @Transactional
    public CatalogueEntity createMainRecord(CatalogueRequest request) {
        CatalogueEntity entity = catalogueMapper.toEntity(request);
        return catalogueRepository.save(entity);
    }

    @Transactional
    public CatalogueResponse update(String appNo, CatalogueRequest request, String correctionReason) {
        CatalogueEntity entity = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));
        checkTransferLock(entity);

        Map<String, String> before = captureFields(entity);
        catalogueMapper.updateEntity(request, entity);
        CatalogueEntity saved = catalogueRepository.save(entity);
        wordIndexService.indexText(saved.getAppNo(), saved.getActiveTitleAr(), "T");

        Map<String, String> after = captureFields(saved);
        before.forEach((field, oldVal) -> {
            String newVal = after.get(field);
            if (!Objects.equals(oldVal, newVal)) {
                correctionLogService.logChange(appNo, field, oldVal, newVal, correctionReason);
            }
        });

        return catalogueMapper.toResponse(saved);
    }

    private Map<String, String> captureFields(CatalogueEntity e) {
        Map<String, String> map = new LinkedHashMap<>();
        map.put("activeTitleAr",   e.getActiveTitleAr());
        map.put("additionalTitle", e.getAdditionalTitle());
        map.put("dataEntry",       e.getDataEntry());
        map.put("appDoc",          e.getAppDoc());
        map.put("type",            e.getType());
        map.put("result",          e.getResult());
        map.put("appRevision",     e.getAppRevision());
        return map;
    }

    @Transactional
    public void delete(String appNo) {
        CatalogueEntity entity = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));
        checkTransferLock(entity);
        catalogueRepository.delete(entity);
    }

    @Transactional(readOnly = true)
    public Page<CatalogueResponse> getLockedDocuments(Pageable pageable) {
        return catalogueRepository.findByTrans(1, pageable).map(catalogueMapper::toResponse);
    }

    @Transactional
    public CatalogueResponse unlockRecord(String appNo, String authenticatedUsername) {
        UserEntity user = userRepository.findByUserName(authenticatedUsername)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        if (!"A".equals(user.getUserLevel() != null ? user.getUserLevel().trim() : null)) {
            throw new AccessDeniedException("Only administrators can unlock records");
        }

        CatalogueEntity entity = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));
        entity.setTrans(0);
        return catalogueMapper.toResponse(catalogueRepository.save(entity));
    }

    private void checkTransferLock(CatalogueEntity entity) {
        if (entity.getTrans() != null && entity.getTrans() == 1) {
            throw new BusinessException("Record is locked: transfer flag is set");
        }
    }
}
