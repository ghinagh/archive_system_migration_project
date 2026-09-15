package com.startupstack.app.modules.descriptors.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TextRequest {

    @Size(max = 70)
    private String memo;

    private Double serial;

    private Double page;
}
