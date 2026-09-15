package com.startupstack.app.modules.transactions.mapper;

import com.startupstack.app.modules.transactions.dto.TransRequest;
import com.startupstack.app.modules.transactions.dto.TransResponse;
import com.startupstack.app.modules.transactions.entity.TransEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface TransMapper {

    TransResponse toResponse(TransEntity entity);

    TransEntity toEntity(TransRequest request);

    @Mapping(target = "trsOpno", ignore = true)
    @Mapping(target = "trsNo", ignore = true)
    void updateEntity(TransRequest request, @MappingTarget TransEntity entity);
}
