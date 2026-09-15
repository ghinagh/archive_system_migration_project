package com.startupstack.app.modules.news.service;

import com.startupstack.app.modules.news.dto.NewsRequest;
import com.startupstack.app.modules.news.dto.NewsResponse;
import com.startupstack.app.modules.news.entity.NewsEntity;
import com.startupstack.app.modules.news.entity.NewsWordEntity;
import com.startupstack.app.modules.news.mapper.NewsMapper;
import com.startupstack.app.modules.news.repository.NewsRepository;
import com.startupstack.app.modules.news.repository.NewsWordRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.wordindex.WordIndexService;
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
class NewsServiceTest {

    @Mock
    private NewsRepository newsRepository;
    @Mock
    private NewsWordRepository newsWordRepository;
    @Mock
    private NewsMapper newsMapper;
    @Mock
    private WordIndexService wordIndexService;
    @InjectMocks
    private NewsService newsService;

    private NewsEntity entity;
    private NewsResponse response;

    @BeforeEach
    void setUp() {
        entity = new NewsEntity();
        entity.setNewsNo("NW00001");
        entity.setNewsTit1("عنوان الخبر الأول");

        response = new NewsResponse();
        response.setNewsNo("NW00001");
        response.setNewsTit1("عنوان الخبر الأول");
    }

    @Test
    void findById_existing_returnsResponseWithKeywords() {
        NewsWordEntity kw = new NewsWordEntity();
        kw.setWrdAppNo("NW00001");
        kw.setWrdWord("عنوان");
        when(newsRepository.findById("NW00001")).thenReturn(Optional.of(entity));
        when(newsMapper.toResponse(entity)).thenReturn(response);
        when(newsWordRepository.findByWrdAppNo("NW00001")).thenReturn(List.of(kw));

        NewsResponse result = newsService.findById("NW00001");

        assertEquals(List.of("عنوان"), result.getKeywords());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(newsRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> newsService.findById("MISSING"));
    }

    @Test
    void findAll_delegatesToRepositoryWithSpecificationAndMapsPage() {
        Page<NewsEntity> page = new PageImpl<>(List.of(entity));
        when(newsRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
        when(newsMapper.toResponse(entity)).thenReturn(response);
        when(newsWordRepository.findByWrdAppNo("NW00001")).thenReturn(List.of());

        Page<NewsResponse> result = newsService.findAll(null, null, null, null, null, Pageable.unpaged());

        assertEquals(1, result.getTotalElements());
    }

    @Test
    void create_tokenizesTitleAndIndexesWords() {
        NewsRequest request = new NewsRequest();
        request.setNewsNo("NW00001");
        request.setNewsTit1("عنوان مهم جدا");
        entity.setNewsTit1("عنوان مهم جدا");
        when(newsMapper.toEntity(request)).thenReturn(entity);
        when(newsRepository.save(entity)).thenReturn(entity);
        when(newsMapper.toResponse(entity)).thenReturn(response);
        when(newsWordRepository.existsById(any())).thenReturn(false);
        when(newsWordRepository.findByWrdAppNo("NW00001")).thenReturn(List.of());

        NewsResponse result = newsService.create(request);

        assertNotNull(result);
        verify(wordIndexService).indexText("NW00001", "عنوان مهم جدا", "N");
        verify(newsWordRepository, atLeastOnce()).save(any(NewsWordEntity.class));
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        NewsRequest request = new NewsRequest();
        when(newsRepository.findById("MISSING")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> newsService.update("MISSING", request));
    }

    @Test
    void update_existing_clearsOldKeywordsAndReindexes() {
        NewsRequest request = new NewsRequest();
        request.setNewsTit1("عنوان جديد");
        when(newsRepository.findById("NW00001")).thenReturn(Optional.of(entity));
        when(newsRepository.save(entity)).thenReturn(entity);
        when(newsMapper.toResponse(entity)).thenReturn(response);
        when(newsWordRepository.existsById(any())).thenReturn(false);
        when(newsWordRepository.findByWrdAppNo("NW00001")).thenReturn(List.of());

        newsService.update("NW00001", request);

        verify(newsWordRepository).deleteByWrdAppNo("NW00001");
        verify(newsMapper).updateEntity(request, entity);
    }

    @Test
    void delete_existing_removesKeywordsThenRecord() {
        when(newsRepository.existsById("NW00001")).thenReturn(true);

        newsService.delete("NW00001");

        verify(newsWordRepository).deleteByWrdAppNo("NW00001");
        verify(newsRepository).deleteById("NW00001");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(newsRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> newsService.delete("MISSING"));
        verify(newsRepository, never()).deleteById(any());
    }

    @Test
    void getKeywords_nonExistentNews_throwsResourceNotFound() {
        when(newsRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> newsService.getKeywords("MISSING"));
    }

    @Test
    void addKeyword_truncatesWordsLongerThan12Chars() {
        when(newsRepository.existsById("NW00001")).thenReturn(true);
        when(newsWordRepository.existsById(any())).thenReturn(false);
        when(newsWordRepository.findByWrdAppNo("NW00001")).thenReturn(List.of());

        newsService.addKeyword("NW00001", "كلمةطويلةجدااكثرمن12حرف");

        var captor = org.mockito.ArgumentCaptor.forClass(NewsWordEntity.class);
        verify(newsWordRepository).save(captor.capture());
        assertTrue(captor.getValue().getWrdWord().length() <= 12);
    }

    @Test
    void removeKeyword_nonExistent_throwsResourceNotFound() {
        when(newsWordRepository.existsById(any())).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> newsService.removeKeyword("NW00001", "غير موجود"));
    }

    @Test
    void removeKeyword_existing_deletes() {
        when(newsWordRepository.existsById(any())).thenReturn(true);

        newsService.removeKeyword("NW00001", "عنوان");

        verify(newsWordRepository).deleteById(any());
    }
}
