package com.startupstack.app.modules.retrieval.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * One node of the query tree the graphical retrieval builder sends: either a leaf
 * condition on a single field ({@code type = "FIELD"}), or a group whose children
 * are combined among themselves before the group itself combines (via
 * {@link #conjunction}) with the previous sibling in its parent's list.
 * Nesting a group is how the builder expresses the parenthesized sub-expressions
 * the legacy sort_from.frm built as literal "(" / ")" characters in its
 * accumulator string — a real tree replaces the fragile text-based grouping.
 */
@Getter
@Setter
public class RetrievalConditionNode {

    /** "FIELD" or "GROUP". */
    private String type;

    /** How this node combines with the previous sibling in its parent's children list ("AND"/"OR"). Ignored for the first child. */
    private String conjunction = "AND";

    // FIELD node
    private String fieldKey;
    private String operator;
    private String value;
    private String value2;

    // GROUP node
    private List<RetrievalConditionNode> children;
}
