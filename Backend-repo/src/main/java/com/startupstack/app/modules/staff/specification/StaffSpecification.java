package com.startupstack.app.modules.staff.specification;

import com.startupstack.app.modules.staff.entity.Person1Entity;
import org.springframework.data.jpa.domain.Specification;

public final class StaffSpecification {

    private StaffSpecification() {}

    public static Specification<Person1Entity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("prsEnt"), userEnt);
    }

    public static Specification<Person1Entity> hasName(String name) {
        return (root, query, cb) ->
                name == null ? null : cb.like(cb.lower(root.get("prsName")), "%" + name.toLowerCase() + "%");
    }

    public static Specification<Person1Entity> hasEntity(String ent) {
        return (root, query, cb) ->
                ent == null ? null : cb.equal(root.get("prsEnt"), ent);
    }
}
