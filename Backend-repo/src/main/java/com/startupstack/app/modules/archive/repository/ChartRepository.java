package com.startupstack.app.modules.archive.repository;

import com.startupstack.app.modules.archive.entity.ChartEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface ChartRepository extends JpaRepository<ChartEntity, Integer>,
                                         JpaSpecificationExecutor<ChartEntity> {

    Optional<ChartEntity> findByChaNo(String chaNo);

    boolean existsByChaNo(String chaNo);

    @Query(value = "SELECT COALESCE(MAX(CAST(\"CHA_NO\" AS INTEGER)), 0) FROM \"CHARIT\" FOR UPDATE", nativeQuery = true)
    int findMaxChaNoAsInteger();

    boolean existsByStock(Double stock);

    boolean existsByStockAndIdNot(Double stock, Integer id);
}
