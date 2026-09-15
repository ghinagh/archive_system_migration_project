package com.startupstack.app.modules.admin.repository;

import com.startupstack.app.modules.admin.entity.TempSchemaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TempSchemaRepository extends JpaRepository<TempSchemaEntity, String> {
}
