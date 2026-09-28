package com.startupstack.app.modules.paysform.mapper;

import com.startupstack.app.modules.paysform.dto.PaysFormResponse;
import com.startupstack.app.modules.paysform.entity.PaysFormEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface PaysFormMapper {

    PaysFormResponse toResponse(PaysFormEntity entity);
}
