package com.startupstack.app.modules.borrowing.mapper;

import com.startupstack.app.modules.borrowing.dto.BorrowingOtherRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingOtherResponse;
import com.startupstack.app.modules.borrowing.entity.BorrowingOtherEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BorrowingOtherMapper {

    BorrowingOtherResponse toResponse(BorrowingOtherEntity entity);

    @Mapping(target = "rowId", ignore = true)
    @Mapping(target = "borrowingNo", ignore = true)
    @Mapping(target = "serial", ignore = true)
    BorrowingOtherEntity toEntity(BorrowingOtherRequest request);
}
