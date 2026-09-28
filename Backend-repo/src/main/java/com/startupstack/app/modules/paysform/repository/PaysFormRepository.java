package com.startupstack.app.modules.paysform.repository;

import com.startupstack.app.modules.paysform.entity.PaysFormEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaysFormRepository extends JpaRepository<PaysFormEntity, String> {

    Page<PaysFormEntity> findByNameContainingIgnoreCase(String name, Pageable pageable);
}
