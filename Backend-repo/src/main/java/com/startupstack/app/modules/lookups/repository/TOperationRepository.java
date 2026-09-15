package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.TOperationEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TOperationRepository extends JpaRepository<TOperationEntity, String> {
}
