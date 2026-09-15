package com.startupstack.app.modules.books.specification;

import com.startupstack.app.modules.books.entity.BookEntity;
import org.springframework.data.jpa.domain.Specification;

public final class BookSpecification {

    private BookSpecification() {
    }

    /** Restricts results to books whose catalogue entry entity matches {@code userEnt}. No-op for admins (null). */
    public static Specification<BookEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("catalogue").get("dataEntry"), userEnt);
    }

    /** Restricts results to books whose catalogue app-doc matches {@code userDoc}. No-op for admins (null/blank). */
    public static Specification<BookEntity> hasDocumentType(String userDoc) {
        return (root, query, cb) ->
                (userDoc == null || userDoc.isBlank()) ? null
                        : cb.equal(root.get("catalogue").get("appDoc"), userDoc);
    }

    public static Specification<BookEntity> hasLang(String lang) {
        return (root, query, cb) ->
                lang == null ? null : cb.equal(root.get("lang"), lang);
    }

    public static Specification<BookEntity> hasPublisher(Double publisher) {
        return (root, query, cb) ->
                publisher == null ? null : cb.equal(root.get("publisher"), publisher);
    }

    public static Specification<BookEntity> hasStatus(String status) {
        return (root, query, cb) ->
                status == null ? null : cb.equal(root.get("status"), status);
    }

    public static Specification<BookEntity> titleContains(String title) {
        return (root, query, cb) ->
                title == null ? null : cb.like(
                        cb.lower(root.get("catalogue").get("activeTitleAr")),
                        "%" + title.toLowerCase() + "%");
    }
}
