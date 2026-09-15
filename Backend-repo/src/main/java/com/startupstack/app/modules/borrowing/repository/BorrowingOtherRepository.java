package com.startupstack.app.modules.borrowing.repository;

import com.startupstack.app.modules.borrowing.entity.BorrowingOtherEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface BorrowingOtherRepository extends JpaRepository<BorrowingOtherEntity, String> {

    List<BorrowingOtherEntity> findByBorrowingNo(String borrowingNo);

    Optional<BorrowingOtherEntity> findByBorrowingNoAndSerial(String borrowingNo, Double serial);

    void deleteByBorrowingNoAndSerial(String borrowingNo, Double serial);

    boolean existsByBorrowingNoAndSerial(String borrowingNo, Double serial);

    @Query("SELECT COALESCE(MAX(o.serial), 0) FROM BorrowingOtherEntity o WHERE o.borrowingNo = :borrowingNo")
    Double findMaxSerialByBorrowingNo(@Param("borrowingNo") String borrowingNo);
}
