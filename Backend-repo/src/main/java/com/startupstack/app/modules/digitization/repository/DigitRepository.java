package com.startupstack.app.modules.digitization.repository;

import com.startupstack.app.modules.digitization.entity.DigitEntity;
import com.startupstack.app.modules.digitization.entity.DigitId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface DigitRepository extends JpaRepository<DigitEntity, DigitId>,
                                         JpaSpecificationExecutor<DigitEntity> {

    /**
     * Legacy `upd_dig_choice` (user_inetrface.frm DataGrid1_KeyDown F9, :2601-2603) updates by
     * DIG_DIG_NO + DIG_TYP1 alone, not the real (DIG_NO, DIG_SER) primary key — reproduced
     * identically here rather than guessing a PK the stored proc itself never used.
     */
    List<DigitEntity> findByDigitNoAndType1(String digitNo, String type1);
}
