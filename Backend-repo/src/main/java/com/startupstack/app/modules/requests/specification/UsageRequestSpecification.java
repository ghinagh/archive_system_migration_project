package com.startupstack.app.modules.requests.specification;

import com.startupstack.app.modules.requests.entity.UsageRequestEntity;
import org.springframework.data.jpa.domain.Specification;

public final class UsageRequestSpecification {

    private UsageRequestSpecification() {
    }

    public static Specification<UsageRequestEntity> hasStatus(String status) {
        return (root, query, cb) ->
                status == null ? null : cb.equal(root.get("status"), status);
    }

    public static Specification<UsageRequestEntity> requesterContains(String requester) {
        return (root, query, cb) ->
                requester == null ? null : cb.like(cb.lower(root.get("requester")), "%" + requester.toLowerCase() + "%");
    }

    public static Specification<UsageRequestEntity> coteEquals(String cote) {
        return (root, query, cb) ->
                cote == null ? null : cb.equal(root.get("cote"), cote);
    }
}
