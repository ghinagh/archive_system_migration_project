package com.startupstack.app.modules.videoorders.mapper;

import com.startupstack.app.modules.videoorders.dto.VideoOrderRequest;
import com.startupstack.app.modules.videoorders.dto.VideoOrderResponse;
import com.startupstack.app.modules.videoorders.entity.VideoOrderEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface VideoOrderMapper {

    @Mapping(target = "chartId", expression = "java(entity.getChart() != null ? entity.getChart().getId() : null)")
    @Mapping(target = "mediaAvailable", ignore = true)
    VideoOrderResponse toResponse(VideoOrderEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "chart", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    VideoOrderEntity toEntity(VideoOrderRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "chart", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    void updateEntity(VideoOrderRequest request, @MappingTarget VideoOrderEntity entity);
}
