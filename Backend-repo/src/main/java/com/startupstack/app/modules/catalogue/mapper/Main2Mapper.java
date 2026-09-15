package com.startupstack.app.modules.catalogue.mapper;

import com.startupstack.app.modules.catalogue.dto.Main2Request;
import com.startupstack.app.modules.catalogue.dto.Main2Response;
import com.startupstack.app.modules.catalogue.entity.Main2Entity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface Main2Mapper {

    Main2Response toResponse(Main2Entity entity);

    @Mapping(target = "appNo", ignore = true)
    @Mapping(target = "activeTitleAr", ignore = true)
    @Mapping(target = "activeCode", ignore = true)
    @Mapping(target = "additionalTitle", ignore = true)
    @Mapping(target = "additionalCode", ignore = true)
    @Mapping(target = "dataEntry", ignore = true)
    @Mapping(target = "appDoc", ignore = true)
    @Mapping(target = "entryDate", ignore = true)
    @Mapping(target = "writeDate", ignore = true)
    @Mapping(target = "appRevision", ignore = true)
    Main2Entity toEntity(Main2Request request);

    @Mapping(target = "appNo", ignore = true)
    @Mapping(target = "activeTitleAr", ignore = true)
    @Mapping(target = "activeCode", ignore = true)
    @Mapping(target = "additionalTitle", ignore = true)
    @Mapping(target = "additionalCode", ignore = true)
    @Mapping(target = "dataEntry", ignore = true)
    @Mapping(target = "appDoc", ignore = true)
    @Mapping(target = "entryDate", ignore = true)
    @Mapping(target = "writeDate", ignore = true)
    @Mapping(target = "appRevision", ignore = true)
    void updateEntity(Main2Request request, @MappingTarget Main2Entity entity);
}
