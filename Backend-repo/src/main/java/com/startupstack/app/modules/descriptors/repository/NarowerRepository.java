package com.startupstack.app.modules.descriptors.repository;

import com.startupstack.app.modules.descriptors.entity.NarowerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface NarowerRepository extends JpaRepository<NarowerEntity, Integer>,
                                           JpaSpecificationExecutor<NarowerEntity> {

    List<NarowerEntity> findByAppNo(String appNo);

    void deleteByAppNoAndSerialNo(String appNo, String serialNo);
}
