package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.MemEntity;
import com.startupstack.app.modules.lookups.entity.MemEntityId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemRepository extends JpaRepository<MemEntity, MemEntityId> {
}
