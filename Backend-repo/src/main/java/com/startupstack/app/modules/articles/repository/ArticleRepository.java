package com.startupstack.app.modules.articles.repository;

import com.startupstack.app.modules.articles.entity.ArticleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ArticleRepository extends JpaRepository<ArticleEntity, String>,
                                           JpaSpecificationExecutor<ArticleEntity> {

    /** Renumbers the ARTICLE detail row's primary key via a bulk JPQL UPDATE (see CatalogueRepository#renumberAppNo). */
    @Modifying
    @Query("UPDATE ArticleEntity a SET a.appNo = :newAppNo WHERE a.appNo = :oldAppNo")
    int renumberAppNo(@Param("oldAppNo") String oldAppNo, @Param("newAppNo") String newAppNo);
}
