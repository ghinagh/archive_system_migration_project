package com.startupstack.app.modules.articles.service;

import com.startupstack.app.modules.articles.dto.ArticleRequest;
import com.startupstack.app.modules.articles.dto.ArticleResponse;
import com.startupstack.app.modules.articles.entity.ArticleEntity;
import com.startupstack.app.modules.articles.mapper.ArticleMapper;
import com.startupstack.app.modules.articles.repository.ArticleRepository;
import com.startupstack.app.modules.articles.specification.ArticleSpecification;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import com.startupstack.app.modules.periodicals.repository.PeriodicalRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ArticleService {

    private final ArticleRepository articleRepository;
    private final CatalogueRepository catalogueRepository;
    private final PeriodicalRepository periodicalRepository;
    private final ArticleMapper articleMapper;

    public ArticleService(ArticleRepository articleRepository,
                          CatalogueRepository catalogueRepository,
                          PeriodicalRepository periodicalRepository,
                          ArticleMapper articleMapper) {
        this.articleRepository = articleRepository;
        this.catalogueRepository = catalogueRepository;
        this.periodicalRepository = periodicalRepository;
        this.articleMapper = articleMapper;
    }

    @Transactional(readOnly = true)
    public Page<ArticleResponse> findAll(Double periodicalNo, String title, Double year,
                                         String lang, Pageable pageable) {
        boolean isAdmin = SecurityUtils.isAdmin();
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        String userDoc = isAdmin ? null : SecurityUtils.getCurrentUserDoc();
        Specification<ArticleEntity> spec =
                ArticleSpecification.hasDocumentType(userDoc)
                        .and(ArticleSpecification.belongsToUserEntity(userEnt))
                        .and(ArticleSpecification.hasPeriodical(periodicalNo))
                        .and(ArticleSpecification.titleContains(title))
                        .and(ArticleSpecification.hasYear(year))
                        .and(ArticleSpecification.hasLang(lang));
        return articleRepository.findAll(spec, pageable).map(articleMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public ArticleResponse findById(String appNo) {
        ArticleEntity entity = articleRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Article not found: " + appNo));
        return articleMapper.toResponse(entity);
    }

    @Transactional
    public ArticleResponse create(ArticleRequest request) {
        // "main" carries a FK to ARTICLE (MN_APP_NO -> ART_APP_NO), so the ARTICLE row must be
        // inserted first or the subsequent insert into "main" trips the FK constraint.
        ArticleEntity article = articleMapper.toEntity(request);
        article.setAppNo(request.getAppNo());

        if (request.getPeriodicalNo() != null) {
            PeriodicalEntity periodical = periodicalRepository.findById(request.getPeriodicalNo())
                    .orElseThrow(() -> new ResourceNotFoundException(
                            "Periodical not found: " + request.getPeriodicalNo()));
            article.setPeriodical(periodical);
        }

        articleRepository.save(article);

        CatalogueEntity catalogue = new CatalogueEntity();
        catalogue.setAppNo(request.getAppNo());
        catalogue.setActiveTitleAr(request.getActiveTitleAr());
        catalogue.setAdditionalTitle(request.getAdditionalCatalogueTitle());
        catalogue.setDataEntry(request.getDataEntry());
        catalogue.setAppDoc(request.getAppDoc());
        catalogue.setEntryDate(request.getEntryDate());
        catalogue.setResult(request.getResult());
        catalogue.setDocumentNature(request.getDocumentNature());
        catalogue.setType("A");
        catalogueRepository.save(catalogue);

        article.setCatalogue(catalogue);
        return articleMapper.toResponse(article);
    }

    @Transactional
    public ArticleResponse update(String appNo, ArticleRequest request) {
        ArticleEntity article = articleRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Article not found: " + appNo));

        CatalogueEntity catalogue = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));
        catalogue.setActiveTitleAr(request.getActiveTitleAr());
        catalogue.setAdditionalTitle(request.getAdditionalCatalogueTitle());
        catalogue.setDataEntry(request.getDataEntry());
        catalogue.setAppDoc(request.getAppDoc());
        catalogue.setEntryDate(request.getEntryDate());
        catalogue.setResult(request.getResult());
        catalogue.setDocumentNature(request.getDocumentNature());
        catalogueRepository.save(catalogue);

        articleMapper.updateEntity(request, article);

        if (request.getPeriodicalNo() != null) {
            PeriodicalEntity periodical = periodicalRepository.findById(request.getPeriodicalNo())
                    .orElseThrow(() -> new ResourceNotFoundException(
                            "Periodical not found: " + request.getPeriodicalNo()));
            article.setPeriodical(periodical);
        }

        articleRepository.save(article);
        article.setCatalogue(catalogue);
        return articleMapper.toResponse(article);
    }

    @Transactional
    public void delete(String appNo) {
        if (!articleRepository.existsById(appNo)) {
            throw new ResourceNotFoundException("Article not found: " + appNo);
        }
        articleRepository.deleteById(appNo);
        catalogueRepository.deleteById(appNo);
    }
}
