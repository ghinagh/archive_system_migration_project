package com.startupstack.app.modules.borrowing.repository;

import com.startupstack.app.modules.borrowing.entity.BorrowingBookEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface BorrowingBookRepository extends JpaRepository<BorrowingBookEntity, String> {

    List<BorrowingBookEntity> findByBorrowingNo(String borrowingNo);

    Optional<BorrowingBookEntity> findByBorrowingNoAndSerial(String borrowingNo, Double serial);

    void deleteByBorrowingNoAndSerial(String borrowingNo, Double serial);

    boolean existsByBorrowingNoAndSerial(String borrowingNo, Double serial);

    @Query("SELECT COALESCE(MAX(b.serial), 0) FROM BorrowingBookEntity b WHERE b.borrowingNo = :borrowingNo")
    Double findMaxSerialByBorrowingNo(@Param("borrowingNo") String borrowingNo);
}
