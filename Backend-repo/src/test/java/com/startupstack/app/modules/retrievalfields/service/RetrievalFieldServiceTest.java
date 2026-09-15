package com.startupstack.app.modules.retrievalfields.service;

import com.startupstack.app.modules.retrievalfields.dto.RetrievalFieldRequest;
import com.startupstack.app.modules.retrievalfields.dto.RetrievalFieldResponse;
import com.startupstack.app.modules.retrievalfields.entity.RetrievalFieldEntity;
import com.startupstack.app.modules.retrievalfields.repository.RetrievalFieldRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.specification.SearchField;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class RetrievalFieldServiceTest {

    @Mock
    private RetrievalFieldRepository repository;
    @InjectMocks
    private RetrievalFieldService service;

    private RetrievalFieldEntity entity() {
        RetrievalFieldEntity e = new RetrievalFieldEntity();
        e.setModule("CATALOGUE");
        e.setFieldKey("publisher");
        e.setEntityPath("publisherName");
        e.setFieldType("STRING");
        e.setLabel("Publisher");
        e.setEnabled(true);
        return e;
    }

    @Test
    void getAll_withModule_filtersByModule() {
        when(repository.findByModule("CATALOGUE")).thenReturn(List.of(entity()));

        List<RetrievalFieldResponse> result = service.getAll("CATALOGUE");

        assertEquals(1, result.size());
        assertEquals("publisher", result.get(0).getFieldKey());
        verify(repository, never()).findAll();
    }

    @Test
    void getAll_noModule_returnsEverything() {
        when(repository.findAll()).thenReturn(List.of(entity()));

        List<RetrievalFieldResponse> result = service.getAll(null);

        assertEquals(1, result.size());
        verify(repository, never()).findByModule(any());
    }

    @Test
    void getSearchFieldsForModule_mapsEnabledFieldsOnly() {
        when(repository.findByModuleAndEnabledTrue("CATALOGUE")).thenReturn(List.of(entity()));

        Map<String, SearchField> fields = service.getSearchFieldsForModule("CATALOGUE");

        assertEquals(1, fields.size());
        SearchField field = fields.get("publisher");
        assertEquals("publisherName", field.path());
        assertEquals(SearchField.FieldType.STRING, field.type());
    }

    @Test
    void create_newFieldKey_saves() {
        RetrievalFieldRequest request = new RetrievalFieldRequest();
        request.setModule("CATALOGUE");
        request.setFieldKey("publisher");
        request.setEntityPath("publisherName");
        request.setFieldType("STRING");
        request.setLabel("Publisher");
        request.setEnabled(true);
        when(repository.existsByModuleAndFieldKey("CATALOGUE", "publisher")).thenReturn(false);
        when(repository.save(any(RetrievalFieldEntity.class))).thenAnswer(inv -> inv.getArgument(0));

        RetrievalFieldResponse result = service.create(request);

        assertEquals("CATALOGUE", result.getModule());
        assertEquals("publisher", result.getFieldKey());
        verify(repository).save(any(RetrievalFieldEntity.class));
    }

    @Test
    void create_duplicateModuleAndKey_throwsBusinessException() {
        RetrievalFieldRequest request = new RetrievalFieldRequest();
        request.setModule("CATALOGUE");
        request.setFieldKey("publisher");
        request.setEntityPath("publisherName");
        request.setFieldType("STRING");
        request.setLabel("Publisher");
        when(repository.existsByModuleAndFieldKey("CATALOGUE", "publisher")).thenReturn(true);

        assertThrows(BusinessException.class, () -> service.create(request));
        verify(repository, never()).save(any());
    }

    @Test
    void update_existing_updatesAndSaves() {
        UUID id = UUID.randomUUID();
        RetrievalFieldEntity existing = entity();
        RetrievalFieldRequest request = new RetrievalFieldRequest();
        request.setModule("CATALOGUE");
        request.setFieldKey("publisher");
        request.setEntityPath("publisherName");
        request.setFieldType("STRING");
        request.setLabel("Updated Label");
        request.setEnabled(false);
        when(repository.findById(id)).thenReturn(java.util.Optional.of(existing));
        when(repository.save(existing)).thenReturn(existing);

        RetrievalFieldResponse result = service.update(id, request);

        assertEquals("Updated Label", result.getLabel());
        assertFalse(result.isEnabled());
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        UUID id = UUID.randomUUID();
        RetrievalFieldRequest request = new RetrievalFieldRequest();
        when(repository.findById(id)).thenReturn(java.util.Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> service.update(id, request));
    }

    @Test
    void delete_existing_deletes() {
        UUID id = UUID.randomUUID();
        when(repository.existsById(id)).thenReturn(true);

        service.delete(id);

        verify(repository).deleteById(id);
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        UUID id = UUID.randomUUID();
        when(repository.existsById(id)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> service.delete(id));
        verify(repository, never()).deleteById(any());
    }
}
