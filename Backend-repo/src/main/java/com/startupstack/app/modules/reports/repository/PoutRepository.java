package com.startupstack.app.modules.reports.repository;

import com.startupstack.app.modules.reports.entity.PoutEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface PoutRepository extends JpaRepository<PoutEntity, Integer>,
                                        JpaSpecificationExecutor<PoutEntity> {
}
