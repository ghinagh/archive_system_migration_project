package com.startupstack.app.modules.pictures.specification;

import com.startupstack.app.modules.pictures.entity.PictureEntity;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDateTime;

public final class PictureSpecification {

    private PictureSpecification() {
    }

    /** Restricts results to pictures whose entity matches {@code userEnt} (PIC_ENT). No-op for admins (null). */
    public static Specification<PictureEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("picEnt"), userEnt);
    }

    public static Specification<PictureEntity> hasType(Double type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("picTyp"), type);
    }

    public static Specification<PictureEntity> hasEntity(String entity) {
        return (root, query, cb) ->
                entity == null ? null : cb.equal(root.get("picEnt"), entity);
    }

    public static Specification<PictureEntity> dateFrom(LocalDateTime from) {
        return (root, query, cb) ->
                from == null ? null : cb.greaterThanOrEqualTo(root.get("picDte"), from);
    }

    public static Specification<PictureEntity> dateTo(LocalDateTime to) {
        return (root, query, cb) ->
                to == null ? null : cb.lessThanOrEqualTo(root.get("picDte"), to);
    }

    public static Specification<PictureEntity> hasPerson(String person) {
        return (root, query, cb) ->
                person == null ? null : cb.equal(root.get("picPrs"), person);
    }
}
