package com.startupstack.app.modules.sites.mapper;

import com.startupstack.app.modules.sites.dto.PostRequest;
import com.startupstack.app.modules.sites.dto.PostResponse;
import com.startupstack.app.modules.sites.entity.PostEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface PostMapper {

    @Mapping(target = "formName", expression = "java(entity.getForm() != null ? entity.getForm().getName() : null)")
    PostResponse toResponse(PostEntity entity);

    @Mapping(target = "form", ignore = true)
    @Mapping(target = "formNo", ignore = true)
    PostEntity toEntity(PostRequest request);

    @Mapping(target = "serial", ignore = true)
    @Mapping(target = "form", ignore = true)
    @Mapping(target = "formNo", ignore = true)
    void updateEntity(PostRequest request, @MappingTarget PostEntity entity);
}
