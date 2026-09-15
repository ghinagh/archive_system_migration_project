package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.Arrays1Entity;
import com.startupstack.app.modules.lookups.entity.Arrays1EntityId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface Arrays1Repository extends JpaRepository<Arrays1Entity, Arrays1EntityId> {

    List<Arrays1Entity> findByArTyp(String arTyp);
}
