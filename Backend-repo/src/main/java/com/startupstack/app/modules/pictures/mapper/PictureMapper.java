package com.startupstack.app.modules.pictures.mapper;

import com.startupstack.app.modules.pictures.dto.PictureRequest;
import com.startupstack.app.modules.pictures.dto.PictureResponse;
import com.startupstack.app.modules.pictures.entity.PictureEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface PictureMapper {

    PictureResponse toResponse(PictureEntity entity);

    PictureEntity toEntity(PictureRequest request);

    @Mapping(target = "picNo", ignore = true)
    void updateEntity(PictureRequest request, @MappingTarget PictureEntity entity);
}
