package com.startupstack.app.modules.corrections.repository;

import com.startupstack.app.modules.corrections.entity.CorrectionLogEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface CorrectionLogRepository extends JpaRepository<CorrectionLogEntity, UUID> {

    List<CorrectionLogEntity> findByAppNoOrderByCorrectedAtDesc(String appNo);

    /**
     * Renumbers historical correction-log entries so they keep pointing at the
     * catalogue record after it is renumbered (see CatalogueRepository#renumberAppNo).
     */
    @Modifying
    @Query("UPDATE CorrectionLogEntity c SET c.appNo = :newAppNo WHERE c.appNo = :oldAppNo")
    int renumberAppNo(@Param("oldAppNo") String oldAppNo, @Param("newAppNo") String newAppNo);
}
