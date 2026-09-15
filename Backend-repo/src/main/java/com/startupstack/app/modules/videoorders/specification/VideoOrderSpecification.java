package com.startupstack.app.modules.videoorders.specification;

import com.startupstack.app.modules.videoorders.entity.VideoOrderEntity;
import org.springframework.data.jpa.domain.Specification;

public final class VideoOrderSpecification {

    private VideoOrderSpecification() {
    }

    public static Specification<VideoOrderEntity> hasStatus(String status) {
        return (root, query, cb) ->
                status == null ? null : cb.equal(root.get("status"), status);
    }

    public static Specification<VideoOrderEntity> stockNoEquals(String stockNo) {
        return (root, query, cb) ->
                stockNo == null ? null : cb.equal(root.get("stockNo"), stockNo);
    }

    public static Specification<VideoOrderEntity> requestedByEquals(String requestedBy) {
        return (root, query, cb) ->
                requestedBy == null ? null : cb.equal(root.get("requestedBy"), requestedBy);
    }
}
