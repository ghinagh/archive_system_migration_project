package com.startupstack.app.modules.search.service;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.news.entity.NewsEntity;
import com.startupstack.app.modules.news.repository.NewsRepository;
import com.startupstack.app.modules.search.dto.SearchResultResponse;
import com.startupstack.app.shared.wordindex.WordEntity;
import com.startupstack.app.shared.wordindex.WordId;
import com.startupstack.app.shared.wordindex.WordRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SearchServiceTest {

    @Mock
    private WordRepository wordRepository;
    @Mock
    private CatalogueRepository catalogueRepository;
    @Mock
    private NewsRepository newsRepository;
    @InjectMocks
    private SearchService searchService;

    private WordEntity wordFor(String appNo, String wordType) {
        WordId id = new WordId();
        id.setSubCode6(appNo);
        id.setSubTyp6(wordType);
        WordEntity w = new WordEntity();
        w.setId(id);
        return w;
    }

    @Test
    void search_blankQuery_returnsEmptyList() {
        assertTrue(searchService.search("").isEmpty());
        assertTrue(searchService.search(null).isEmpty());
        assertTrue(searchService.search("a").isEmpty());
        verifyNoInteractions(wordRepository);
    }

    @Test
    void search_newsMatch_returnsNewsResult() {
        when(wordRepository.findByIdSubDesc6ContainingIgnoreCase("خبر"))
                .thenReturn(List.of(wordFor("NW00001", "N")));
        NewsEntity news = new NewsEntity();
        news.setNewsNo("NW00001");
        news.setNewsTit1("عنوان الخبر");
        when(newsRepository.findById("NW00001")).thenReturn(Optional.of(news));

        List<SearchResultResponse> results = searchService.search("خبر");

        assertEquals(1, results.size());
        assertEquals("News", results.get(0).typeBadge());
        assertEquals("/news/NW00001", results.get(0).route());
    }

    @Test
    void search_bookMatch_resolvesBookBadgeAndRoute() {
        when(wordRepository.findByIdSubDesc6ContainingIgnoreCase("كتاب"))
                .thenReturn(List.of(wordFor("MN000001", "B")));
        CatalogueEntity cat = new CatalogueEntity();
        cat.setAppNo("MN000001");
        cat.setActiveTitleAr("عنوان الكتاب");
        cat.setType("B");
        when(catalogueRepository.findById("MN000001")).thenReturn(Optional.of(cat));

        List<SearchResultResponse> results = searchService.search("كتاب");

        assertEquals(1, results.size());
        assertEquals("Book", results.get(0).typeBadge());
        assertEquals("/books/MN000001", results.get(0).route());
    }

    @Test
    void search_articleMatch_resolvesArticleBadgeAndRoute() {
        when(wordRepository.findByIdSubDesc6ContainingIgnoreCase("مقال"))
                .thenReturn(List.of(wordFor("MN000002", "T")));
        CatalogueEntity cat = new CatalogueEntity();
        cat.setAppNo("MN000002");
        cat.setActiveTitleAr("عنوان المقال");
        cat.setType("A");
        when(catalogueRepository.findById("MN000002")).thenReturn(Optional.of(cat));

        List<SearchResultResponse> results = searchService.search("مقال");

        assertEquals("Article", results.get(0).typeBadge());
        assertEquals("/articles/MN000002", results.get(0).route());
    }

    @Test
    void search_duplicateAppNoAcrossWords_dedupesToFirstSeenWordType() {
        WordEntity w1 = wordFor("MN000003", "T");
        WordEntity w2 = wordFor("MN000003", "B");
        when(wordRepository.findByIdSubDesc6ContainingIgnoreCase("عام"))
                .thenReturn(List.of(w1, w2));
        CatalogueEntity cat = new CatalogueEntity();
        cat.setAppNo("MN000003");
        cat.setActiveTitleAr("عنوان");
        cat.setType("P");
        when(catalogueRepository.findById("MN000003")).thenReturn(Optional.of(cat));

        List<SearchResultResponse> results = searchService.search("عام");

        assertEquals(1, results.size());
        assertEquals("Periodical", results.get(0).typeBadge());
    }

    @Test
    void search_appNoNotFoundInTargetTable_isSkipped() {
        when(wordRepository.findByIdSubDesc6ContainingIgnoreCase("مفقود"))
                .thenReturn(List.of(wordFor("MN999999", "T")));
        when(catalogueRepository.findById("MN999999")).thenReturn(Optional.empty());

        List<SearchResultResponse> results = searchService.search("مفقود");

        assertTrue(results.isEmpty());
    }
}
