package com.startupstack.app.modules.catalogue.repository;

import com.startupstack.app.modules.catalogue.entity.AbbreviationEntity;
import com.startupstack.app.modules.catalogue.entity.AbbreviationId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AbbreviationRepository extends JpaRepository<AbbreviationEntity, AbbreviationId> {

    List<AbbreviationEntity> findByRelAppNo(String relAppNo);

    @Modifying
    @Query("DELETE FROM AbbreviationEntity a WHERE a.relAppNo = :appNo AND a.relSerNo = :serNo AND a.relRltvN = :rltvN")
    void deleteByCompositeKey(@Param("appNo") String appNo,
                              @Param("serNo") String serNo,
                              @Param("rltvN") String rltvN);
}
