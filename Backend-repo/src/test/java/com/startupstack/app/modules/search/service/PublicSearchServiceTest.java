package com.startupstack.app.modules.search.service;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.news.entity.NewsEntity;
import com.startupstack.app.modules.news.repository.NewsRepository;
import com.startupstack.app.modules.search.dto.PublicSearchResult;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class PublicSearchServiceTest {

    @Mock
    private CatalogueRepository catalogueRepository;
    @Mock
    private NewsRepository newsRepository;
    @InjectMocks
    private PublicSearchService publicSearchService;

    @Test
    void search_typeNews_searchesNewsOnly() {
        NewsEntity news = new NewsEntity();
        news.setNewsNo("NW00001");
        news.setNewsTit1("عنوان الخبر");
        Pageable pageable = PageRequest.of(0, 10);
        when(newsRepository.searchByTitle(eq("%خبر%"), eq(pageable)))
                .thenReturn(new PageImpl<>(List.of(news)));

        Page<PublicSearchResult> result = publicSearchService.search("خبر", "news", pageable);

        assertEquals(1, result.getTotalElements());
        assertEquals("news", result.getContent().get(0).type());
        verifyNoInteractions(catalogueRepository);
    }

    @Test
    void search_typeBook_searchesCatalogueWithBookType() {
        CatalogueEntity cat = new CatalogueEntity();
        cat.setAppNo("MN000001");
        cat.setActiveTitleAr("كتاب");
        cat.setType("B");
        Pageable pageable = PageRequest.of(0, 10);
        when(catalogueRepository.searchByTitleAndType(eq("%كتاب%"), eq("B"), eq(pageable)))
                .thenReturn(new PageImpl<>(List.of(cat)));

        Page<PublicSearchResult> result = publicSearchService.search("كتاب", "book", pageable);

        assertEquals("book", result.getContent().get(0).type());
    }

    @Test
    void search_typeArticle_searchesCatalogueWithArticleType() {
        CatalogueEntity cat = new CatalogueEntity();
        cat.setAppNo("MN000002");
        cat.setActiveTitleAr("مقال");
        cat.setType("A");
        Pageable pageable = PageRequest.of(0, 10);
        when(catalogueRepository.searchByTitleAndType(eq("%مقال%"), eq("A"), eq(pageable)))
                .thenReturn(new PageImpl<>(List.of(cat)));

        Page<PublicSearchResult> result = publicSearchService.search("مقال", "article", pageable);

        assertEquals("article", result.getContent().get(0).type());
    }

    @Test
    void search_typeAll_splitsQuotaBetweenCatalogueAndNews() {
        CatalogueEntity cat = new CatalogueEntity();
        cat.setAppNo("MN000003");
        cat.setActiveTitleAr("نتيجة كتالوج");
        cat.setType("P");
        NewsEntity news = new NewsEntity();
        news.setNewsNo("NW00002");
        news.setNewsTit1("نتيجة خبر");
        Pageable pageable = PageRequest.of(0, 10);

        when(catalogueRepository.searchByTitle(eq("%عام%"), any(Pageable.class)))
                .thenReturn(new PageImpl<>(List.of(cat)));
        when(newsRepository.searchByTitle(eq("%عام%"), any(Pageable.class)))
                .thenReturn(new PageImpl<>(List.of(news)));

        Page<PublicSearchResult> result = publicSearchService.search("عام", "all", pageable);

        assertEquals(2, result.getTotalElements());
        assertEquals(2, result.getContent().size());
    }

    @Test
    void search_catalogueTypeDefaultsToCatalogueBadge_whenTypeBlank() {
        CatalogueEntity cat = new CatalogueEntity();
        cat.setAppNo("MN000004");
        cat.setActiveTitleAr("سجل عام");
        cat.setType("");
        Pageable pageable = PageRequest.of(0, 10);
        when(catalogueRepository.searchByTitleAndType(eq("%سجل%"), eq("B"), eq(pageable)))
                .thenReturn(new PageImpl<>(List.of(cat)));

        Page<PublicSearchResult> result = publicSearchService.search("سجل", "book", pageable);

        assertEquals("catalogue", result.getContent().get(0).type());
    }
}
