package com.startupstack.app.modules.news.mapper;

import com.startupstack.app.modules.news.dto.NewsRequest;
import com.startupstack.app.modules.news.dto.NewsResponse;
import com.startupstack.app.modules.news.entity.NewsEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface NewsMapper {

    @Mapping(target = "keywords", ignore = true)
    NewsResponse toResponse(NewsEntity entity);

    NewsEntity toEntity(NewsRequest request);

    @Mapping(target = "newsNo", ignore = true)
    void updateEntity(NewsRequest request, @MappingTarget NewsEntity entity);
}
