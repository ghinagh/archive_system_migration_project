package com.startupstack.app.modules.retrieval.service;

import com.startupstack.app.modules.retrieval.dto.RetrievalConditionNode;
import com.startupstack.app.modules.retrieval.dto.RetrievalFieldOption;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchRequest;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchResponse;
import com.startupstack.app.modules.retrievalfields.entity.RetrievalFieldEntity;
import com.startupstack.app.modules.retrievalfields.repository.RetrievalFieldRepository;
import com.startupstack.app.shared.exception.BusinessException;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * The cross-domain "graphical retrieval" query engine — migrated equivalent of the legacy
 * sort_from.frm builder + its dynamically rebuilt tmp_result* stored procedures. Rather than
 * generating and executing ad hoc SQL/stored procedures (disallowed for this project), this
 * builds one parameterized JPQL query per request against a fixed LEFT JOIN skeleton spanning
 * the catalogue (main) root plus its article / periodical / author / subject / additional-file
 * joins, with the SELECT and WHERE clauses assembled from admin-defined
 * {@link RetrievalFieldEntity} metadata.
 *
 * The additional-file join (fa/rd) covers the same FILE_ADD cross-reference domain that the
 * legacy "استرجاع الملفات الاضافية" menu item searched via this same sort_form shell (scoped to
 * the POUT metadata partition there) — merged into this one field catalog instead of
 * re-instantiating a second identical screen, the way the legacy app did.
 *
 * The condition tree ({@link RetrievalConditionNode}) replaces the legacy screen's literal
 * "(" / ")" text accumulation with real nesting — a group's children are combined among
 * themselves, then the group as a whole combines with its own siblings, which is exactly what
 * parenthesization means without the fragility of matching text delimiters.
 */
@Service
public class RetrievalService {

    private static final String MODULE = "GRAPHICAL_RETRIEVAL";

    private static final String JOIN_SKELETON =
            " FROM CatalogueEntity c " +
            "LEFT JOIN ArticleEntity a ON a.appNo = c.appNo " +
            "LEFT JOIN PeriodicalEntity p ON p.perNo = a.periodicalNo " +
            "LEFT JOIN ResEntity r ON r.appNo = c.appNo " +
            "LEFT JOIN AuthorEntity au ON au.autNo = r.authorNo " +
            "LEFT JOIN SubjectAnalysisEntity sl ON sl.appNo = c.appNo " +
            "LEFT JOIN MacnzEntity sub ON sub.subCode = sl.descriptorNo " +
            "LEFT JOIN FileAddEntity fa ON fa.appNo = c.appNo " +
            "LEFT JOIN CatalogueEntity rd ON rd.appNo = fa.fileNo ";

    private final RetrievalFieldRepository fieldRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public RetrievalService(RetrievalFieldRepository fieldRepository) {
        this.fieldRepository = fieldRepository;
    }

    @Transactional(readOnly = true)
    public List<RetrievalFieldOption> listFields() {
        return fieldRepository.findByModuleAndEnabledTrueOrderByCategoryAscDisplayOrderAsc(MODULE).stream()
                .map(f -> new RetrievalFieldOption(f.getFieldKey(), f.getLabel(), f.getCategory(), f.getFieldType(), f.isLookupEnabled()))
                .toList();
    }

    @Transactional(readOnly = true)
    public List<String> lookupValues(String fieldKey, String term) {
        RetrievalFieldEntity field = requireField(fieldKey, allFieldsByKey());
        if (!field.isLookupEnabled()) {
            throw new BusinessException("Field does not offer a value picker: " + fieldKey);
        }
        String column = qualify(field);
        StringBuilder jpql = new StringBuilder("SELECT DISTINCT ").append(column).append(JOIN_SKELETON)
                .append("WHERE ").append(column).append(" IS NOT NULL");
        boolean hasTerm = term != null && !term.isBlank();
        if (hasTerm) {
            jpql.append(" AND LOWER(").append(column).append(") LIKE :term");
        }
        jpql.append(" ORDER BY ").append(column);

        TypedQuery<String> query = entityManager.createQuery(jpql.toString(), String.class);
        if (hasTerm) {
            query.setParameter("term", "%" + term.toLowerCase() + "%");
        }
        return query.setMaxResults(50).getResultList();
    }

    @Transactional(readOnly = true)
    public RetrievalSearchResponse search(RetrievalSearchRequest request) {
        Map<String, RetrievalFieldEntity> fields = allFieldsByKey();

        List<String> outputKeys = request.getOutputFieldKeys();
        List<String> selectParts = new ArrayList<>();
        List<RetrievalSearchResponse.RetrievalColumn> columns = new ArrayList<>();
        for (String key : outputKeys) {
            RetrievalFieldEntity field = requireField(key, fields);
            selectParts.add(qualify(field));
            columns.add(new RetrievalSearchResponse.RetrievalColumn(key, field.getLabel()));
        }

        Map<String, Object> params = new HashMap<>();
        String whereClause = request.getRootCondition() == null
                ? ""
                : " WHERE " + buildPredicate(request.getRootCondition(), fields, params, new AtomicInteger());

        String jpql = "SELECT DISTINCT c.appNo, " + String.join(", ", selectParts) + JOIN_SKELETON + whereClause;
        Query dataQuery = entityManager.createQuery(jpql);
        params.forEach(dataQuery::setParameter);

        // Counting DISTINCT rows correctly here would need a multi-column COUNT(DISTINCT ...) that
        // Postgres computes as a row-wise distinct anyway; fetching the full filtered set and paginating
        // in memory (same approach as ArchiveSearchService) keeps this simple and correct for a catalogue
        // this size, avoiding an undercount when one document has several linked authors/subjects.
        List<?> allRows = dataQuery.getResultList();
        long total = allRows.size();
        int page = Math.max(request.getPage(), 0);
        int size = request.getSize() <= 0 ? 25 : request.getSize();
        int fromIndex = Math.min(page * size, allRows.size());
        int toIndex = Math.min(fromIndex + size, allRows.size());

        List<RetrievalSearchResponse.RetrievalResultRow> rows = new ArrayList<>();
        for (Object rowObj : allRows.subList(fromIndex, toIndex)) {
            Object[] row = (Object[]) rowObj;
            String appNo = (String) row[0];
            Map<String, Object> values = new LinkedHashMap<>();
            for (int i = 0; i < outputKeys.size(); i++) {
                values.put(outputKeys.get(i), row[i + 1]);
            }
            rows.add(new RetrievalSearchResponse.RetrievalResultRow(appNo, values));
        }

        return new RetrievalSearchResponse(columns, rows, total, page, size);
    }

    private String buildPredicate(RetrievalConditionNode node, Map<String, RetrievalFieldEntity> fields,
                                   Map<String, Object> params, AtomicInteger paramSeq) {
        if ("GROUP".equalsIgnoreCase(node.getType())) {
            List<RetrievalConditionNode> children = node.getChildren();
            if (children == null || children.isEmpty()) {
                throw new BusinessException("A condition group must have at least one child");
            }
            StringBuilder sb = new StringBuilder("(");
            for (int i = 0; i < children.size(); i++) {
                RetrievalConditionNode child = children.get(i);
                if (i > 0) {
                    sb.append(" ").append("OR".equalsIgnoreCase(child.getConjunction()) ? "OR" : "AND").append(" ");
                }
                sb.append(buildPredicate(child, fields, params, paramSeq));
            }
            return sb.append(")").toString();
        }
        if (!"FIELD".equalsIgnoreCase(node.getType())) {
            throw new BusinessException("Unknown condition node type: " + node.getType());
        }

        RetrievalFieldEntity field = requireField(node.getFieldKey(), fields);
        String column = qualify(field);
        String operator = node.getOperator() == null ? "" : node.getOperator().toUpperCase();
        return switch (field.getFieldType()) {
            case "STRING" -> stringPredicate(column, operator, node, params, paramSeq);
            case "NUMBER" -> numberPredicate(column, operator, node, params, paramSeq);
            case "DATE" -> datePredicate(column, operator, node, params, paramSeq);
            default -> throw new BusinessException("Unknown field type: " + field.getFieldType());
        };
    }

    private String stringPredicate(String column, String operator, RetrievalConditionNode node,
                                    Map<String, Object> params, AtomicInteger seq) {
        String p1 = nextParam(seq);
        return switch (operator) {
            case "EQUALS" -> {
                params.put(p1, node.getValue());
                yield column + " = :" + p1;
            }
            // F8 in the legacy screen — "بحث بالبداية" (prefix match)
            case "STARTS_WITH" -> {
                params.put(p1, node.getValue() + "%");
                yield "LOWER(" + column + ") LIKE LOWER(:" + p1 + ")";
            }
            // F9 in the legacy screen — "بحث بكلمة معينة" (word-anywhere match)
            case "CONTAINS" -> {
                params.put(p1, "%" + node.getValue() + "%");
                yield "LOWER(" + column + ") LIKE LOWER(:" + p1 + ")";
            }
            default -> throw new BusinessException("Operator " + operator + " is not supported for text fields");
        };
    }

    private String numberPredicate(String column, String operator, RetrievalConditionNode node,
                                    Map<String, Object> params, AtomicInteger seq) {
        Double v1 = parseNumber(node.getValue());
        String p1 = nextParam(seq);
        return switch (operator) {
            case "EQUALS" -> { params.put(p1, v1); yield column + " = :" + p1; }
            case "GT" -> { params.put(p1, v1); yield column + " > :" + p1; }
            case "GTE" -> { params.put(p1, v1); yield column + " >= :" + p1; }
            case "LT" -> { params.put(p1, v1); yield column + " < :" + p1; }
            case "LTE" -> { params.put(p1, v1); yield column + " <= :" + p1; }
            case "BETWEEN" -> {
                Double v2 = parseNumber(node.getValue2());
                String p2 = nextParam(seq);
                params.put(p1, v1);
                params.put(p2, v2);
                yield column + " BETWEEN :" + p1 + " AND :" + p2;
            }
            default -> throw new BusinessException("Operator " + operator + " is not supported for numeric fields");
        };
    }

    private String datePredicate(String column, String operator, RetrievalConditionNode node,
                                  Map<String, Object> params, AtomicInteger seq) {
        LocalDateTime v1 = parseDate(node.getValue());
        String p1 = nextParam(seq);
        return switch (operator) {
            case "EQUALS" -> { params.put(p1, v1); yield column + " = :" + p1; }
            case "GT" -> { params.put(p1, v1); yield column + " > :" + p1; }
            case "GTE" -> { params.put(p1, v1); yield column + " >= :" + p1; }
            case "LT" -> { params.put(p1, v1); yield column + " < :" + p1; }
            case "LTE" -> { params.put(p1, v1); yield column + " <= :" + p1; }
            case "BETWEEN" -> {
                LocalDateTime v2 = parseDate(node.getValue2());
                String p2 = nextParam(seq);
                params.put(p1, v1);
                params.put(p2, v2);
                yield column + " BETWEEN :" + p1 + " AND :" + p2;
            }
            default -> throw new BusinessException("Operator " + operator + " is not supported for date fields");
        };
    }

    private String nextParam(AtomicInteger seq) {
        return "v" + seq.getAndIncrement();
    }

    private Double parseNumber(String raw) {
        try {
            return Double.valueOf(raw);
        } catch (NumberFormatException e) {
            throw new BusinessException("Invalid numeric value: " + raw);
        }
    }

    private LocalDateTime parseDate(String raw) {
        try {
            return LocalDateTime.parse(raw);
        } catch (DateTimeParseException e) {
            throw new BusinessException("Invalid date value (expected ISO-8601): " + raw);
        }
    }

    private String qualify(RetrievalFieldEntity field) {
        String alias = (field.getJoinPath() == null || field.getJoinPath().isBlank()) ? "c" : field.getJoinPath();
        return alias + "." + field.getEntityPath();
    }

    private Map<String, RetrievalFieldEntity> allFieldsByKey() {
        return fieldRepository.findByModuleAndEnabledTrue(MODULE).stream()
                .collect(Collectors.toMap(RetrievalFieldEntity::getFieldKey, f -> f));
    }

    private RetrievalFieldEntity requireField(String fieldKey, Map<String, RetrievalFieldEntity> fields) {
        RetrievalFieldEntity field = fields.get(fieldKey);
        if (field == null) {
            throw new BusinessException("Unknown or disabled retrieval field: " + fieldKey);
        }
        return field;
    }
}
