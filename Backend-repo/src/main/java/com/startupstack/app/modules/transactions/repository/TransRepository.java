package com.startupstack.app.modules.transactions.repository;

import com.startupstack.app.modules.transactions.entity.TransEntity;
import com.startupstack.app.modules.transactions.entity.TransEntityId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface TransRepository extends JpaRepository<TransEntity, TransEntityId>,
                                         JpaSpecificationExecutor<TransEntity> {

    Page<TransEntity> findByTrsNo(Double trsNo, Pageable pageable);
}
