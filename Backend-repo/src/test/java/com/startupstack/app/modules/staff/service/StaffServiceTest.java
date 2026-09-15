package com.startupstack.app.modules.staff.service;

import com.startupstack.app.modules.staff.dto.StaffRequest;
import com.startupstack.app.modules.staff.dto.StaffResponse;
import com.startupstack.app.modules.staff.entity.Person1Entity;
import com.startupstack.app.modules.staff.mapper.StaffMapper;
import com.startupstack.app.modules.staff.repository.Person1Repository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class StaffServiceTest {

    @Mock
    private Person1Repository person1Repository;
    @Mock
    private StaffMapper staffMapper;
    @InjectMocks
    private StaffService staffService;

    private Person1Entity entity;
    private StaffResponse response;

    @BeforeEach
    void setUp() {
        entity = new Person1Entity();
        entity.setPrsNo("S0001");
        entity.setPrsName("سعيد أحمد");

        response = new StaffResponse();
        response.setPrsNo("S0001");
        response.setName("سعيد أحمد");
    }

    @Test
    void findAll_delegatesToRepositoryWithSpecificationAndMapsPage() {
        Page<Person1Entity> page = new PageImpl<>(List.of(entity));
        when(person1Repository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
        when(staffMapper.toResponse(entity)).thenReturn(response);

        Page<StaffResponse> result = staffService.findAll(null, null, Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
        assertEquals("S0001", result.getContent().get(0).getPrsNo());
    }

    @Test
    void findById_existing_returnsResponse() {
        when(person1Repository.findById("S0001")).thenReturn(Optional.of(entity));
        when(staffMapper.toResponse(entity)).thenReturn(response);

        StaffResponse result = staffService.findById("S0001");

        assertEquals("سعيد أحمد", result.getName());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(person1Repository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> staffService.findById("MISSING"));
    }

    @Test
    void create_mapsAndSaves() {
        StaffRequest request = new StaffRequest();
        request.setPrsNo("S0001");
        request.setName("سعيد أحمد");
        when(staffMapper.toEntity(request)).thenReturn(entity);
        when(person1Repository.save(entity)).thenReturn(entity);
        when(staffMapper.toResponse(entity)).thenReturn(response);

        StaffResponse result = staffService.create(request);

        assertNotNull(result);
        verify(person1Repository).save(entity);
    }

    @Test
    void update_existing_updatesAndSaves() {
        StaffRequest request = new StaffRequest();
        request.setName("اسم محدث");
        when(person1Repository.findById("S0001")).thenReturn(Optional.of(entity));
        when(person1Repository.save(entity)).thenReturn(entity);
        when(staffMapper.toResponse(entity)).thenReturn(response);

        staffService.update("S0001", request);

        verify(staffMapper).updateEntity(request, entity);
        verify(person1Repository).save(entity);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        StaffRequest request = new StaffRequest();
        when(person1Repository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> staffService.update("MISSING", request));
    }

    @Test
    void delete_existing_deletes() {
        when(person1Repository.existsById("S0001")).thenReturn(true);

        staffService.delete("S0001");

        verify(person1Repository).deleteById("S0001");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(person1Repository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> staffService.delete("MISSING"));
        verify(person1Repository, never()).deleteById(any());
    }
}
