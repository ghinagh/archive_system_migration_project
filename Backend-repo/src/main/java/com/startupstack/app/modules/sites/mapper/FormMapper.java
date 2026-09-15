package com.startupstack.app.modules.sites.mapper;

import com.startupstack.app.modules.sites.dto.FormRequest;
import com.startupstack.app.modules.sites.dto.FormResponse;
import com.startupstack.app.modules.sites.entity.FormEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface FormMapper {

    FormResponse toResponse(FormEntity entity);

    FormEntity toEntity(FormRequest request);

    @Mapping(target = "formNo", ignore = true)
    void updateEntity(FormRequest request, @MappingTarget FormEntity entity);
}
