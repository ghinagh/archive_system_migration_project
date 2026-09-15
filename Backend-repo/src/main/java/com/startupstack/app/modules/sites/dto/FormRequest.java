package com.startupstack.app.modules.sites.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class FormRequest {

    @NotBlank
    @Size(max = 8)
    private String formNo;

    @Size(max = 2)
    private String formType;

    @Size(max = 60)
    private String name;

    private LocalDateTime date;

    @Size(max = 3)
    private String user;

    private Integer section;

    private Integer jihadNo;

    @Size(max = 100)
    private String printName;
}
