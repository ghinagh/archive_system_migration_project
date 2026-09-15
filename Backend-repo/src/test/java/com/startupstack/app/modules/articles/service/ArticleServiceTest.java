package com.startupstack.app.modules.articles.service;

import com.startupstack.app.modules.articles.dto.ArticleRequest;
import com.startupstack.app.modules.articles.dto.ArticleResponse;
import com.startupstack.app.modules.articles.entity.ArticleEntity;
import com.startupstack.app.modules.articles.mapper.ArticleMapper;
import com.startupstack.app.modules.articles.repository.ArticleRepository;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import com.startupstack.app.modules.periodicals.repository.PeriodicalRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ArticleServiceTest {

    @Mock
    private ArticleRepository articleRepository;
    @Mock
    private CatalogueRepository catalogueRepository;
    @Mock
    private PeriodicalRepository periodicalRepository;
    @Mock
    private ArticleMapper articleMapper;
    @InjectMocks
    private ArticleService articleService;

    @Test
    void create_savesParentCatalogueWithTypeA_andLinksPeriodical() {
        ArticleRequest request = new ArticleRequest();
        request.setAppNo("ART0001");
        request.setActiveTitleAr("مقال اختبار");
        request.setPeriodicalNo(5.0);

        ArticleEntity articleEntity = new ArticleEntity();
        articleEntity.setAppNo("ART0001");
        ArticleResponse response = new ArticleResponse();
        response.setAppNo("ART0001");

        PeriodicalEntity periodical = new PeriodicalEntity();
        periodical.setPerNo(5.0);

        when(catalogueRepository.save(any(CatalogueEntity.class))).thenAnswer(i -> i.getArgument(0));
        when(articleMapper.toEntity(request)).thenReturn(articleEntity);
        when(periodicalRepository.findById(5.0)).thenReturn(Optional.of(periodical));
        when(articleRepository.save(articleEntity)).thenReturn(articleEntity);
        when(articleMapper.toResponse(articleEntity)).thenReturn(response);

        articleService.create(request);

        ArgumentCaptor<CatalogueEntity> captor = ArgumentCaptor.forClass(CatalogueEntity.class);
        verify(catalogueRepository).save(captor.capture());
        assertEquals("A", captor.getValue().getType());
        verify(periodicalRepository).findById(5.0);
    }

    @Test
    void create_withInvalidPeriodical_throwsResourceNotFound() {
        ArticleRequest request = new ArticleRequest();
        request.setAppNo("ART0002");
        request.setPeriodicalNo(999.0);

        when(catalogueRepository.save(any())).thenAnswer(i -> i.getArgument(0));
        when(articleMapper.toEntity(request)).thenReturn(new ArticleEntity());
        when(periodicalRepository.findById(999.0)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> articleService.create(request));
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(articleRepository.findById("NONE")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> articleService.findById("NONE"));
    }
}
