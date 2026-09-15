package com.startupstack.app.modules.search.service;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.news.entity.NewsEntity;
import com.startupstack.app.modules.news.repository.NewsRepository;
import com.startupstack.app.modules.search.dto.PublicSearchResult;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class PublicSearchService {

    private final CatalogueRepository catalogueRepository;
    private final NewsRepository newsRepository;

    public PublicSearchService(CatalogueRepository catalogueRepository, NewsRepository newsRepository) {
        this.catalogueRepository = catalogueRepository;
        this.newsRepository = newsRepository;
    }

    @Transactional(readOnly = true)
    public Page<PublicSearchResult> search(String query, String type, Pageable pageable) {
        String q = "%" + (query != null ? query.trim() : "") + "%";

        if ("news".equalsIgnoreCase(type)) {
            return newsRepository.searchByTitle(q, pageable).map(this::fromNews);
        }

        if ("book".equalsIgnoreCase(type)) {
            return catalogueRepository.searchByTitleAndType(q, "B", pageable).map(this::fromCatalogue);
        }

        if ("article".equalsIgnoreCase(type)) {
            return catalogueRepository.searchByTitleAndType(q, "A", pageable).map(this::fromCatalogue);
        }

        // "all": split the page quota between catalogue (books+articles) and news
        int size = pageable.getPageSize();
        int catSize = Math.max(1, size / 2);
        int newsSize = size - catSize;

        Pageable catPageable  = PageRequest.of(pageable.getPageNumber(), catSize);
        Pageable newsPageable = PageRequest.of(pageable.getPageNumber(), newsSize);

        Page<CatalogueEntity> catPage  = catalogueRepository.searchByTitle(q, catPageable);
        Page<NewsEntity>      newsPage = newsRepository.searchByTitle(q, newsPageable);

        List<PublicSearchResult> combined = new ArrayList<>();
        catPage.getContent().stream().map(this::fromCatalogue).forEach(combined::add);
        newsPage.getContent().stream().map(this::fromNews).forEach(combined::add);

        long total = catPage.getTotalElements() + newsPage.getTotalElements();
        return new PageImpl<>(combined, pageable, total);
    }

    private PublicSearchResult fromCatalogue(CatalogueEntity c) {
        String rawType = c.getType() != null ? c.getType().trim() : "";
        String type = switch (rawType) {
            case "B" -> "book";
            case "A" -> "article";
            default  -> rawType.isEmpty() ? "catalogue" : rawType;
        };
        return new PublicSearchResult(
                c.getAppNo() != null ? c.getAppNo().trim() : null,
                c.getActiveTitleAr(),
                c.getAdditionalTitle(),
                type,
                c.getEntryDate()
        );
    }

    private PublicSearchResult fromNews(NewsEntity n) {
        return new PublicSearchResult(
                n.getNewsNo() != null ? n.getNewsNo().trim() : null,
                n.getNewsTit1(),
                n.getNewsTit2(),
                "news",
                n.getNewsDte()
        );
    }
}
