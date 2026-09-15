package com.startupstack.app.modules.archive.mapper;

import com.startupstack.app.modules.archive.dto.ChartRequest;
import com.startupstack.app.modules.archive.dto.ChartResponse;
import com.startupstack.app.modules.archive.entity.ChartEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ChartMapper {

    ChartResponse toResponse(ChartEntity entity);

    @Mapping(target = "id", ignore = true)
    ChartEntity toEntity(ChartRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "chaNo", ignore = true)
    void updateEntity(ChartRequest request, @MappingTarget ChartEntity entity);
}
