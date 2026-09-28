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
import jakarta.persistence.EntityManager;
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
    private final EntityManager entityManager;

    public ArticleService(ArticleRepository articleRepository,
                          CatalogueRepository catalogueRepository,
                          PeriodicalRepository periodicalRepository,
                          ArticleMapper articleMapper,
                          EntityManager entityManager) {
        this.articleRepository = articleRepository;
        this.catalogueRepository = catalogueRepository;
        this.periodicalRepository = periodicalRepository;
        this.articleMapper = articleMapper;
        this.entityManager = entityManager;
    }

    /**
     * ART_PER1 is a bare number with no association, so its display name ("مصدر الترجمة", PERIOD
     * PER_PER_NA) can't come from the mapper. Legacy reloads it by binding the DataCombo's
     * BoundText to art_per1 (Form6.frm:2690), which resolves the name from the same list.
     */
    private ArticleResponse withNames(ArticleEntity entity) {
        ArticleResponse response = articleMapper.toResponse(entity);
        if (entity.getPeriodical1() != null) {
            periodicalRepository.findById(entity.getPeriodical1())
                    .ifPresent(p -> response.setPeriodical1Name(p.getName()));
        }
        return response;
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
        return withNames(entity);
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
        return withNames(article);
    }

    /**
     * "سجل جديد" — Form6.frm Command2_Click (:3113) runs {@code op_article} then {@code max_article}
     * (DDL :7229, :6974): the next number is {@code 'ق' + (max(substring(mn_app_no,2,6)) + 1)}
     * left-padded to six digits, and the ARTICLE and main rows are inserted on the spot, which is
     * why every grid on the form is usable the moment the button is pressed.
     *
     * <p>Legacy reads then writes with no lock; a transaction-scoped advisory lock keeps two
     * operators from being handed the same number. Only numbers already in the {@code ق######}
     * format feed the maximum, so free-form numbers typed on other screens can't skew it.
     */
    @Transactional
    public ArticleResponse createNext() {
        entityManager.createNativeQuery("SELECT pg_advisory_xact_lock(hashtext('op_article'))").getResultList();
        Number max = (Number) entityManager.createNativeQuery(
                "SELECT COALESCE(MAX(CAST(SUBSTRING(\"MN_APP_NO\" FROM 2 FOR 6) AS INTEGER)), 0) "
                        + "FROM main WHERE \"MN_APP_NO\" ~ '^ق[0-9]{6}$'").getSingleResult();
        String appNo = "ق" + String.format("%06d", max.intValue() + 1);

        ArticleEntity article = new ArticleEntity();
        article.setAppNo(appNo);
        articleRepository.save(article);

        CatalogueEntity catalogue = new CatalogueEntity();
        catalogue.setAppNo(appNo);
        catalogue.setType("A");
        catalogue.setTrans(0);
        catalogueRepository.save(catalogue);

        article.setCatalogue(catalogue);
        return withNames(article);
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
        return withNames(article);
    }

    /**
     * Saves "استمارة التوثيق" the way Form6.frm does: {@code upd_main} + {@code upd_article2}
     * (DDL :10814, :10218) and nothing else. The generic {@link #update} runs a MapStruct update
     * that nulls every ARTICLE column the request doesn't carry — year, volume, country, serial,
     * film, type, choice, picture — which this form has no fields for, so saving here through it
     * would silently erase them from a record that was loaded from another screen or legacy data.
     *
     * <p>{@code upd_article2} writes a cleared source as 0, so an absent {@code periodicalNo} must
     * detach the periodical rather than leave the previous one in place.
     */
    @Transactional
    public ArticleResponse updateDocumentationForm(String appNo, ArticleRequest request) {
        ArticleEntity article = articleRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Article not found: " + appNo));
        CatalogueEntity catalogue = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));

        // upd_main
        catalogue.setActiveTitleAr(request.getActiveTitleAr());
        catalogue.setAdditionalTitle(request.getAdditionalCatalogueTitle());
        catalogue.setDataEntry(request.getDataEntry());
        catalogue.setAppDoc(request.getAppDoc());
        catalogue.setEntryDate(request.getEntryDate());
        catalogue.setResult(request.getResult());
        catalogue.setDocumentNature(request.getDocumentNature());
        catalogueRepository.save(catalogue);

        // upd_article2
        article.setPeriodical(request.getPeriodicalNo() == null ? null
                : periodicalRepository.findById(request.getPeriodicalNo())
                        .orElseThrow(() -> new ResourceNotFoundException(
                                "Periodical not found: " + request.getPeriodicalNo())));
        article.setPeriodical1(request.getPeriodical1());
        article.setSubjectType(request.getSubjectType());
        article.setDate(request.getDate());
        article.setDate1(request.getDate1());
        article.setPageNo(request.getPageNo());
        article.setArticleNo(request.getArticleNo());
        article.setLang1(request.getLang1());
        articleRepository.save(article);

        article.setCatalogue(catalogue);
        return withNames(article);
    }

    /** The child tables Form6.frm Command11_Click clears on cancel, in its order, with each one's key column. */
    private static final String[][] LEGACY_CANCEL_CHILDREN = {
            {"RES", "RES_APP_NO"},        // del_res      — جدول المسؤولية البيانية
            {"DIGIT", "DIG_NO"},          // del_digit1   — جدول الملفات الرقمية
            {"ANALIS", "AN_APP_NO"},      // del_analis2
            {"GEO", "GEO_APP_NO"},        // del_geo2
            {"RELATIVE", "REL_APP_NO"},   // del_rel2
            {"NAROWER", "NAR_APP_NO"},    // del_nar2
            {"FILE_ADD", "FAD_APP_NO"}    // del_fad2
    };

    /**
     * Cancel (الغاء), Form6.frm Command11_Click (:2853 onward): del_main, del_article, then every
     * child. All of those children carry a foreign key to main, so deleting only the parent — what
     * this did before — fails with a constraint violation for any record that has a single author
     * or digital-file row. Children first, then main, then ARTICLE (main references it).
     */
    @Transactional
    public void delete(String appNo) {
        if (!articleRepository.existsById(appNo)) {
            throw new ResourceNotFoundException("Article not found: " + appNo);
        }
        for (String[] child : LEGACY_CANCEL_CHILDREN) {
            entityManager.createNativeQuery(
                            "DELETE FROM \"" + child[0] + "\" WHERE \"" + child[1] + "\" = :appNo")
                    .setParameter("appNo", appNo)
                    .executeUpdate();
        }
        catalogueRepository.deleteById(appNo);
        catalogueRepository.flush();
        articleRepository.deleteById(appNo);
    }
}
