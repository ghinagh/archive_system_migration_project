package com.startupstack.app.modules.catalogue.repository;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CatalogueRepository extends JpaRepository<CatalogueEntity, String>,
                                             JpaSpecificationExecutor<CatalogueEntity> {

    @Query("SELECT c FROM CatalogueEntity c WHERE " +
           "LOWER(c.activeTitleAr) LIKE :q OR LOWER(c.additionalTitle) LIKE :q")
    Page<CatalogueEntity> searchByTitle(@Param("q") String q, Pageable pageable);

    @Query("SELECT c FROM CatalogueEntity c WHERE " +
           "(LOWER(c.activeTitleAr) LIKE :q OR LOWER(c.additionalTitle) LIKE :q) " +
           "AND c.type = :type")
    Page<CatalogueEntity> searchByTitleAndType(@Param("q") String q,
                                               @Param("type") String type,
                                               Pageable pageable);

    /** Records with the transfer flag set — locked against update/delete until an admin unlocks them. */
    Page<CatalogueEntity> findByTrans(Integer trans, Pageable pageable);

    /**
     * Renumbers the catalogue record's primary key in place via a bulk JPQL UPDATE.
     * A bulk update bypasses the persistence context entirely (no entity is loaded
     * or dirty-checked), so it safely rewrites the {@code @Id} column without the
     * "insert a duplicate row" pitfall that mutating a managed entity's id would cause.
     */
    @Modifying
    @Query("UPDATE CatalogueEntity c SET c.appNo = :newAppNo WHERE c.appNo = :oldAppNo")
    int renumberAppNo(@Param("oldAppNo") String oldAppNo, @Param("newAppNo") String newAppNo);
}
