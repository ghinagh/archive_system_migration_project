package com.startupstack.app.modules.requests.repository;

import com.startupstack.app.modules.requests.entity.UsageRequestEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.UUID;

public interface UsageRequestRepository extends JpaRepository<UsageRequestEntity, UUID>,
                                                 JpaSpecificationExecutor<UsageRequestEntity> {

    boolean existsByRequestNo(String requestNo);
}
