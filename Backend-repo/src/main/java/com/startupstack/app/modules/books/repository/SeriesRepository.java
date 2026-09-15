package com.startupstack.app.modules.books.repository;

import com.startupstack.app.modules.books.entity.SeriesEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SeriesRepository extends JpaRepository<SeriesEntity, String> {
}
