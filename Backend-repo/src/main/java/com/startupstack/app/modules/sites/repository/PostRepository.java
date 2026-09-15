package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.dto.PostWithSiteView;
import com.startupstack.app.modules.sites.entity.PostEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PostRepository extends JpaRepository<PostEntity, String>,
                                        JpaSpecificationExecutor<PostEntity> {

    List<PostEntity> findByFormNo(String formNo);

    /**
     * Replaces view_posts: joins posts with sites to surface site description.
     * Uses Hibernate 6 ad-hoc join (no declared @ManyToOne between posts and sites).
     */
    @Query("""
            SELECT p.serial      AS serial,
                   p.formNo      AS formNo,
                   p.siteNo      AS siteNo,
                   p.docNo       AS docNo,
                   p.startDate   AS startDate,
                   p.endDate     AS endDate,
                   p.wilyaNo     AS wilyaNo,
                   p.status      AS status,
                   p.levelNo     AS levelNo,
                   p.type        AS type,
                   p.user        AS user,
                   p.permission  AS permission,
                   p.level       AS postLevel,
                   s.description AS siteDescription,
                   s.level       AS siteLevel
            FROM PostEntity p
            LEFT JOIN SiteEntity s ON TRIM(p.siteNo) = TRIM(s.siteNo)
            WHERE (:formNo IS NULL OR p.formNo = :formNo)
              AND (:wilyaNo IS NULL OR p.wilyaNo = :wilyaNo)
            """)
    Page<PostWithSiteView> findAllWithSiteInfo(
            @Param("formNo") String formNo,
            @Param("wilyaNo") Integer wilyaNo,
            Pageable pageable);
}
