package com.startupstack.app.modules.lookups.specification;

import com.startupstack.app.modules.lookups.entity.ArraysEntity;
import com.startupstack.app.modules.lookups.entity.CodingEntity;
import com.startupstack.app.modules.lookups.entity.MacnzEntity;
import org.springframework.data.jpa.domain.Specification;

public final class LookupsSpecification {

    private LookupsSpecification() {
    }

    public static Specification<ArraysEntity> arraysHasType(String type) {
        return (root, query, cb) -> type == null ? null : cb.equal(root.get("arTyp"), type);
    }

    public static Specification<MacnzEntity> macnzHasLevel(String level) {
        return (root, query, cb) -> level == null ? null : cb.equal(root.get("subLevel"), level);
    }

    public static Specification<CodingEntity> codingHasLevel(String level) {
        return (root, query, cb) -> level == null ? null : cb.equal(root.get("subLeve"), level);
    }
}
