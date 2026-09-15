package com.startupstack.app.modules.authors.service;

import com.startupstack.app.modules.authors.dto.AuthorRequest;
import com.startupstack.app.modules.authors.dto.AuthorResponse;
import com.startupstack.app.modules.authors.entity.AuthorEntity;
import com.startupstack.app.modules.authors.mapper.AuthorMapper;
import com.startupstack.app.modules.authors.repository.AuthorRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthorServiceTest {

    @Mock
    private AuthorRepository authorRepository;
    @Mock
    private AuthorMapper authorMapper;
    @InjectMocks
    private AuthorService authorService;

    private AuthorEntity testEntity;
    private AuthorResponse testResponse;

    @BeforeEach
    void setUp() {
        testEntity = new AuthorEntity();
        testEntity.setAutNo(1.0);
        testEntity.setAutName("ابن خلدون");
        testEntity.setAutType("01");

        testResponse = new AuthorResponse();
        testResponse.setAutNo(1.0);
        testResponse.setName("ابن خلدون");
        testResponse.setType("01");
    }

    @Test
    void findById_existingAuthor_returnsResponse() {
        when(authorRepository.findById(1.0)).thenReturn(Optional.of(testEntity));
        when(authorMapper.toResponse(testEntity)).thenReturn(testResponse);

        AuthorResponse result = authorService.findById(1.0);

        assertEquals("ابن خلدون", result.getName());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(authorRepository.findById(999.0)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> authorService.findById(999.0));
    }

    @Test
    void create_validRequest_savesAndReturns() {
        AuthorRequest request = new AuthorRequest();
        request.setAutNo(2.0);
        request.setName("الجاحظ");
        request.setType("01");

        when(authorMapper.toEntity(request)).thenReturn(testEntity);
        when(authorRepository.save(testEntity)).thenReturn(testEntity);
        when(authorMapper.toResponse(testEntity)).thenReturn(testResponse);

        AuthorResponse result = authorService.create(request);

        assertNotNull(result);
        verify(authorRepository).save(testEntity);
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(authorRepository.existsById(999.0)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> authorService.delete(999.0));
    }
}
