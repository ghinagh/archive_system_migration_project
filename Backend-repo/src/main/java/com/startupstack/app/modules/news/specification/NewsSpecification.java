package com.startupstack.app.modules.news.specification;

import com.startupstack.app.modules.news.entity.NewsEntity;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDateTime;

public final class NewsSpecification {

    private NewsSpecification() {
    }

    /** NEWS table has no entity column — always returns conjunction (no filter applied). */
    public static Specification<NewsEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    /** Restricts results to news whose newsDoc matches the JWT user_doc claim. No-op for admins (null/blank). */
    public static Specification<NewsEntity> hasDocumentType(String userDoc) {
        return (root, query, cb) ->
                (userDoc == null || userDoc.isBlank()) ? null : cb.equal(root.get("newsDoc"), userDoc);
    }

    public static Specification<NewsEntity> hasDocType(String docType) {
        return (root, query, cb) ->
                docType == null ? null : cb.equal(root.get("newsDoc"), docType);
    }

    public static Specification<NewsEntity> dateFrom(LocalDateTime from) {
        return (root, query, cb) ->
                from == null ? null : cb.greaterThanOrEqualTo(root.get("newsDte"), from);
    }

    public static Specification<NewsEntity> dateTo(LocalDateTime to) {
        return (root, query, cb) ->
                to == null ? null : cb.lessThanOrEqualTo(root.get("newsDte"), to);
    }

    public static Specification<NewsEntity> hasPublication(Double pub) {
        return (root, query, cb) ->
                pub == null ? null : cb.equal(root.get("newsPub"), pub);
    }

    public static Specification<NewsEntity> titleContains(String title) {
        return (root, query, cb) ->
                title == null ? null : cb.like(root.get("newsTit1"), "%" + title + "%");
    }
}
