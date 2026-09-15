package com.startupstack.app.modules.digitization.repository;

import com.startupstack.app.modules.digitization.entity.ResultEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

public interface ResultRepository extends JpaRepository<ResultEntity, Integer>,
                                          JpaSpecificationExecutor<ResultEntity> {

    @Query("SELECT MAX(r.serial) FROM ResultEntity r WHERE r.resultNo = :resultNo")
    Integer findMaxSerialForResultNo(String resultNo);

    @Query(value = "SELECT COALESCE(MAX(CAST(res_no AS INTEGER)), 0) FROM result WHERE res_no ~ '^[0-9]+$'",
            nativeQuery = true)
    Integer findMaxNumericResultNo();
}
