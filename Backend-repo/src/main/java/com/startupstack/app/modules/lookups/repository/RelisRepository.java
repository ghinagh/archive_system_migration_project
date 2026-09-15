package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.RelisEntity;
import com.startupstack.app.modules.lookups.entity.RelisEntityId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RelisRepository extends JpaRepository<RelisEntity, RelisEntityId> {
}
