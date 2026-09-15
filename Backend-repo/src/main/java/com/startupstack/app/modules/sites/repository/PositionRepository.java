package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.entity.PositionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PositionRepository extends JpaRepository<PositionEntity, String>,
                                            JpaSpecificationExecutor<PositionEntity> {

    /**
     * Positions attached to one form code — the migrated form of legacy {@code proc_pos}.
     *
     * <p>POS_NO is {@code char(10)} in the legacy schema and is compared against a code built
     * as {@code SUB_TYP || SUB_NO}, so trailing padding must be trimmed on both sides for the
     * comparison to hold.
     */
    @Query("SELECT p FROM PositionEntity p WHERE TRIM(p.posNo) = TRIM(:formCode) ORDER BY p.name")
    List<PositionEntity> findByFormCode(@Param("formCode") String formCode);
}
