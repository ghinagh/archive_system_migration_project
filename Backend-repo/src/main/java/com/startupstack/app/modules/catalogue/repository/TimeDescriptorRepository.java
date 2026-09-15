package com.startupstack.app.modules.catalogue.repository;

import com.startupstack.app.modules.catalogue.entity.TimeDescriptorEntity;
import com.startupstack.app.modules.catalogue.entity.TimeDescriptorId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TimeDescriptorRepository extends JpaRepository<TimeDescriptorEntity, TimeDescriptorId> {

    List<TimeDescriptorEntity> findByTmAppNo(String tmAppNo);

    @Modifying
    @Query("DELETE FROM TimeDescriptorEntity t WHERE t.tmAppNo = :appNo AND t.tmSerNo = :serNo AND t.tmRltvNo = :rltvNo")
    void deleteByCompositeKey(@Param("appNo") String appNo,
                              @Param("serNo") String serNo,
                              @Param("rltvNo") String rltvNo);

    /** Form2.frm's del_time1 — deletes every relation-numbered time mark for one ANALIS serial. */
    @Modifying
    @Query("DELETE FROM TimeDescriptorEntity t WHERE t.tmAppNo = :appNo AND t.tmSerNo = :serNo")
    void deleteByAppNoAndSerNo(@Param("appNo") String appNo, @Param("serNo") String serNo);
}
