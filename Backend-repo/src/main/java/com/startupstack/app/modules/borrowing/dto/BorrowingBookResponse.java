package com.startupstack.app.modules.borrowing.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BorrowingBookResponse {

    private String borrowingNo;
    private Double serial;
    private String bookNo;
}
