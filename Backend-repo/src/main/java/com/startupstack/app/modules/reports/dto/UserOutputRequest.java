package com.startupstack.app.modules.reports.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserOutputRequest {

    @NotBlank
    @Size(max = 2)
    private String institutionNo;

    @NotBlank
    @Size(max = 3)
    private String userNo;

    @NotNull
    private Integer outputNum;

    private Integer outputChoice;

    @Size(max = 3)
    private String userIndex;

    @Size(max = 1)
    private String sign;

    private Integer outputChoice1;

    @Size(max = 1)
    private String sign1;
}
