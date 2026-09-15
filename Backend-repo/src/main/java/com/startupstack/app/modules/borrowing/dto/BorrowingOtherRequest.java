package com.startupstack.app.modules.borrowing.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BorrowingOtherRequest {

    @Size(max = 100)
    private String title;

    private Double type;

    private Double count;
}
