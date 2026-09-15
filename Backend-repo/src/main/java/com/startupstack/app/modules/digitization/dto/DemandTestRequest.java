package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class DemandTestRequest {

    @NotEmpty
    private List<Integer> ids;
}
