package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.dto.SiteWithFormView;
import com.startupstack.app.modules.sites.dto.SiteWithNameView;
import com.startupstack.app.modules.sites.entity.SiteEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SiteRepository extends JpaRepository<SiteEntity, String>,
                                        JpaSpecificationExecutor<SiteEntity> {

    /**
     * Replaces view_site1: sites with their linked form name.
     * Uses the declared @ManyToOne(form) association for the JOIN.
     */
    @Query("""
            SELECT s.siteNo      AS siteNo,
                   s.description AS description,
                   s.levelNo     AS levelNo,
                   s.level       AS level,
                   s.process     AS process,
                   s.docNo       AS docNo,
                   s.startDate   AS startDate,
                   s.endDate     AS endDate,
                   s.free        AS free,
                   s.type        AS type,
                   s.wilyaNo     AS wilyaNo,
                   s.status      AS status,
                   s.user        AS user,
                   s.permission  AS permission,
                   s.accessLevel AS accessLevel,
                   s.kind        AS kind,
                   f.name        AS formName
            FROM SiteEntity s
            LEFT JOIN s.form f
            WHERE (:level IS NULL OR s.level = :level)
              AND (:status IS NULL OR s.status = :status)
              AND (:wilyaNo IS NULL OR s.wilyaNo = :wilyaNo)
            """)
    Page<SiteWithNameView> findAllWithNames(
            @Param("level") String level,
            @Param("status") String status,
            @Param("wilyaNo") Integer wilyaNo,
            Pageable pageable);

    /**
     * Replaces view_siteform: sites joined (inner) to their form, surfacing full form details.
     * Only returns sites that have a linked form record.
     */
    @Query("""
            SELECT s.siteNo      AS siteNo,
                   s.description AS description,
                   s.levelNo     AS levelNo,
                   s.level       AS level,
                   s.process     AS process,
                   s.docNo       AS docNo,
                   s.startDate   AS startDate,
                   s.endDate     AS endDate,
                   s.free        AS free,
                   s.type        AS type,
                   s.wilyaNo     AS wilyaNo,
                   s.status      AS status,
                   s.user        AS user,
                   s.permission  AS permission,
                   s.accessLevel AS accessLevel,
                   s.kind        AS kind,
                   f.name        AS formName,
                   f.formType    AS formType,
                   f.printName   AS formPrintName
            FROM SiteEntity s
            JOIN s.form f
            WHERE (:level IS NULL OR s.level = :level)
              AND (:status IS NULL OR s.status = :status)
              AND (:wilyaNo IS NULL OR s.wilyaNo = :wilyaNo)
            """)
    Page<SiteWithFormView> findAllWithFormInfo(
            @Param("level") String level,
            @Param("status") String status,
            @Param("wilyaNo") Integer wilyaNo,
            Pageable pageable);
}
