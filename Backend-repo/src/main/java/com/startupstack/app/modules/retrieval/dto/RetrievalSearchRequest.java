package com.startupstack.app.modules.retrieval.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class RetrievalSearchRequest {

    @Valid
    private RetrievalConditionNode rootCondition;

    @NotEmpty
    private List<String> outputFieldKeys;

    private int page = 0;

    private int size = 25;
}
