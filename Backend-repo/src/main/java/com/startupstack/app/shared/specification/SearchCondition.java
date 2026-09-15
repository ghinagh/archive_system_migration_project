package com.startupstack.app.shared.specification;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

/**
 * One row of a legacy sort_from.frm-style "cumulative questions" query: a field, an
 * operator, a value (and optional second value for BETWEEN), and the conjunction that
 * combines it with the PREVIOUS condition in the list (ignored for the first condition).
 */
@Getter
@Setter
public class SearchCondition {

    @NotBlank
    private String field;

    @NotBlank
    @Pattern(regexp = "EQUALS|CONTAINS|GT|GTE|LT|LTE|BETWEEN")
    private String operator;

    @NotBlank
    private String value;

    private String value2;

    @Pattern(regexp = "AND|OR")
    private String conjunction = "AND";
}
