package com.startupstack.app.modules.books.mapper;

import com.startupstack.app.modules.books.dto.BookRequest;
import com.startupstack.app.modules.books.dto.BookResponse;
import com.startupstack.app.modules.books.dto.SeriesRequest;
import com.startupstack.app.modules.books.dto.SeriesResponse;
import com.startupstack.app.modules.books.entity.BookEntity;
import com.startupstack.app.modules.books.entity.SeriesEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface BookMapper {

    @Mapping(target = "catalogueTitle", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getActiveTitleAr() : null)")
    @Mapping(target = "authors", ignore = true)
    @Mapping(target = "subjects", ignore = true)
    @Mapping(target = "series", ignore = true)
    BookResponse toResponse(BookEntity entity);

    @Mapping(target = "catalogue", ignore = true)
    BookEntity toEntity(BookRequest request);

    @Mapping(target = "appNo", ignore = true)
    @Mapping(target = "catalogue", ignore = true)
    void updateEntity(BookRequest request, @MappingTarget BookEntity entity);

    SeriesResponse toSeriesResponse(SeriesEntity entity);

    @Mapping(target = "appNo", ignore = true)
    SeriesEntity toSeriesEntity(SeriesRequest request);

    @Mapping(target = "appNo", ignore = true)
    void updateSeriesEntity(SeriesRequest request, @MappingTarget SeriesEntity entity);
}
