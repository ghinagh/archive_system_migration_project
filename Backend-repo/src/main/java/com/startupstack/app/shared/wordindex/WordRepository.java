package com.startupstack.app.shared.wordindex;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface WordRepository extends JpaRepository<WordEntity, WordId> {

    List<WordEntity> findByIdSubDesc6ContainingIgnoreCase(String term);

    @Modifying
    @Query("DELETE FROM WordEntity w WHERE w.id.subCode6 = :appNo AND w.id.subTyp6 = :wordType")
    void deleteByAppNoAndWordType(@Param("appNo") String appNo, @Param("wordType") String wordType);
}
