package com.startupstack.app.modules.persons.specification;

import com.startupstack.app.modules.persons.entity.PersonEntity;
import org.springframework.data.jpa.domain.Specification;

public final class PersonSpecification {

    private PersonSpecification() {
    }

    /** Restricts results to persons whose entity matches {@code userEnt} (PRS_ENT). No-op for admins (null). */
    public static Specification<PersonEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("prsEnt"), userEnt);
    }

    public static Specification<PersonEntity> hasName(String name) {
        return (root, query, cb) ->
                name == null ? null : cb.like(cb.lower(root.get("prsName")), "%" + name.toLowerCase() + "%");
    }

    public static Specification<PersonEntity> hasEntity(String ent) {
        return (root, query, cb) ->
                ent == null ? null : cb.equal(root.get("prsEnt"), ent);
    }
}
