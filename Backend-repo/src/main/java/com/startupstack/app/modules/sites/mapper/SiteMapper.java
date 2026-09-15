package com.startupstack.app.modules.sites.mapper;

import com.startupstack.app.modules.sites.dto.SiteRequest;
import com.startupstack.app.modules.sites.dto.SiteResponse;
import com.startupstack.app.modules.sites.entity.SiteEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface SiteMapper {

    @Mapping(target = "formName", expression = "java(entity.getForm() != null ? entity.getForm().getName() : null)")
    SiteResponse toResponse(SiteEntity entity);

    @Mapping(target = "form", ignore = true)
    @Mapping(target = "intkb", ignore = true)
    @Mapping(target = "morch", ignore = true)
    @Mapping(target = "closeNo", ignore = true)
    SiteEntity toEntity(SiteRequest request);

    @Mapping(target = "siteNo", ignore = true)
    @Mapping(target = "form", ignore = true)
    @Mapping(target = "intkb", ignore = true)
    @Mapping(target = "morch", ignore = true)
    @Mapping(target = "closeNo", ignore = true)
    void updateEntity(SiteRequest request, @MappingTarget SiteEntity entity);
}
