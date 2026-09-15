package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.entity.RelFormEntity;
import com.startupstack.app.modules.sites.entity.RelFormId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RelFormRepository extends JpaRepository<RelFormEntity, RelFormId> {

    List<RelFormEntity> findByRlfForm1(String rlfForm1);

    @Modifying
    @Query("DELETE FROM RelFormEntity r WHERE r.rlfForm1 = :form1 AND r.rlfForm2 = :form2")
    void deleteByRlfForm1AndRlfForm2(@Param("form1") String form1, @Param("form2") String form2);
}
