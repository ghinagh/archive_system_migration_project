package com.startupstack.app.modules.videoorders.repository;

import com.startupstack.app.modules.videoorders.entity.VideoOrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.UUID;

public interface VideoOrderRepository extends JpaRepository<VideoOrderEntity, UUID>,
                                               JpaSpecificationExecutor<VideoOrderEntity> {

    boolean existsByOrderNo(String orderNo);
}
