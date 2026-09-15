package com.startupstack.app.modules.authors.mapper;

import com.startupstack.app.modules.authors.dto.AuthorRequest;
import com.startupstack.app.modules.authors.dto.AuthorResponse;
import com.startupstack.app.modules.authors.entity.AuthorEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface AuthorMapper {

    @Mapping(source = "autType", target = "type")
    @Mapping(source = "autName", target = "name")
    AuthorResponse toResponse(AuthorEntity entity);

    @Mapping(source = "type", target = "autType")
    @Mapping(source = "name", target = "autName")
    AuthorEntity toEntity(AuthorRequest request);

    @Mapping(target = "autNo", ignore = true)
    @Mapping(source = "type", target = "autType")
    @Mapping(source = "name", target = "autName")
    void updateEntity(AuthorRequest request, @MappingTarget AuthorEntity entity);
}
