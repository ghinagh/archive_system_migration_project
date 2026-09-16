package com.startupstack.app.modules.digitization.repository;

import com.startupstack.app.modules.digitization.entity.ResultEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ResultRepository extends JpaRepository<ResultEntity, Integer>,
                                          JpaSpecificationExecutor<ResultEntity> {

    @Query("SELECT MAX(r.serial) FROM ResultEntity r WHERE r.resultNo = :resultNo")
    Integer findMaxSerialForResultNo(String resultNo);

    /** legacy upd_result1/del_result key on res_no (not the unique id) — a single request
     *  number can have several serial rows, and both procs act on all of them at once. */
    List<ResultEntity> findByResultNo(String resultNo);

    @Query(value = "SELECT COALESCE(MAX(CAST(res_no AS INTEGER)), 0) FROM result WHERE res_no ~ '^[0-9]+$'",
            nativeQuery = true)
    Integer findMaxNumericResultNo();
}
