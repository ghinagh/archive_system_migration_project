package com.startupstack.app.modules.retrievalfields.service;

import com.startupstack.app.modules.retrievalfields.dto.RetrievalFieldRequest;
import com.startupstack.app.modules.retrievalfields.dto.RetrievalFieldResponse;
import com.startupstack.app.modules.retrievalfields.entity.RetrievalFieldEntity;
import com.startupstack.app.modules.retrievalfields.repository.RetrievalFieldRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.specification.SearchField;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class RetrievalFieldService {

    private final RetrievalFieldRepository repository;

    public RetrievalFieldService(RetrievalFieldRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public List<RetrievalFieldResponse> getAll(String module) {
        List<RetrievalFieldEntity> entities = module != null
                ? repository.findByModule(module)
                : repository.findAll();
        return entities.stream().map(this::toResponse).toList();
    }

    /**
     * Enabled fields for a module, ready to merge into a domain service's
     * hardcoded {@code ADVANCED_SEARCH_FIELDS} baseline map.
     */
    @Transactional(readOnly = true)
    public Map<String, SearchField> getSearchFieldsForModule(String module) {
        return repository.findByModuleAndEnabledTrue(module).stream()
                .collect(Collectors.toMap(
                        RetrievalFieldEntity::getFieldKey,
                        e -> new SearchField(e.getEntityPath(), SearchField.FieldType.valueOf(e.getFieldType()))));
    }

    @Transactional
    public RetrievalFieldResponse create(RetrievalFieldRequest request) {
        if (repository.existsByModuleAndFieldKey(request.getModule(), request.getFieldKey())) {
            throw new BusinessException(
                    "A retrieval field already exists for module=" + request.getModule()
                            + ", key=" + request.getFieldKey());
        }
        RetrievalFieldEntity entity = new RetrievalFieldEntity();
        applyRequest(entity, request);
        return toResponse(repository.save(entity));
    }

    @Transactional
    public RetrievalFieldResponse update(UUID id, RetrievalFieldRequest request) {
        RetrievalFieldEntity entity = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Retrieval field not found: " + id));
        applyRequest(entity, request);
        return toResponse(repository.save(entity));
    }

    @Transactional
    public void delete(UUID id) {
        if (!repository.existsById(id)) {
            throw new ResourceNotFoundException("Retrieval field not found: " + id);
        }
        repository.deleteById(id);
    }

    private void applyRequest(RetrievalFieldEntity entity, RetrievalFieldRequest request) {
        entity.setModule(request.getModule());
        entity.setFieldKey(request.getFieldKey());
        entity.setEntityPath(request.getEntityPath());
        entity.setFieldType(request.getFieldType());
        entity.setLabel(request.getLabel());
        entity.setEnabled(request.isEnabled());
        entity.setJoinPath(request.getJoinPath());
        entity.setCategory(request.getCategory());
        entity.setLookupEnabled(request.isLookupEnabled());
        entity.setDisplayOrder(request.getDisplayOrder());
    }

    private RetrievalFieldResponse toResponse(RetrievalFieldEntity entity) {
        RetrievalFieldResponse r = new RetrievalFieldResponse();
        r.setId(entity.getId());
        r.setModule(entity.getModule());
        r.setFieldKey(entity.getFieldKey());
        r.setEntityPath(entity.getEntityPath());
        r.setFieldType(entity.getFieldType());
        r.setLabel(entity.getLabel());
        r.setEnabled(entity.isEnabled());
        r.setJoinPath(entity.getJoinPath());
        r.setCategory(entity.getCategory());
        r.setLookupEnabled(entity.isLookupEnabled());
        r.setDisplayOrder(entity.getDisplayOrder());
        r.setCreatedAt(entity.getCreatedAt());
        r.setUpdatedAt(entity.getUpdatedAt());
        return r;
    }
}
