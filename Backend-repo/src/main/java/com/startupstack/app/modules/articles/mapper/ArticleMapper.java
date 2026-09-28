package com.startupstack.app.modules.articles.mapper;

import com.startupstack.app.modules.articles.dto.ArticleRequest;
import com.startupstack.app.modules.articles.dto.ArticleResponse;
import com.startupstack.app.modules.articles.entity.ArticleEntity;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
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
    @Mapping(target = "documentNature", expression = "java(natureOf(entity.getCatalogue()))")
    @Mapping(target = "locked", expression = "java(entity.getCatalogue() != null && entity.getCatalogue().getTrans() != null && entity.getCatalogue().getTrans() == 1)")
    ArticleResponse toResponse(ArticleEntity entity);

    /**
     * طبيعة الوثيقة. Legacy Form6 keeps it in MN_TYP (upd_main, Form6.frm:2670-2673), but the migrated
     * app repurposed MN_TYP as the A/B/N/P resource-type discriminator (migration V6) and stores the
     * nature in mn_doc_nature. A record imported from legacy therefore has its ع/س in MN_TYP and an
     * empty mn_doc_nature. Read-only fallback: when the separate column is empty, show MN_TYP if — and
     * only if — it holds ع or س. No discriminator value (A/B/N/P) and no integer written by legacy
     * upd_main_vd can equal either, so this can't misread one; nothing is written to MN_TYP.
     */
    default String natureOf(CatalogueEntity catalogue) {
        if (catalogue == null) {
            return null;
        }
        String nature = catalogue.getDocumentNature();
        if (nature != null && !nature.isBlank()) {
            return nature;
        }
        String legacy = catalogue.getType();
        return legacy != null && ("ع".equals(legacy.trim()) || "س".equals(legacy.trim())) ? legacy.trim() : nature;
    }

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
