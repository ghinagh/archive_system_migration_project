package com.startupstack.app.modules.requests.mapper;

import com.startupstack.app.modules.requests.dto.UsageRequestRequest;
import com.startupstack.app.modules.requests.dto.UsageRequestResponse;
import com.startupstack.app.modules.requests.entity.UsageRequestEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UsageRequestMapper {

    UsageRequestResponse toResponse(UsageRequestEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    UsageRequestEntity toEntity(UsageRequestRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    void updateEntity(UsageRequestRequest request, @MappingTarget UsageRequestEntity entity);
}
