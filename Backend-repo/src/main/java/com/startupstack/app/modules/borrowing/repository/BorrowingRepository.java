package com.startupstack.app.modules.borrowing.repository;

import com.startupstack.app.modules.borrowing.entity.BorrowingEntity;
import com.startupstack.app.modules.borrowing.entity.BorrowingId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface BorrowingRepository extends JpaRepository<BorrowingEntity, BorrowingId>,
                                             JpaSpecificationExecutor<BorrowingEntity> {

    boolean existsByIarNo(String iarNo);
}
