package com.startupstack.app.modules.digitization.repository;

import com.startupstack.app.modules.digitization.entity.DigitEntity;
import com.startupstack.app.modules.digitization.entity.DigitId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface DigitRepository extends JpaRepository<DigitEntity, DigitId>,
                                         JpaSpecificationExecutor<DigitEntity> {
}
