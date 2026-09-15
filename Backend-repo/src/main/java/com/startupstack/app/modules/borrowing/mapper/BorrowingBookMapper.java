package com.startupstack.app.modules.borrowing.mapper;

import com.startupstack.app.modules.borrowing.dto.BorrowingBookRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingBookResponse;
import com.startupstack.app.modules.borrowing.entity.BorrowingBookEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BorrowingBookMapper {

    BorrowingBookResponse toResponse(BorrowingBookEntity entity);

    @Mapping(target = "rowId", ignore = true)
    @Mapping(target = "borrowingNo", ignore = true)
    @Mapping(target = "serial", ignore = true)
    BorrowingBookEntity toEntity(BorrowingBookRequest request);
}
