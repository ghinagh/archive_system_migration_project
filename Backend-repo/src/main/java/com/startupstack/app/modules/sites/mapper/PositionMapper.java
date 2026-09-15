package com.startupstack.app.modules.sites.mapper;

import com.startupstack.app.modules.sites.dto.PositionRequest;
import com.startupstack.app.modules.sites.dto.PositionResponse;
import com.startupstack.app.modules.sites.entity.PositionEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface PositionMapper {

    PositionResponse toResponse(PositionEntity entity);

    @Mapping(target = "posNo", source = "posNo")
    @Mapping(target = "name", source = "name")
    @Mapping(target = "recordDate", source = "recordDate")
    PositionEntity toEntity(PositionRequest request);

    @Mapping(target = "posNo", ignore = true)
    void updateEntity(PositionRequest request, @MappingTarget PositionEntity entity);
}
