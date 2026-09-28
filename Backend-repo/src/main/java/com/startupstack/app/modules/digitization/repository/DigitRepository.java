package com.startupstack.app.modules.digitization.repository;

import com.startupstack.app.modules.digitization.entity.DigitEntity;
import com.startupstack.app.modules.digitization.entity.DigitId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DigitRepository extends JpaRepository<DigitEntity, DigitId>,
                                         JpaSpecificationExecutor<DigitEntity> {

    /**
     * Legacy `upd_dig_choice` (user_inetrface.frm DataGrid1_KeyDown F9, :2601-2603) updates by
     * DIG_DIG_NO + DIG_TYP1 alone, not the real (DIG_NO, DIG_SER) primary key — reproduced
     * identically here rather than guessing a PK the stored proc itself never used.
     */
    List<DigitEntity> findByDigitNoAndType1(String digitNo, String type1);

    /** True when any class already uses this DIG_DIG_NO — the migrated schema makes it globally unique. */
    boolean existsByDigitNo(String digitNo);

    /**
     * Legacy {@code max_digit}/{@code op_digit} (DDL :7018-7020, :7332-7343) scope the next
     * DIG_DIG_NO to rows sharing the same DIG_TYP1 — each class (scan/waves/photo/private) has
     * its own numbering sequence. Mirrors {@code DemandRepository.findMaxNumericDemandNo}'s
     * pattern for the same reason: DIG_DIG_NO is a fixed-width zero-padded numeric string, so a
     * numeric MAX is what legacy's string MAX actually achieves.
     */
    @Query(value = "SELECT COALESCE(MAX(CAST(\"DIG_DIG_NO\" AS INTEGER)), 0) FROM \"DIGIT\" "
            + "WHERE \"DIG_TYP1\" = :type1 AND \"DIG_DIG_NO\" ~ '^[0-9]+$'",
            nativeQuery = true)
    Integer findMaxNumericDigitNoByType1(@Param("type1") String type1);
}
