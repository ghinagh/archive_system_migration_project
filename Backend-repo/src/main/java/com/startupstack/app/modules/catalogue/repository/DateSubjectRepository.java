package com.startupstack.app.modules.catalogue.repository;

import com.startupstack.app.modules.catalogue.entity.DateSubjectEntity;
import com.startupstack.app.modules.catalogue.entity.DateSubjectId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DateSubjectRepository extends JpaRepository<DateSubjectEntity, DateSubjectId> {

    List<DateSubjectEntity> findByDteAppNo(String dteAppNo);

    @Modifying
    @Query("DELETE FROM DateSubjectEntity d WHERE d.dteAppNo = :appNo AND d.dteSerNo = :serNo AND d.dteRelNo = :relNo")
    void deleteByCompositeKey(@Param("appNo") String appNo, @Param("serNo") String serNo, @Param("relNo") String relNo);
}
