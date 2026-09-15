package com.startupstack.app.modules.news.repository;

import com.startupstack.app.modules.news.entity.NewsEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface NewsRepository extends JpaRepository<NewsEntity, String>,
                                        JpaSpecificationExecutor<NewsEntity> {

    @Query("SELECT n FROM NewsEntity n WHERE " +
           "LOWER(n.newsTit1) LIKE :q OR LOWER(n.newsTit2) LIKE :q")
    Page<NewsEntity> searchByTitle(@Param("q") String q, Pageable pageable);

    /** Renumbers the NEWS detail row's primary key via a bulk JPQL UPDATE (see CatalogueRepository#renumberAppNo). */
    @Modifying
    @Query("UPDATE NewsEntity n SET n.newsNo = :newAppNo WHERE n.newsNo = :oldAppNo")
    int renumberAppNo(@Param("oldAppNo") String oldAppNo, @Param("newAppNo") String newAppNo);
}
