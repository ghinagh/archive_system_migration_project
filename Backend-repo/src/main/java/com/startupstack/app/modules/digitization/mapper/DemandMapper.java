package com.startupstack.app.modules.digitization.mapper;

import com.startupstack.app.modules.digitization.dto.DemandRequest;
import com.startupstack.app.modules.digitization.dto.DemandResponse;
import com.startupstack.app.modules.digitization.entity.DemandEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface DemandMapper {

    @Mapping(target = "userName", expression = "java(entity.getUser() != null ? entity.getUser().getUserName() : null)")
    @Mapping(target = "catalogueTitle", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getActiveTitleAr() : null)")
    DemandResponse toResponse(DemandEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "user", ignore = true)
    @Mapping(target = "catalogue", ignore = true)
    @Mapping(target = "userNo", ignore = true)
    @Mapping(target = "machineNo", ignore = true)
    DemandEntity toEntity(DemandRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "user", ignore = true)
    @Mapping(target = "catalogue", ignore = true)
    @Mapping(target = "userNo", ignore = true)
    @Mapping(target = "machineNo", ignore = true)
    @Mapping(target = "demandNo", ignore = true)
    @Mapping(target = "serial", ignore = true)
    void updateEntity(DemandRequest request, @MappingTarget DemandEntity entity);
}
