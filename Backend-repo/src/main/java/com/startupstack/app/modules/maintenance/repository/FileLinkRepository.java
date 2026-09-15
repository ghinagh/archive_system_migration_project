package com.startupstack.app.modules.maintenance.repository;

import com.startupstack.app.modules.maintenance.entity.FileLinkEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface FileLinkRepository extends JpaRepository<FileLinkEntity, UUID> {

    List<FileLinkEntity> findByAppNo(String appNo);
}
