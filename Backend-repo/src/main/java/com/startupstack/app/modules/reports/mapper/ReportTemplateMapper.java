package com.startupstack.app.modules.reports.mapper;

import com.startupstack.app.modules.reports.dto.ReportTemplateRequest;
import com.startupstack.app.modules.reports.dto.ReportTemplateResponse;
import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ReportTemplateMapper {

    ReportTemplateResponse toResponse(ReportTemplateEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "subCondition2", ignore = true)
    @Mapping(target = "mainCondition2", ignore = true)
    @Mapping(target = "field2", ignore = true)
    @Mapping(target = "selectClause2", ignore = true)
    @Mapping(target = "index", ignore = true)
    @Mapping(target = "index1", ignore = true)
    @Mapping(target = "index2", ignore = true)
    @Mapping(target = "index3", ignore = true)
    @Mapping(target = "index12", ignore = true)
    @Mapping(target = "selectClause1", ignore = true)
    @Mapping(target = "code", ignore = true)
    @Mapping(target = "valueCode", ignore = true)
    @Mapping(target = "codeName", ignore = true)
    @Mapping(target = "codeName1", ignore = true)
    @Mapping(target = "recurrence", ignore = true)
    @Mapping(target = "condition1", ignore = true)
    @Mapping(target = "relation", ignore = true)
    @Mapping(target = "relation1", ignore = true)
    @Mapping(target = "relation2", ignore = true)
    @Mapping(target = "relation3", ignore = true)
    @Mapping(target = "text2", ignore = true)
    @Mapping(target = "choice1", ignore = true)
    ReportTemplateEntity toEntity(ReportTemplateRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "subCondition2", ignore = true)
    @Mapping(target = "mainCondition2", ignore = true)
    @Mapping(target = "field2", ignore = true)
    @Mapping(target = "selectClause2", ignore = true)
    @Mapping(target = "index", ignore = true)
    @Mapping(target = "index1", ignore = true)
    @Mapping(target = "index2", ignore = true)
    @Mapping(target = "index3", ignore = true)
    @Mapping(target = "index12", ignore = true)
    @Mapping(target = "selectClause1", ignore = true)
    @Mapping(target = "code", ignore = true)
    @Mapping(target = "valueCode", ignore = true)
    @Mapping(target = "codeName", ignore = true)
    @Mapping(target = "codeName1", ignore = true)
    @Mapping(target = "recurrence", ignore = true)
    @Mapping(target = "condition1", ignore = true)
    @Mapping(target = "relation", ignore = true)
    @Mapping(target = "relation1", ignore = true)
    @Mapping(target = "relation2", ignore = true)
    @Mapping(target = "relation3", ignore = true)
    @Mapping(target = "text2", ignore = true)
    @Mapping(target = "choice1", ignore = true)
    void updateEntity(ReportTemplateRequest request, @MappingTarget ReportTemplateEntity entity);
}
