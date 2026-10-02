package com.startupstack.app.modules.retrieval.repository;

import com.startupstack.app.modules.retrieval.entity.RetrievalUserFieldEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RetrievalUserFieldRepository extends JpaRepository<RetrievalUserFieldEntity, java.util.UUID> {

    /** Legacy's "(user_out_choice = 1 or user_out_choice = 2)" filter is just "has a row" here. */
    List<RetrievalUserFieldEntity> findByUserNo(String userNo);

    Optional<RetrievalUserFieldEntity> findByUserNoAndFieldKey(String userNo, String fieldKey);
}
