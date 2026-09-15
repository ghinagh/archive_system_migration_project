package com.startupstack.app.modules.digitization.mapper;

import com.startupstack.app.modules.digitization.dto.ResultRequest;
import com.startupstack.app.modules.digitization.dto.ResultResponse;
import com.startupstack.app.modules.digitization.entity.ResultEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ResultMapper {

    @Mapping(target = "catalogueTitle", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getActiveTitleAr() : null)")
    ResultResponse toResponse(ResultEntity entity);

    @Mapping(target = "id", ignore = true)
    ResultEntity toEntity(ResultRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "resultNo", ignore = true)
    @Mapping(target = "serial", ignore = true)
    void updateEntity(ResultRequest request, @MappingTarget ResultEntity entity);
}
