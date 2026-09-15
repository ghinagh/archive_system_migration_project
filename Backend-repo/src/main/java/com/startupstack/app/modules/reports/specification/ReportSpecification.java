package com.startupstack.app.modules.reports.specification;

import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import com.startupstack.app.modules.reports.entity.UserOutputEntity;
import org.springframework.data.jpa.domain.Specification;

public final class ReportSpecification {

    private ReportSpecification() {
    }

    /** bnkout/user_bnkout tables have no entity column — always returns conjunction (no filter applied). */
    public static Specification<ReportTemplateEntity> templateBelongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<UserOutputEntity> outputBelongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<ReportTemplateEntity> hasType(String type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("type"), type);
    }

    public static Specification<ReportTemplateEntity> hasCategory(String category) {
        return (root, query, cb) ->
                category == null ? null : cb.equal(root.get("category"), category);
    }

    public static Specification<ReportTemplateEntity> nameContains(String name) {
        return (root, query, cb) ->
                name == null ? null : cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%");
    }

    public static Specification<UserOutputEntity> userOutputHasUser(String userNo) {
        return (root, query, cb) ->
                userNo == null ? null : cb.equal(root.get("userNo"), userNo);
    }

    public static Specification<UserOutputEntity> userOutputHasInstitution(String institutionNo) {
        return (root, query, cb) ->
                institutionNo == null ? null : cb.equal(root.get("institutionNo"), institutionNo);
    }
}
