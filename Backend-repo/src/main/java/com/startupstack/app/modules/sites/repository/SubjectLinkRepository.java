package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.entity.SubjectLinkEntity;
import com.startupstack.app.modules.sites.entity.SubjectLinkId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SubjectLinkRepository extends JpaRepository<SubjectLinkEntity, SubjectLinkId> {

    List<SubjectLinkEntity> findBySubForm(String subForm);

    @Modifying
    @Query("DELETE FROM SubjectLinkEntity s WHERE s.subForm = :subForm AND s.subMcnz = :subMcnz")
    void deleteBySubFormAndSubMcnz(@Param("subForm") String subForm, @Param("subMcnz") String subMcnz);
}
