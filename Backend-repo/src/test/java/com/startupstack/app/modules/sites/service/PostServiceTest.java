package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.PostRequest;
import com.startupstack.app.modules.sites.dto.PostResponse;
import com.startupstack.app.modules.sites.dto.PostWithSiteView;
import com.startupstack.app.modules.sites.entity.FormEntity;
import com.startupstack.app.modules.sites.entity.PostEntity;
import com.startupstack.app.modules.sites.mapper.PostMapper;
import com.startupstack.app.modules.sites.repository.FormRepository;
import com.startupstack.app.modules.sites.repository.PostRepository;
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
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class PostServiceTest {

    @Mock
    private PostRepository postRepository;
    @Mock
    private FormRepository formRepository;
    @Mock
    private PostMapper postMapper;
    @InjectMocks
    private PostService postService;

    private PostEntity entity;
    private PostResponse response;

    @BeforeEach
    void setUp() {
        entity = new PostEntity();
        entity.setSerial("P00001");

        response = new PostResponse();
        response.setSerial("P00001");
    }

    @Test
    void findAll_includeSiteInfoTrue_usesProjectionQuery() {
        PostWithSiteView view = mock(PostWithSiteView.class);
        when(view.getSerial()).thenReturn("P00001");
        when(view.getSiteDescription()).thenReturn("موقع تجريبي");
        Page<PostWithSiteView> page = new PageImpl<>(List.of(view));
        when(postRepository.findAllWithSiteInfo(eq("F0000001"), any(), any(Pageable.class))).thenReturn(page);

        Page<PostResponse> result = postService.findAll("F0000001", null, true, Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
        assertEquals("P00001", result.getContent().get(0).getSerial());
        assertEquals("موقع تجريبي", result.getContent().get(0).getSiteDescription());
        verifyNoInteractions(postMapper);
    }

    @Test
    void findAll_includeSiteInfoFalseOrNull_usesSpecificationQuery() {
        Page<PostEntity> page = new PageImpl<>(List.of(entity));
        when(postRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
        when(postMapper.toResponse(entity)).thenReturn(response);

        Page<PostResponse> result = postService.findAll(null, null, false, Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
        verifyNoInteractions(formRepository);
    }

    @Test
    void findById_existing_returnsResponse() {
        when(postRepository.findById("P00001")).thenReturn(Optional.of(entity));
        when(postMapper.toResponse(entity)).thenReturn(response);

        PostResponse result = postService.findById("P00001");

        assertEquals("P00001", result.getSerial());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(postRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> postService.findById("MISSING"));
    }

    @Test
    void create_withFormNo_linksForm() {
        PostRequest request = new PostRequest();
        request.setSerial("P00001");
        request.setFormNo("F0000001");
        FormEntity form = new FormEntity();
        when(postMapper.toEntity(request)).thenReturn(entity);
        when(formRepository.findById("F0000001")).thenReturn(Optional.of(form));
        when(postRepository.save(entity)).thenReturn(entity);
        when(postMapper.toResponse(entity)).thenReturn(response);

        postService.create(request);

        assertEquals(form, entity.getForm());
        verify(postRepository).save(entity);
    }

    @Test
    void create_withUnknownFormNo_throwsResourceNotFound() {
        PostRequest request = new PostRequest();
        request.setFormNo("MISSING");
        when(postMapper.toEntity(request)).thenReturn(entity);
        when(formRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> postService.create(request));
        verify(postRepository, never()).save(any());
    }

    @Test
    void create_withoutFormNo_skipsFormLookup() {
        PostRequest request = new PostRequest();
        when(postMapper.toEntity(request)).thenReturn(entity);
        when(postRepository.save(entity)).thenReturn(entity);
        when(postMapper.toResponse(entity)).thenReturn(response);

        postService.create(request);

        verifyNoInteractions(formRepository);
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        PostRequest request = new PostRequest();
        when(postRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> postService.update("MISSING", request));
    }

    @Test
    void update_withFormNo_relinksForm() {
        PostRequest request = new PostRequest();
        request.setFormNo("F0000002");
        FormEntity form = new FormEntity();
        when(postRepository.findById("P00001")).thenReturn(Optional.of(entity));
        when(formRepository.findById("F0000002")).thenReturn(Optional.of(form));
        when(postRepository.save(entity)).thenReturn(entity);
        when(postMapper.toResponse(entity)).thenReturn(response);

        postService.update("P00001", request);

        assertEquals(form, entity.getForm());
        verify(postMapper).updateEntity(request, entity);
    }

    @Test
    void delete_existing_deletes() {
        when(postRepository.existsById("P00001")).thenReturn(true);

        postService.delete("P00001");

        verify(postRepository).deleteById("P00001");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(postRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> postService.delete("MISSING"));
        verify(postRepository, never()).deleteById(any());
    }
}
