package com.startupstack.app.modules.books.repository;

import com.startupstack.app.modules.books.entity.BookEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookRepository extends JpaRepository<BookEntity, String>,
                                        JpaSpecificationExecutor<BookEntity> {

    @Query("SELECT b FROM BookEntity b JOIN FETCH b.catalogue")
    List<BookEntity> findAllWithCatalogue();

    /** Renumbers the BOOK detail row's primary key via a bulk JPQL UPDATE (see CatalogueRepository#renumberAppNo). */
    @Modifying
    @Query("UPDATE BookEntity b SET b.appNo = :newAppNo WHERE b.appNo = :oldAppNo")
    int renumberAppNo(@Param("oldAppNo") String oldAppNo, @Param("newAppNo") String newAppNo);
}
