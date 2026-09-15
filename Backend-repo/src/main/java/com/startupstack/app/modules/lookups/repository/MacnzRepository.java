package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.MacnzEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MacnzRepository extends JpaRepository<MacnzEntity, String>,
                                         JpaSpecificationExecutor<MacnzEntity> {
}
