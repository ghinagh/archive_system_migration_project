package com.startupstack.app.modules.periodicals.repository;

import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

public interface PeriodicalRepository extends JpaRepository<PeriodicalEntity, Double>,
                                              JpaSpecificationExecutor<PeriodicalEntity> {

    List<PeriodicalEntity> findAllByOrderByNameAsc();

    Optional<PeriodicalEntity> findFirstByOrderByPerNoDesc();
}
