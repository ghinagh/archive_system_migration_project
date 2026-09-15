package com.startupstack.app.modules.articles.mapper;

import com.startupstack.app.modules.articles.dto.ArticleRequest;
import com.startupstack.app.modules.articles.dto.ArticleResponse;
import com.startupstack.app.modules.articles.entity.ArticleEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ArticleMapper {

    @Mapping(target = "catalogueTitle", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getActiveTitleAr() : null)")
    @Mapping(target = "additionalTitle", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getAdditionalTitle() : null)")
    @Mapping(target = "periodicalName", expression = "java(entity.getPeriodical() != null ? entity.getPeriodical().getName() : null)")
    @Mapping(target = "dataEntry", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getDataEntry() : null)")
    @Mapping(target = "appDoc", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getAppDoc() : null)")
    @Mapping(target = "entryDate", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getEntryDate() : null)")
    @Mapping(target = "result", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getResult() : null)")
    @Mapping(target = "documentNature", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getDocumentNature() : null)")
    @Mapping(target = "locked", expression = "java(entity.getCatalogue() != null && entity.getCatalogue().getTrans() != null && entity.getCatalogue().getTrans() == 1)")
    ArticleResponse toResponse(ArticleEntity entity);

    @Mapping(target = "catalogue", ignore = true)
    @Mapping(target = "periodical", ignore = true)
    @Mapping(target = "updated", ignore = true)
    ArticleEntity toEntity(ArticleRequest request);

    @Mapping(target = "appNo", ignore = true)
    @Mapping(target = "catalogue", ignore = true)
    @Mapping(target = "periodical", ignore = true)
    @Mapping(target = "updated", ignore = true)
    void updateEntity(ArticleRequest request, @MappingTarget ArticleEntity entity);
}
