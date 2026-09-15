package com.startupstack.app.modules.users.specification;

import com.startupstack.app.modules.users.entity.UserEntity;
import org.springframework.data.jpa.domain.Specification;

public final class UserSpecification {

    private UserSpecification() {
    }

    public static Specification<UserEntity> hasUserLevel(String level) {
        return (root, query, cb) -> level == null ? null : cb.equal(root.get("userLevel"), level);
    }

    public static Specification<UserEntity> hasUserEnt(String ent) {
        return (root, query, cb) -> ent == null ? null : cb.equal(root.get("userEnt"), ent);
    }
}
