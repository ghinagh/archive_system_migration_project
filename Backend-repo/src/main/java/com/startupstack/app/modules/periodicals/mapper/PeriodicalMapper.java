package com.startupstack.app.modules.periodicals.mapper;

import com.startupstack.app.modules.periodicals.dto.PeriodicalRequest;
import com.startupstack.app.modules.periodicals.dto.PeriodicalResponse;
import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface PeriodicalMapper {

    PeriodicalResponse toResponse(PeriodicalEntity entity);

    @Mapping(target = "price1", ignore = true)
    @Mapping(target = "utils", ignore = true)
    @Mapping(target = "geo1", ignore = true)
    @Mapping(target = "editor1", ignore = true)
    @Mapping(target = "date", ignore = true)
    PeriodicalEntity toEntity(PeriodicalRequest request);

    @Mapping(target = "perNo", ignore = true)
    @Mapping(target = "price1", ignore = true)
    @Mapping(target = "utils", ignore = true)
    @Mapping(target = "geo1", ignore = true)
    @Mapping(target = "editor1", ignore = true)
    @Mapping(target = "date", ignore = true)
    void updateEntity(PeriodicalRequest request, @MappingTarget PeriodicalEntity entity);
}
