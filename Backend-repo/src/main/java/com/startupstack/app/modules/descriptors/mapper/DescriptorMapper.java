package com.startupstack.app.modules.descriptors.mapper;

import com.startupstack.app.modules.descriptors.dto.FileAddRequest;
import com.startupstack.app.modules.descriptors.dto.FileAddResponse;
import com.startupstack.app.modules.descriptors.dto.GeoRequest;
import com.startupstack.app.modules.descriptors.dto.GeoResponse;
import com.startupstack.app.modules.descriptors.dto.NarowerRequest;
import com.startupstack.app.modules.descriptors.dto.NarowerResponse;
import com.startupstack.app.modules.descriptors.dto.RelativeRequest;
import com.startupstack.app.modules.descriptors.dto.RelativeResponse;
import com.startupstack.app.modules.descriptors.dto.ResRequest;
import com.startupstack.app.modules.descriptors.dto.ResResponse;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisRequest;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisResponse;
import com.startupstack.app.modules.descriptors.dto.TextRequest;
import com.startupstack.app.modules.descriptors.dto.TextResponse;
import com.startupstack.app.modules.descriptors.entity.FileAddEntity;
import com.startupstack.app.modules.descriptors.entity.GeoEntity;
import com.startupstack.app.modules.descriptors.entity.NarowerEntity;
import com.startupstack.app.modules.descriptors.entity.RelativeEntity;
import com.startupstack.app.modules.descriptors.entity.ResEntity;
import com.startupstack.app.modules.descriptors.entity.SubjectAnalysisEntity;
import com.startupstack.app.modules.descriptors.entity.TextEntity;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface DescriptorMapper {

    SubjectAnalysisResponse toSubjectResponse(SubjectAnalysisEntity entity);

    List<SubjectAnalysisResponse> toSubjectResponseList(List<SubjectAnalysisEntity> entities);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    SubjectAnalysisEntity toSubjectEntity(SubjectAnalysisRequest request);

    GeoResponse toGeoResponse(GeoEntity entity);

    List<GeoResponse> toGeoResponseList(List<GeoEntity> entities);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    GeoEntity toGeoEntity(GeoRequest request);

    FileAddResponse toFileResponse(FileAddEntity entity);

    List<FileAddResponse> toFileResponseList(List<FileAddEntity> entities);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    FileAddEntity toFileEntity(FileAddRequest request);

    TextResponse toTextResponse(TextEntity entity);

    List<TextResponse> toTextResponseList(List<TextEntity> entities);

    @Mapping(target = "rowId", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    TextEntity toTextEntity(TextRequest request);

    NarowerResponse toNarowerResponse(NarowerEntity entity);

    List<NarowerResponse> toNarowerResponseList(List<NarowerEntity> entities);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    NarowerEntity toNarowerEntity(NarowerRequest request);

    RelativeResponse toRelativeResponse(RelativeEntity entity);

    List<RelativeResponse> toRelativeResponseList(List<RelativeEntity> entities);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    RelativeEntity toRelativeEntity(RelativeRequest request);

    @Mapping(target = "authorName", expression = "java(entity.getAuthor() != null ? entity.getAuthor().getAutName() : null)")
    ResResponse toResResponse(ResEntity entity);

    List<ResResponse> toResResponseList(List<ResEntity> entities);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    @Mapping(target = "author", ignore = true)
    ResEntity toResEntity(ResRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "appNo", ignore = true)
    @Mapping(target = "author", ignore = true)
    void updateResEntity(ResRequest request, @MappingTarget ResEntity entity);
}
