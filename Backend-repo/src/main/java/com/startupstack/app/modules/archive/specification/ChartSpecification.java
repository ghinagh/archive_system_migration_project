package com.startupstack.app.modules.archive.specification;

import com.startupstack.app.modules.archive.entity.ChartEntity;
import org.springframework.data.jpa.domain.Specification;

public final class ChartSpecification {

    private ChartSpecification() {
    }

    /** Restricts results to charts whose source entity matches {@code userEnt} (CHA_SOURCE). No-op for admins (null). */
    public static Specification<ChartEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("source"), userEnt);
    }

    public static Specification<ChartEntity> titleContains(String title) {
        return (root, query, cb) ->
                title == null ? null : cb.like(cb.lower(root.get("title")), "%" + title.toLowerCase() + "%");
    }

    public static Specification<ChartEntity> hasSource(String source) {
        return (root, query, cb) ->
                source == null ? null : cb.equal(root.get("source"), source);
    }

    public static Specification<ChartEntity> hasType(Double type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("type"), type);
    }

    public static Specification<ChartEntity> hasSubjectCode(String subjectCode) {
        return (root, query, cb) ->
                subjectCode == null ? null : cb.equal(root.get("subjectCode"), subjectCode);
    }
}
