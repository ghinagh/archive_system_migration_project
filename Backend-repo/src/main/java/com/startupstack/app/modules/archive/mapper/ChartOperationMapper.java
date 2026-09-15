package com.startupstack.app.modules.archive.mapper;

import com.startupstack.app.modules.archive.dto.ChartOperationRequest;
import com.startupstack.app.modules.archive.dto.ChartOperationResponse;
import com.startupstack.app.modules.archive.entity.ChartOperationEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ChartOperationMapper {

    @Mapping(target = "chartNo", expression = "java(entity.getChart() != null ? entity.getChart().getChaNo() : entity.getChartNo())")
    ChartOperationResponse toResponse(ChartOperationEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "chart", ignore = true)
    @Mapping(target = "chartNo", ignore = true)
    ChartOperationEntity toEntity(ChartOperationRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "chart", ignore = true)
    @Mapping(target = "chartNo", ignore = true)
    void updateEntity(ChartOperationRequest request, @MappingTarget ChartOperationEntity entity);
}
