package com.startupstack.app.modules.authors.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthorRequest {

    @NotNull
    private Double autNo;

    @Size(max = 2)
    private String type;

    @Size(max = 100)
    private String name;

    @Size(max = 10)
    private String subjectNo;
}
