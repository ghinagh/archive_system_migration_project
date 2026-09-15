package com.startupstack.app.modules.catalogue.specification;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.sites.entity.SiteEntity;
import jakarta.persistence.criteria.JoinType;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDateTime;

public final class CatalogueSpecification {

    private CatalogueSpecification() {
    }

    /** Restricts results to records whose data-entry entity matches {@code userEnt}. No-op for admins (null). */
    public static Specification<CatalogueEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("dataEntry"), userEnt);
    }

    /** Restricts results to records whose app-doc matches {@code userDoc}. No-op for admins (null/blank). */
    public static Specification<CatalogueEntity> hasDocumentType(String userDoc) {
        return (root, query, cb) ->
                (userDoc == null || userDoc.isBlank()) ? null : cb.equal(root.get("appDoc"), userDoc);
    }

    public static Specification<CatalogueEntity> hasType(String type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("type"), type);
    }

    public static Specification<CatalogueEntity> entryDateFrom(LocalDateTime from) {
        return (root, query, cb) ->
                from == null ? null : cb.greaterThanOrEqualTo(root.get("entryDate"), from);
    }

    public static Specification<CatalogueEntity> entryDateTo(LocalDateTime to) {
        return (root, query, cb) ->
                to == null ? null : cb.lessThanOrEqualTo(root.get("entryDate"), to);
    }

    /**
     * Restricts results to catalogue records whose data-entry site belongs to the given wilaya.
     * Joins main → sites via MN_DATA_EN = sit_no, then filters on sit_wly_no.
     * Returns null (no predicate) when wilayaNo is null — admins pass null to bypass this filter.
     */
    public static Specification<CatalogueEntity> hasWilaya(Integer wilayaNo) {
        return (root, query, cb) -> {
            if (wilayaNo == null) return null;
            var siteJoin = root.<CatalogueEntity, SiteEntity>join("site", JoinType.LEFT);
            return cb.equal(siteJoin.get("wilyaNo"), wilayaNo);
        };
    }
}
