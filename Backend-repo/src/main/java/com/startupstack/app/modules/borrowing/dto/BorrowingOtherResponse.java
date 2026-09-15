package com.startupstack.app.modules.borrowing.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BorrowingOtherResponse {

    private String borrowingNo;
    private Double serial;
    private String title;
    private Double type;
    private Double count;
}
