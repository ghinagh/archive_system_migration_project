package com.startupstack.app.modules.persons.service;

import com.startupstack.app.modules.persons.dto.PersonRequest;
import com.startupstack.app.modules.persons.dto.PersonResponse;
import com.startupstack.app.modules.persons.entity.PersonEntity;
import com.startupstack.app.modules.persons.mapper.PersonMapper;
import com.startupstack.app.modules.persons.repository.PersonRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class PersonServiceTest {

    @Mock
    private PersonRepository personRepository;
    @Mock
    private PersonMapper personMapper;
    @InjectMocks
    private PersonService personService;

    private PersonEntity testEntity;
    private PersonResponse testResponse;

    @BeforeEach
    void setUp() {
        testEntity = new PersonEntity();
        testEntity.setPrsNo("PRS001    ");
        testEntity.setPrsName("محمد أحمد");
        testEntity.setPrsEnt("01");

        testResponse = new PersonResponse();
        testResponse.setPrsNo("PRS001    ");
        testResponse.setName("محمد أحمد");
        testResponse.setEntity("01");
    }

    @Test
    void findById_existingPerson_returnsResponse() {
        when(personRepository.findById("PRS001    ")).thenReturn(Optional.of(testEntity));
        when(personMapper.toResponse(testEntity)).thenReturn(testResponse);

        PersonResponse result = personService.findById("PRS001    ");

        assertEquals("محمد أحمد", result.getName());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(personRepository.findById("NONE")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> personService.findById("NONE"));
    }

    @Test
    void create_validRequest_savesAndReturns() {
        PersonRequest request = new PersonRequest();
        request.setPrsNo("PRS002");
        request.setName("علي حسن");

        when(personMapper.toEntity(request)).thenReturn(testEntity);
        when(personRepository.save(testEntity)).thenReturn(testEntity);
        when(personMapper.toResponse(testEntity)).thenReturn(testResponse);

        PersonResponse result = personService.create(request);

        assertNotNull(result);
        verify(personRepository).save(testEntity);
    }

    @Test
    @SuppressWarnings("unchecked")
    void findAll_filterByName_returnsPaginatedResults() {
        Page<PersonEntity> page = new PageImpl<>(List.of(testEntity));
        when(personRepository.findAll(any(Specification.class), any(PageRequest.class))).thenReturn(page);
        when(personMapper.toResponse(testEntity)).thenReturn(testResponse);

        Page<PersonResponse> result = personService.findAll("محمد", null, PageRequest.of(0, 10));

        assertEquals(1, result.getTotalElements());
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        when(personRepository.findById("NONE")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> personService.update("NONE", new PersonRequest()));
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(personRepository.existsById("NONE")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> personService.delete("NONE"));
    }
}
