package com.startupstack.app.modules.borrowing.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BorrowingBookRequest {

    @NotBlank
    @Size(max = 7)
    private String bookNo;
}
