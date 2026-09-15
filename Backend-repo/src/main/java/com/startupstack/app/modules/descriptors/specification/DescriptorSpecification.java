package com.startupstack.app.modules.descriptors.specification;

import com.startupstack.app.modules.descriptors.entity.SubjectAnalysisEntity;
import org.springframework.data.jpa.domain.Specification;

public final class DescriptorSpecification {

    private DescriptorSpecification() {
    }

    public static Specification<SubjectAnalysisEntity> hasAppNo(String appNo) {
        return (root, query, cb) ->
                appNo == null ? null : cb.equal(root.get("appNo"), appNo);
    }

    public static Specification<SubjectAnalysisEntity> hasDescriptorNo(String descriptorNo) {
        return (root, query, cb) ->
                descriptorNo == null ? null : cb.equal(root.get("descriptorNo"), descriptorNo);
    }
}
