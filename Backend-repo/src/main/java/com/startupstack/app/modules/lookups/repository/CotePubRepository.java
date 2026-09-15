package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.CotePubEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CotePubRepository extends JpaRepository<CotePubEntity, Double> {
}
