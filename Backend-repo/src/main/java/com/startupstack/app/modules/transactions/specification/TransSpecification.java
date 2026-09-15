package com.startupstack.app.modules.transactions.specification;

import com.startupstack.app.modules.transactions.entity.TransEntity;
import org.springframework.data.jpa.domain.Specification;

public final class TransSpecification {

    private TransSpecification() {
    }

    /** TRANS table has no entity column — always returns conjunction (no filter applied). */
    public static Specification<TransEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<TransEntity> hasPeriodical(Double periodicalId) {
        return (root, query, cb) ->
                periodicalId == null ? null : cb.equal(root.get("trsNo"), periodicalId);
    }

    public static Specification<TransEntity> hasYear(Double year) {
        return (root, query, cb) ->
                year == null ? null : cb.equal(root.get("trsYear"), year);
    }
}
