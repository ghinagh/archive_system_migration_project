package com.startupstack.app.modules.reports.mapper;

import com.startupstack.app.modules.reports.dto.UserOutputRequest;
import com.startupstack.app.modules.reports.dto.UserOutputResponse;
import com.startupstack.app.modules.reports.entity.UserOutputEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UserOutputMapper {

    UserOutputResponse toResponse(UserOutputEntity entity);

    UserOutputEntity toEntity(UserOutputRequest request);

    @Mapping(target = "institutionNo", ignore = true)
    @Mapping(target = "userNo", ignore = true)
    @Mapping(target = "outputNum", ignore = true)
    void updateEntity(UserOutputRequest request, @MappingTarget UserOutputEntity entity);
}
