package com.startupstack.app.modules.periodicals.mapper;

import com.startupstack.app.modules.periodicals.dto.PeriodicalRequest;
import com.startupstack.app.modules.periodicals.dto.PeriodicalResponse;
import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface PeriodicalMapper {

    PeriodicalResponse toResponse(PeriodicalEntity entity);

    /**
     * PER_ST_DTE (startDate) and PER_CREAT (creator) are never among the ~27 parameters
     * PERIOD1.frm's INSR_period/UPD_period exec calls pass on save (Command4_Click) —
     * this form never reads or writes them, so the migrated save path must not either.
     */
    @Mapping(target = "startDate", ignore = true)
    @Mapping(target = "creator", ignore = true)
    PeriodicalEntity toEntity(PeriodicalRequest request);

    @Mapping(target = "perNo", ignore = true)
    @Mapping(target = "startDate", ignore = true)
    @Mapping(target = "creator", ignore = true)
    void updateEntity(PeriodicalRequest request, @MappingTarget PeriodicalEntity entity);
}
