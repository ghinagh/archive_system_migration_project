package com.startupstack.app.modules.authors.specification;

import com.startupstack.app.modules.authors.entity.AuthorEntity;
import org.springframework.data.jpa.domain.Specification;

public final class AuthorSpecification {

    private AuthorSpecification() {
    }

    /** AUTHER table has no entity column — always returns conjunction (no filter applied). */
    public static Specification<AuthorEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<AuthorEntity> nameContains(String name) {
        return (root, query, cb) -> {
            if (name == null || name.isEmpty()) {
                return null;
            }
            // If name is just "%", return all records (no filter)
            if ("%".equals(name)) {
                return cb.conjunction();
            }
            // Otherwise, do a LIKE search with wildcards
            return cb.like(cb.lower(root.get("autName")), "%" + name.toLowerCase() + "%");
        };
    }

    public static Specification<AuthorEntity> hasType(String type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("autType"), type);
    }
}
