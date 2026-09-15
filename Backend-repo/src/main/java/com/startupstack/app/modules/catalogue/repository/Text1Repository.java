package com.startupstack.app.modules.catalogue.repository;

import com.startupstack.app.modules.catalogue.entity.Text1Entity;
import com.startupstack.app.modules.catalogue.entity.Text1Id;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface Text1Repository extends JpaRepository<Text1Entity, Text1Id> {

    List<Text1Entity> findByTxtNo(String txtNo);

    Optional<Text1Entity> findByTxtNoAndTxtSerNo(String txtNo, String txtSerNo);

    @Modifying
    @Query("DELETE FROM Text1Entity t WHERE t.txtNo = :txtNo AND t.txtSerNo = :serNo")
    void deleteByTxtNoAndTxtSerNo(@Param("txtNo") String txtNo, @Param("serNo") String serNo);
}
