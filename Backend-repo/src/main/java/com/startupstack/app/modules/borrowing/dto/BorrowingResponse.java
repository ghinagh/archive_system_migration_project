package com.startupstack.app.modules.borrowing.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BorrowingResponse {

    private String iarNo;
    private Double serial;
    private Double borrowingType;
    private LocalDateTime borrowDate;
    private String personNo;
    private String personName;
    private Double type;
    private String cause;
    private Double period;
    private LocalDateTime dueDate;
    private LocalDateTime returnDate;
    private String remark;
    private Double type1;
    private String bookNo;
    private String bookTitle;
    private String entity;
    private Double regNo;
    private Double deposit;
}
