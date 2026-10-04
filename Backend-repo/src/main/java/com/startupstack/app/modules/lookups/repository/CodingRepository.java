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

    /** Legacy view_coding14: {@code SUBSTRING(sub_code,1,2) = '09' AND sub_leve = '2'}. */
    @Query("SELECT c FROM CodingEntity c WHERE c.subCode LIKE '09%' AND c.subLeve = '2' ORDER BY c.subCode")
    List<CodingEntity> findViewCoding14();
}
