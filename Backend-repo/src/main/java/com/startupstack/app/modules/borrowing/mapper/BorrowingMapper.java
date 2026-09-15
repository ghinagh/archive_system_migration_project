package com.startupstack.app.modules.borrowing.mapper;

import com.startupstack.app.modules.borrowing.dto.BorrowingRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingResponse;
import com.startupstack.app.modules.borrowing.entity.BorrowingEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface BorrowingMapper {

    @Mapping(target = "personName", expression = "java(entity.getPerson() != null ? entity.getPerson().getPrsName() : null)")
    @Mapping(target = "bookTitle", expression = "java(entity.getCatalogue() != null ? entity.getCatalogue().getActiveTitleAr() : null)")
    BorrowingResponse toResponse(BorrowingEntity entity);

    @Mapping(target = "person", ignore = true)
    @Mapping(target = "catalogue", ignore = true)
    @Mapping(target = "returnDate", ignore = true)
    @Mapping(target = "personNo", ignore = true)
    @Mapping(target = "bookNo", ignore = true)
    BorrowingEntity toEntity(BorrowingRequest request);

    @Mapping(target = "iarNo", ignore = true)
    @Mapping(target = "serial", ignore = true)
    @Mapping(target = "borrowingType", ignore = true)
    @Mapping(target = "person", ignore = true)
    @Mapping(target = "catalogue", ignore = true)
    @Mapping(target = "returnDate", ignore = true)
    @Mapping(target = "personNo", ignore = true)
    @Mapping(target = "bookNo", ignore = true)
    void updateEntity(BorrowingRequest request, @MappingTarget BorrowingEntity entity);
}
