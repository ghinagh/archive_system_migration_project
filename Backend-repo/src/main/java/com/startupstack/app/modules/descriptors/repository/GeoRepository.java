package com.startupstack.app.modules.descriptors.repository;

import com.startupstack.app.modules.descriptors.entity.GeoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface GeoRepository extends JpaRepository<GeoEntity, Integer>,
                                       JpaSpecificationExecutor<GeoEntity> {

    List<GeoEntity> findByAppNo(String appNo);

    void deleteByAppNoAndSerialNo(String appNo, String serialNo);
}
