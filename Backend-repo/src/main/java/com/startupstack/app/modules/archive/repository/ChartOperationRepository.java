package com.startupstack.app.modules.archive.repository;

import com.startupstack.app.modules.archive.entity.ChartOperationEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ChartOperationRepository extends JpaRepository<ChartOperationEntity, Integer>,
                                                  JpaSpecificationExecutor<ChartOperationEntity> {

    Page<ChartOperationEntity> findByChart_ChaNo(String chaNo, Pageable pageable);

    @Query(value = "SELECT COALESCE(MAX(\"OPR_SER\"), 0) FROM \"OPR_CHRT\" WHERE \"OPR_NO1\" = :chaNo",
           nativeQuery = true)
    double findMaxSerialByChaNo(@Param("chaNo") String chaNo);

    Optional<ChartOperationEntity> findFirstByChart_ChaNoAndSerialLessThanOrderBySerialDesc(
            String chaNo, Double serial);
}
