package com.startupstack.app.modules.periodicals.specification;

import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import org.springframework.data.jpa.domain.Specification;

public final class PeriodicalSpecification {

    private PeriodicalSpecification() {
    }

    /** PERIOD table has no entity column — always returns conjunction (no filter applied). */
    public static Specification<PeriodicalEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<PeriodicalEntity> hasLang(String lang) {
        return (root, query, cb) ->
                lang == null ? null : cb.equal(root.get("lang"), lang);
    }

    public static Specification<PeriodicalEntity> nameContains(String name) {
        return (root, query, cb) ->
                name == null ? null : cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%");
    }
}
