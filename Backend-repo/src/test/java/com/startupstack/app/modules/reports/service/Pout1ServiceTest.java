package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.reports.dto.Pout1Request;
import com.startupstack.app.modules.reports.dto.Pout1Response;
import com.startupstack.app.modules.reports.entity.Pout1Entity;
import com.startupstack.app.modules.reports.entity.Pout1Id;
import com.startupstack.app.modules.reports.repository.Pout1Repository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class Pout1ServiceTest {

    @Mock
    private Pout1Repository pout1Repository;
    @InjectMocks
    private Pout1Service pout1Service;

    private Pout1Entity entity;

    private Pout1Entity newEntity() {
        Pout1Entity e = new Pout1Entity();
        e.setInstitution("BNK");
        e.setOutputNum(1.0);
        e.setDescription("تقرير تجريبي");
        e.setName("RPT1");
        return e;
    }

    @Test
    void findAll_mapsPage() {
        entity = newEntity();
        Page<Pout1Entity> page = new PageImpl<>(List.of(entity));
        when(pout1Repository.findAll(Pageable.unpaged())).thenReturn(page);

        Page<Pout1Response> result = pout1Service.findAll(Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
        assertEquals("BNK", result.getContent().get(0).getInstitution());
    }

    @Test
    void findById_existing_returnsResponse() {
        entity = newEntity();
        when(pout1Repository.findById(any(Pout1Id.class))).thenReturn(Optional.of(entity));

        Pout1Response result = pout1Service.findById("BNK", 1.0);

        assertEquals("تقرير تجريبي", result.getDescription());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(pout1Repository.findById(any(Pout1Id.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> pout1Service.findById("MISSING", 999.0));
    }

    @Test
    void create_setsInstitutionAndMapsRequestFields() {
        Pout1Request request = new Pout1Request();
        request.setOutputNum(1.0);
        request.setDescription("تقرير جديد");
        request.setName("RPT1");
        when(pout1Repository.save(any(Pout1Entity.class))).thenAnswer(inv -> inv.getArgument(0));

        Pout1Response result = pout1Service.create("BNK", request);

        assertEquals("BNK", result.getInstitution());
        assertEquals("تقرير جديد", result.getDescription());
    }

    @Test
    void update_existing_updatesFieldsAndSaves() {
        entity = newEntity();
        Pout1Request request = new Pout1Request();
        request.setOutputNum(1.0);
        request.setDescription("وصف محدث");
        request.setName("RPT1-updated");
        when(pout1Repository.findById(any(Pout1Id.class))).thenReturn(Optional.of(entity));
        when(pout1Repository.save(entity)).thenReturn(entity);

        Pout1Response result = pout1Service.update("BNK", 1.0, request);

        assertEquals("وصف محدث", result.getDescription());
        assertEquals("RPT1-updated", result.getName());
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        Pout1Request request = new Pout1Request();
        when(pout1Repository.findById(any(Pout1Id.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> pout1Service.update("MISSING", 999.0, request));
    }

    @Test
    void delete_existing_deletes() {
        when(pout1Repository.existsById(any(Pout1Id.class))).thenReturn(true);

        pout1Service.delete("BNK", 1.0);

        verify(pout1Repository).deleteById(any(Pout1Id.class));
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(pout1Repository.existsById(any(Pout1Id.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> pout1Service.delete("MISSING", 999.0));
        verify(pout1Repository, never()).deleteById(any());
    }
}
