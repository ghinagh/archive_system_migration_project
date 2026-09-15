package com.startupstack.app.modules.catalogue.mapper;

import com.startupstack.app.modules.catalogue.dto.CatalogueRequest;
import com.startupstack.app.modules.catalogue.dto.CatalogueResponse;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface CatalogueMapper {

    CatalogueResponse toResponse(CatalogueEntity entity);

    CatalogueEntity toEntity(CatalogueRequest request);

    @Mapping(target = "appNo", ignore = true)
    void updateEntity(CatalogueRequest request, @MappingTarget CatalogueEntity entity);
}
