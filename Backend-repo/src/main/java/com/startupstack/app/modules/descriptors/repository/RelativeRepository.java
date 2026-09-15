package com.startupstack.app.modules.descriptors.repository;

import com.startupstack.app.modules.descriptors.entity.RelativeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface RelativeRepository extends JpaRepository<RelativeEntity, Integer>,
                                            JpaSpecificationExecutor<RelativeEntity> {

    List<RelativeEntity> findByAppNo(String appNo);

    void deleteByAppNoAndSerialNo(String appNo, String serialNo);
}
