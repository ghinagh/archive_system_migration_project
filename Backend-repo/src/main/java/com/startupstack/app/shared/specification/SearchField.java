package com.startupstack.app.shared.specification;

/**
 * Describes one entity attribute that an {@link AdvancedSearchRequest} is allowed to
 * filter on: the logical name a client sends, the JPA attribute it maps to, and the
 * value type used to parse and compare it. Acts as an allowlist — fields absent from a
 * domain's map can never be queried, closing off arbitrary-field injection.
 */
public record SearchField(String path, FieldType type) {

    public enum FieldType { STRING, NUMBER, DATE }
}
