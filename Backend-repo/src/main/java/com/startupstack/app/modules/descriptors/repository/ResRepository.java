package com.startupstack.app.modules.descriptors.repository;

import com.startupstack.app.modules.descriptors.entity.ResEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ResRepository extends JpaRepository<ResEntity, Integer>,
                                       JpaSpecificationExecutor<ResEntity> {

    List<ResEntity> findByAppNo(String appNo);

    @Query("SELECT r FROM ResEntity r LEFT JOIN FETCH r.author")
    List<ResEntity> findAllWithAuthor();
}
