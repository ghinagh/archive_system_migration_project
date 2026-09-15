package com.startupstack.app.modules.descriptors.repository;

import com.startupstack.app.modules.descriptors.entity.SubjectAnalysisEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface SubjectAnalysisRepository extends JpaRepository<SubjectAnalysisEntity, Integer>,
                                                   JpaSpecificationExecutor<SubjectAnalysisEntity> {

    List<SubjectAnalysisEntity> findByAppNo(String appNo);

    void deleteByAppNoAndId(String appNo, Integer id);
}
