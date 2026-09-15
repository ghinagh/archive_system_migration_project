package com.startupstack.app.shared.specification;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class AdvancedSearchRequest {

    @Valid
    private List<SearchCondition> conditions = new ArrayList<>();
}
