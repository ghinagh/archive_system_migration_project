package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.entity.FormEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface FormRepository extends JpaRepository<FormEntity, String>,
                                        JpaSpecificationExecutor<FormEntity> {

    /**
     * Legacy serh_sub_name: WHERE sub_typ = substring(@code,1,2) AND sub_no = substring(@code,3,8).
     * SUB_NO alone is not unique across name types (a person 01 and an institution 03 can share it),
     * so this reads the name directly instead of going through the SUB_NO-keyed entity.
     */
    @Query(value = "SELECT \"SUB_NAME\" FROM form WHERE \"SUB_TYP\" = :type AND \"SUB_NO\" = :number LIMIT 1",
           nativeQuery = true)
    Optional<String> findNameByTypeAndNumber(@Param("type") String type, @Param("number") String number);

    /** One name row read without the SUB_NO-keyed entity (SUB_NO repeats across name types). */
    interface NameRow {
        String getFormType();
        String getFormNo();
        String getName();
    }

    /**
     * serh_allform (prefix: substring(sub_name,1,len) = desc) / serh_wrdform (word: sub_name like
     * '%desc%'), ordered by sub_name. The pattern is built by the caller.
     */
    @Query(value = "SELECT \"SUB_TYP\" AS formType, \"SUB_NO\" AS formNo, \"SUB_NAME\" AS name FROM form "
            + "WHERE \"SUB_NAME\" ILIKE :pattern AND (CAST(:type AS varchar) IS NULL OR \"SUB_TYP\" = CAST(:type AS varchar)) "
            + "ORDER BY \"SUB_NAME\", \"SUB_TYP\", \"SUB_NO\"",
           countQuery = "SELECT count(*) FROM form WHERE \"SUB_NAME\" ILIKE :pattern "
            + "AND (CAST(:type AS varchar) IS NULL OR \"SUB_TYP\" = CAST(:type AS varchar))",
           nativeQuery = true)
    Page<NameRow> searchNames(@Param("pattern") String pattern, @Param("type") String type, Pageable pageable);
}
