package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.CodingEntity;
import com.startupstack.app.modules.lookups.entity.CodingEntityId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface CodingRepository extends JpaRepository<CodingEntity, CodingEntityId>,
                                          JpaSpecificationExecutor<CodingEntity> {

    Optional<CodingEntity> findFirstBySubCode(String subCode);

    @Query("SELECT c FROM CodingEntity c WHERE c.subLeve = :level ORDER BY c.subDesc")
    List<CodingEntity> findBySubLeveOrderBySubDesc(@Param("level") String level);

    @Query("SELECT c FROM CodingEntity c WHERE c.subCode LIKE CONCAT(:codePrefix, '%') ORDER BY c.subDesc")
    List<CodingEntity> findBySubCodeStartingWithOrderBySubDesc(@Param("codePrefix") String codePrefix);
}
