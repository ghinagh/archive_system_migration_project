package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.DictEntity;
import com.startupstack.app.modules.lookups.entity.DictEntityId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DictRepository extends JpaRepository<DictEntity, DictEntityId> {

    List<DictEntity> findBySubCode3(String subCode3);
}
