package com.startupstack.app.modules.descriptors.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResRequest {

    @Size(max = 2)
    private String resourceType;

    @NotNull
    private Double authorNo;
}
