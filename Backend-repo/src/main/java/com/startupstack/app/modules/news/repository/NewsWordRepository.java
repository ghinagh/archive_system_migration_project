package com.startupstack.app.modules.news.repository;

import com.startupstack.app.modules.news.entity.NewsWordEntity;
import com.startupstack.app.modules.news.entity.NewsWordEntityId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NewsWordRepository extends JpaRepository<NewsWordEntity, NewsWordEntityId> {

    List<NewsWordEntity> findByWrdAppNo(String wrdAppNo);

    void deleteByWrdAppNo(String wrdAppNo);
}
