package com.startupstack.app.modules.sites.specification;

import com.startupstack.app.modules.sites.entity.FormEntity;
import com.startupstack.app.modules.sites.entity.PostEntity;
import com.startupstack.app.modules.sites.entity.SiteEntity;
import org.springframework.data.jpa.domain.Specification;

public final class SitesSpecification {

    private SitesSpecification() {
    }

    /** form/sites/posts tables have no entity column — always returns conjunction (no filter applied). */
    public static Specification<FormEntity> formBelongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<SiteEntity> siteBelongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<PostEntity> postBelongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<FormEntity> formNameContains(String name) {
        return (root, query, cb) ->
                name == null ? null : cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%");
    }

    public static Specification<FormEntity> formHasType(String type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("formType"), type);
    }

    public static Specification<SiteEntity> siteHasLevel(String level) {
        return (root, query, cb) ->
                level == null ? null : cb.equal(root.get("level"), level);
    }

    public static Specification<SiteEntity> siteHasStatus(String status) {
        return (root, query, cb) ->
                status == null ? null : cb.equal(root.get("status"), status);
    }

    public static Specification<SiteEntity> siteHasWilya(Integer wilyaNo) {
        return (root, query, cb) ->
                wilyaNo == null ? null : cb.equal(root.get("wilyaNo"), wilyaNo);
    }

    public static Specification<PostEntity> postHasFormNo(String formNo) {
        return (root, query, cb) ->
                formNo == null ? null : cb.equal(root.get("form").get("formNo"), formNo);
    }

    public static Specification<PostEntity> postHasWilya(Integer wilyaNo) {
        return (root, query, cb) ->
                wilyaNo == null ? null : cb.equal(root.get("wilyaNo"), wilyaNo);
    }
}
