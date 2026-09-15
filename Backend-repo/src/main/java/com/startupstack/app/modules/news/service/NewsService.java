package com.startupstack.app.modules.news.service;

import com.startupstack.app.modules.news.dto.NewsRequest;
import com.startupstack.app.modules.news.dto.NewsResponse;
import com.startupstack.app.modules.news.entity.NewsEntity;
import com.startupstack.app.modules.news.entity.NewsWordEntity;
import com.startupstack.app.modules.news.entity.NewsWordEntityId;
import com.startupstack.app.modules.news.mapper.NewsMapper;
import com.startupstack.app.modules.news.repository.NewsRepository;
import com.startupstack.app.modules.news.repository.NewsWordRepository;
import com.startupstack.app.modules.news.specification.NewsSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.specification.GenericSpecificationBuilder;
import com.startupstack.app.shared.specification.SearchCondition;
import com.startupstack.app.shared.specification.SearchField;
import com.startupstack.app.shared.util.SecurityUtils;
import com.startupstack.app.shared.wordindex.WordIndexService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
public class NewsService {

    private final NewsRepository newsRepository;
    private final NewsWordRepository newsWordRepository;
    private final NewsMapper newsMapper;
    private final WordIndexService wordIndexService;

    public NewsService(NewsRepository newsRepository,
                       NewsWordRepository newsWordRepository,
                       NewsMapper newsMapper,
                       WordIndexService wordIndexService) {
        this.newsRepository = newsRepository;
        this.newsWordRepository = newsWordRepository;
        this.newsMapper = newsMapper;
        this.wordIndexService = wordIndexService;
    }

    @Transactional(readOnly = true)
    public Page<NewsResponse> findAll(String docType,
                                      LocalDateTime dateFrom,
                                      LocalDateTime dateTo,
                                      Double publication,
                                      String title,
                                      Pageable pageable) {
        boolean isAdmin = SecurityUtils.isAdmin();
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        String userDoc = isAdmin ? null : SecurityUtils.getCurrentUserDoc();
        Specification<NewsEntity> spec =
                NewsSpecification.hasDocumentType(userDoc)
                        .and(NewsSpecification.belongsToUserEntity(userEnt))
                        .and(NewsSpecification.hasDocType(docType))
                        .and(NewsSpecification.dateFrom(dateFrom))
                        .and(NewsSpecification.dateTo(dateTo))
                        .and(NewsSpecification.hasPublication(publication))
                        .and(NewsSpecification.titleContains(title));
        return newsRepository.findAll(spec, pageable).map(this::toResponseWithKeywords);
    }

    /**
     * Fields a client may filter on via {@code POST /api/news/search} — the same flat
     * AND/OR "cumulative questions" model as the legacy sort_from.frm builder.
     */
    private static final Map<String, SearchField> ADVANCED_SEARCH_FIELDS = Map.of(
            "title", new SearchField("newsTit1", SearchField.FieldType.STRING),
            "additionalTitle", new SearchField("newsTit2", SearchField.FieldType.STRING),
            "docType", new SearchField("newsDoc", SearchField.FieldType.STRING),
            "date", new SearchField("newsDte", SearchField.FieldType.DATE),
            "publication", new SearchField("newsPub", SearchField.FieldType.NUMBER));

    @Transactional(readOnly = true)
    public Page<NewsResponse> advancedSearch(List<SearchCondition> conditions, Pageable pageable) {
        boolean isAdmin = SecurityUtils.isAdmin();
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        String userDoc = isAdmin ? null : SecurityUtils.getCurrentUserDoc();
        Specification<NewsEntity> scope =
                NewsSpecification.hasDocumentType(userDoc)
                        .and(NewsSpecification.belongsToUserEntity(userEnt));
        Specification<NewsEntity> spec =
                scope.and(GenericSpecificationBuilder.build(conditions, ADVANCED_SEARCH_FIELDS));
        return newsRepository.findAll(spec, pageable).map(this::toResponseWithKeywords);
    }

    @Transactional(readOnly = true)
    public NewsResponse findById(String newsNo) {
        NewsEntity entity = newsRepository.findById(newsNo)
                .orElseThrow(() -> new ResourceNotFoundException("News record not found: " + newsNo));
        return toResponseWithKeywords(entity);
    }

    @Transactional
    public NewsResponse create(NewsRequest request) {
        NewsEntity entity = newsMapper.toEntity(request);
        NewsEntity saved = newsRepository.save(entity);
        tokenizeAndSaveKeywords(saved.getNewsNo(), request.getNewsTit1());
        wordIndexService.indexText(saved.getNewsNo(), saved.getNewsTit1(), "N");
        return toResponseWithKeywords(saved);
    }

    @Transactional
    public NewsResponse update(String newsNo, NewsRequest request) {
        NewsEntity entity = newsRepository.findById(newsNo)
                .orElseThrow(() -> new ResourceNotFoundException("News record not found: " + newsNo));
        newsMapper.updateEntity(request, entity);
        NewsEntity saved = newsRepository.save(entity);
        newsWordRepository.deleteByWrdAppNo(newsNo);
        tokenizeAndSaveKeywords(newsNo, request.getNewsTit1());
        return toResponseWithKeywords(saved);
    }

    @Transactional
    public void delete(String newsNo) {
        if (!newsRepository.existsById(newsNo)) {
            throw new ResourceNotFoundException("News record not found: " + newsNo);
        }
        newsWordRepository.deleteByWrdAppNo(newsNo);
        newsRepository.deleteById(newsNo);
    }

    @Transactional(readOnly = true)
    public List<String> getKeywords(String newsNo) {
        if (!newsRepository.existsById(newsNo)) {
            throw new ResourceNotFoundException("News record not found: " + newsNo);
        }
        return newsWordRepository.findByWrdAppNo(newsNo).stream()
                .map(NewsWordEntity::getWrdWord)
                .toList();
    }

    @Transactional
    public List<String> addKeyword(String newsNo, String word) {
        if (!newsRepository.existsById(newsNo)) {
            throw new ResourceNotFoundException("News record not found: " + newsNo);
        }
        String trimmed = word.trim();
        if (trimmed.length() > 12) {
            trimmed = trimmed.substring(0, 12);
        }
        NewsWordEntityId id = new NewsWordEntityId();
        id.setWrdAppNo(newsNo);
        id.setWrdWord(trimmed);
        if (!newsWordRepository.existsById(id)) {
            NewsWordEntity entity = new NewsWordEntity();
            entity.setWrdAppNo(newsNo);
            entity.setWrdWord(trimmed);
            newsWordRepository.save(entity);
        }
        return getKeywords(newsNo);
    }

    @Transactional
    public void removeKeyword(String newsNo, String word) {
        NewsWordEntityId id = new NewsWordEntityId();
        id.setWrdAppNo(newsNo);
        id.setWrdWord(word);
        if (!newsWordRepository.existsById(id)) {
            throw new ResourceNotFoundException("Keyword not found: " + word);
        }
        newsWordRepository.deleteById(id);
    }

    private void tokenizeAndSaveKeywords(String newsNo, String title) {
        if (title == null || title.isBlank()) {
            return;
        }
        String[] words = title.trim().split("\\s+");
        for (String word : words) {
            String trimmed = word.trim();
            if (trimmed.isEmpty()) {
                continue;
            }
            if (trimmed.length() > 12) {
                trimmed = trimmed.substring(0, 12);
            }
            NewsWordEntityId id = new NewsWordEntityId();
            id.setWrdAppNo(newsNo);
            id.setWrdWord(trimmed);
            if (!newsWordRepository.existsById(id)) {
                NewsWordEntity entity = new NewsWordEntity();
                entity.setWrdAppNo(newsNo);
                entity.setWrdWord(trimmed);
                newsWordRepository.save(entity);
            }
        }
    }

    private NewsResponse toResponseWithKeywords(NewsEntity entity) {
        NewsResponse response = newsMapper.toResponse(entity);
        List<String> keywords = newsWordRepository.findByWrdAppNo(entity.getNewsNo()).stream()
                .map(NewsWordEntity::getWrdWord)
                .toList();
        response.setKeywords(keywords);
        return response;
    }
}
