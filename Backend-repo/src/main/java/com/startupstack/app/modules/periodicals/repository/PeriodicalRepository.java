package com.startupstack.app.modules.periodicals.repository;

import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

public interface PeriodicalRepository extends JpaRepository<PeriodicalEntity, Double>,
                                              JpaSpecificationExecutor<PeriodicalEntity> {

    List<PeriodicalEntity> findAllByOrderByNameAsc();

    Optional<PeriodicalEntity> findFirstByOrderByPerNoDesc();

    /**
     * Legacy PERIOD has no key and real data repeats PER_PER_NO (e.g. 1148 twice, one row with an
     * empty name), so findById fails with "Duplicate row". Legacy DataCombos simply showed a matching
     * row; take the one that has a name.
     */
    @Query(value = "SELECT * FROM \"PERIOD\" WHERE \"PER_PER_NO\" = :perNo "
            + "ORDER BY (COALESCE(TRIM(\"PER_PER_NA\"), '') = ''), ctid LIMIT 1", nativeQuery = true)
    Optional<PeriodicalEntity> findFirstByNumber(@Param("perNo") Double perNo);
}
