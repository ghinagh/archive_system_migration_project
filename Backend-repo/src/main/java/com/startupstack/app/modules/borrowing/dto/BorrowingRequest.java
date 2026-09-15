package com.startupstack.app.modules.borrowing.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BorrowingRequest {

    @NotBlank
    @Size(max = 6)
    private String iarNo;

    @NotNull
    private Double serial;

    @NotNull
    private Double borrowingType;

    private LocalDateTime borrowDate;

    @Size(max = 5)
    private String personNo;

    private Double type;

    @Size(max = 2)
    private String cause;

    private Double period;

    private LocalDateTime dueDate;

    @Size(max = 70)
    private String remark;

    private Double type1;

    @Size(max = 7)
    private String bookNo;

    @Size(max = 3)
    private String entity;

    private Double regNo;

    private Double deposit;
}
