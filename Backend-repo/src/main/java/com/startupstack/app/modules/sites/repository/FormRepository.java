package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.entity.FormEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface FormRepository extends JpaRepository<FormEntity, String>,
                                        JpaSpecificationExecutor<FormEntity> {
}
