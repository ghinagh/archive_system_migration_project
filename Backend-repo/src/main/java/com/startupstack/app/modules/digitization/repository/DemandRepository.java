package com.startupstack.app.modules.digitization.repository;

import com.startupstack.app.modules.digitization.entity.DemandEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

public interface DemandRepository extends JpaRepository<DemandEntity, Integer>,
                                          JpaSpecificationExecutor<DemandEntity> {

    @Query("SELECT MAX(d.serial) FROM DemandEntity d WHERE d.demandNo = :demandNo")
    Integer findMaxSerialForDemandNo(String demandNo);

    @Query(value = "SELECT COALESCE(MAX(CAST(dmd_no AS INTEGER)), 0) FROM demand WHERE dmd_no ~ '^[0-9]+$'",
            nativeQuery = true)
    Integer findMaxNumericDemandNo();
}
