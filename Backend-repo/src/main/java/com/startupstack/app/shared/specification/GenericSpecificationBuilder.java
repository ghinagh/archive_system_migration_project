package com.startupstack.app.shared.specification;

import com.startupstack.app.shared.exception.BusinessException;
import jakarta.persistence.criteria.Path;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

/**
 * Builds a {@link Specification} from a flat, left-to-right list of AND/OR conditions —
 * the same model as the legacy sort_from.frm "cumulative questions" query builder,
 * reused across every domain's advanced-search endpoint instead of each module
 * reinventing its own ad hoc filter form.
 *
 * Only fields present in the caller-supplied allowlist can be queried, and each field
 * carries its own {@link SearchField.FieldType} so operators are parsed and compared
 * against the correct Java type rather than raw strings.
 */
public final class GenericSpecificationBuilder {

    private GenericSpecificationBuilder() {
    }

    public static <T> Specification<T> build(List<SearchCondition> conditions, Map<String, SearchField> allowedFields) {
        if (conditions == null || conditions.isEmpty()) {
            return null;
        }
        Specification<T> combined = null;
        for (SearchCondition condition : conditions) {
            SearchField field = allowedFields.get(condition.getField());
            if (field == null) {
                throw new BusinessException("Unknown or disallowed search field: " + condition.getField());
            }
            Specification<T> spec = toSpecification(field, condition);
            if (combined == null) {
                combined = spec;
            } else if ("OR".equalsIgnoreCase(condition.getConjunction())) {
                combined = combined.or(spec);
            } else {
                combined = combined.and(spec);
            }
        }
        return combined;
    }

    private static <T> Specification<T> toSpecification(SearchField field, SearchCondition condition) {
        String operator = condition.getOperator().toUpperCase();
        return switch (field.type()) {
            case STRING -> stringSpec(field.path(), operator, condition.getValue());
            case NUMBER -> numberSpec(field.path(), operator, condition.getValue(), condition.getValue2());
            case DATE -> dateSpec(field.path(), operator, condition.getValue(), condition.getValue2());
        };
    }

    private static <T> Specification<T> stringSpec(String path, String operator, String value) {
        return (root, query, cb) -> {
            Path<String> attr = root.get(path);
            return switch (operator) {
                case "CONTAINS" -> cb.like(cb.lower(attr), "%" + value.toLowerCase() + "%");
                case "EQUALS" -> cb.equal(attr, value);
                default -> throw new BusinessException("Operator " + operator + " is not supported for text fields");
            };
        };
    }

    private static <T> Specification<T> numberSpec(String path, String operator, String value, String value2) {
        Double parsed = parseNumber(value);
        Double parsed2 = value2 == null ? null : parseNumber(value2);
        return (root, query, cb) -> {
            Path<Double> attr = root.get(path);
            return switch (operator) {
                case "EQUALS" -> cb.equal(attr, parsed);
                case "GT" -> cb.greaterThan(attr, parsed);
                case "GTE" -> cb.greaterThanOrEqualTo(attr, parsed);
                case "LT" -> cb.lessThan(attr, parsed);
                case "LTE" -> cb.lessThanOrEqualTo(attr, parsed);
                case "BETWEEN" -> cb.between(attr, parsed, parsed2);
                default -> throw new BusinessException("Operator " + operator + " is not supported for numeric fields");
            };
        };
    }

    private static <T> Specification<T> dateSpec(String path, String operator, String value, String value2) {
        LocalDateTime parsed = parseDate(value);
        LocalDateTime parsed2 = value2 == null ? null : parseDate(value2);
        return (root, query, cb) -> {
            Path<LocalDateTime> attr = root.get(path);
            return switch (operator) {
                case "EQUALS" -> cb.equal(attr, parsed);
                case "GT" -> cb.greaterThan(attr, parsed);
                case "GTE" -> cb.greaterThanOrEqualTo(attr, parsed);
                case "LT" -> cb.lessThan(attr, parsed);
                case "LTE" -> cb.lessThanOrEqualTo(attr, parsed);
                case "BETWEEN" -> cb.between(attr, parsed, parsed2);
                default -> throw new BusinessException("Operator " + operator + " is not supported for date fields");
            };
        };
    }

    private static Double parseNumber(String raw) {
        try {
            return Double.valueOf(raw);
        } catch (NumberFormatException e) {
            throw new BusinessException("Invalid numeric value: " + raw);
        }
    }

    private static LocalDateTime parseDate(String raw) {
        try {
            return LocalDateTime.parse(raw);
        } catch (DateTimeParseException e) {
            throw new BusinessException("Invalid date value (expected ISO-8601): " + raw);
        }
    }
}
