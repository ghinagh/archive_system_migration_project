package com.startupstack.app.modules.search.service;

import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.news.repository.NewsRepository;
import com.startupstack.app.modules.search.dto.SearchResultResponse;
import com.startupstack.app.shared.wordindex.WordEntity;
import com.startupstack.app.shared.wordindex.WordRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class SearchService {

    private final WordRepository wordRepository;
    private final CatalogueRepository catalogueRepository;
    private final NewsRepository newsRepository;

    public SearchService(WordRepository wordRepository,
                         CatalogueRepository catalogueRepository,
                         NewsRepository newsRepository) {
        this.wordRepository = wordRepository;
        this.catalogueRepository = catalogueRepository;
        this.newsRepository = newsRepository;
    }

    @Transactional(readOnly = true)
    public List<SearchResultResponse> search(String query) {
        if (query == null || query.isBlank() || query.length() < 2) return List.of();

        List<WordEntity> matches = wordRepository.findByIdSubDesc6ContainingIgnoreCase(query.trim());

        // First-seen wordType wins per appNo to avoid duplicates from multiple matching words
        Map<String, String> appNoToWordType = new LinkedHashMap<>();
        for (WordEntity w : matches) {
            appNoToWordType.putIfAbsent(w.getId().getSubCode6(), w.getId().getSubTyp6());
        }

        List<SearchResultResponse> results = new ArrayList<>();
        for (Map.Entry<String, String> entry : appNoToWordType.entrySet()) {
            String appNo    = entry.getKey();
            String wordType = entry.getValue();

            if ("N".equals(wordType)) {
                newsRepository.findById(appNo).ifPresent(news ->
                        results.add(new SearchResultResponse(
                                news.getNewsNo(),
                                news.getNewsTit1(),
                                "News",
                                "/news/" + news.getNewsNo())));
            } else {
                catalogueRepository.findById(appNo).ifPresent(cat ->
                        results.add(new SearchResultResponse(
                                cat.getAppNo(),
                                cat.getActiveTitleAr(),
                                resolveBadge(cat.getType(), wordType),
                                resolveRoute(cat.getType(), wordType, cat.getAppNo()))));
            }
        }
        return results;
    }

    private String resolveBadge(String catalogueType, String wordType) {
        if ("B".equals(wordType) || "B".equals(catalogueType)) return "Book";
        if ("A".equals(catalogueType)) return "Article";
        if ("P".equals(catalogueType)) return "Periodical";
        return "Catalogue";
    }

    private String resolveRoute(String catalogueType, String wordType, String appNo) {
        if ("B".equals(wordType) || "B".equals(catalogueType)) return "/books/" + appNo;
        if ("A".equals(catalogueType)) return "/articles/" + appNo;
        if ("P".equals(catalogueType)) return "/periodicals/" + appNo;
        return "/catalogue/" + appNo;
    }
}
