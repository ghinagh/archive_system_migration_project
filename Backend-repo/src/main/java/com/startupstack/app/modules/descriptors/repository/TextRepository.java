package com.startupstack.app.modules.descriptors.repository;

import com.startupstack.app.modules.descriptors.entity.TextEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface TextRepository extends JpaRepository<TextEntity, String>,
                                        JpaSpecificationExecutor<TextEntity> {

    List<TextEntity> findByAppNo(String appNo);
}
