package com.startupstack.app.modules.articles.specification;

import com.startupstack.app.modules.articles.entity.ArticleEntity;
import org.springframework.data.jpa.domain.Specification;

public final class ArticleSpecification {

    private ArticleSpecification() {
    }

    /** Restricts results to articles whose catalogue entry entity matches {@code userEnt}. No-op for admins (null). */
    public static Specification<ArticleEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("catalogue").get("dataEntry"), userEnt);
    }

    /** Restricts results to articles whose catalogue app-doc matches {@code userDoc}. No-op for admins (null/blank). */
    public static Specification<ArticleEntity> hasDocumentType(String userDoc) {
        return (root, query, cb) ->
                (userDoc == null || userDoc.isBlank()) ? null
                        : cb.equal(root.get("catalogue").get("appDoc"), userDoc);
    }

    public static Specification<ArticleEntity> hasPeriodical(Double periodicalNo) {
        return (root, query, cb) ->
                periodicalNo == null ? null : cb.equal(root.get("periodical").get("perNo"), periodicalNo);
    }

    public static Specification<ArticleEntity> hasYear(Double year) {
        return (root, query, cb) ->
                year == null ? null : cb.equal(root.get("year"), year);
    }

    public static Specification<ArticleEntity> hasLang(String lang) {
        return (root, query, cb) ->
                lang == null ? null : cb.equal(root.get("lang"), lang);
    }

    public static Specification<ArticleEntity> titleContains(String title) {
        return (root, query, cb) ->
                title == null ? null : cb.like(
                        cb.lower(root.get("catalogue").get("activeTitleAr")),
                        "%" + title.toLowerCase() + "%");
    }
}
