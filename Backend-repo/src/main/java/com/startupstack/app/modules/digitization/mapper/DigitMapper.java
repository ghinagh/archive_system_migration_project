package com.startupstack.app.modules.digitization.mapper;

import com.startupstack.app.modules.digitization.dto.DigitRequest;
import com.startupstack.app.modules.digitization.dto.DigitResponse;
import com.startupstack.app.modules.digitization.entity.DigitEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface DigitMapper {

    @Mapping(target = "catalogueTitle", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getActiveTitleAr() : null)")
    DigitResponse toResponse(DigitEntity entity);

    @Mapping(target = "catalogue", ignore = true)
    DigitEntity toEntity(DigitRequest request);

    @Mapping(target = "docNo", ignore = true)
    @Mapping(target = "serial", ignore = true)
    @Mapping(target = "catalogue", ignore = true)
    void updateEntity(DigitRequest request, @MappingTarget DigitEntity entity);
}
