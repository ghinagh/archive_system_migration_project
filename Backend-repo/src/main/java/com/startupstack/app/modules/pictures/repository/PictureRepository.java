package com.startupstack.app.modules.pictures.repository;

import com.startupstack.app.modules.pictures.entity.PictureEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface PictureRepository extends JpaRepository<PictureEntity, String>,
                                           JpaSpecificationExecutor<PictureEntity> {
}
