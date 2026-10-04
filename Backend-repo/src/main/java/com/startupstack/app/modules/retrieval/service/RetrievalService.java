package com.startupstack.app.modules.retrieval.service;

import com.startupstack.app.modules.retrieval.dto.RetrievalCodeOption;
import com.startupstack.app.modules.retrieval.dto.RetrievalConditionNode;
import com.startupstack.app.modules.retrieval.dto.RetrievalFieldOption;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchRequest;
import com.startupstack.app.modules.retrieval.dto.RetrievalSearchResponse;
import com.startupstack.app.modules.retrieval.dto.RetrievalUserFieldState;
import com.startupstack.app.modules.retrieval.entity.RetrievalUserFieldEntity;
import com.startupstack.app.modules.retrieval.repository.RetrievalUserFieldRepository;
import com.startupstack.app.modules.retrievalfields.entity.RetrievalFieldEntity;
import com.startupstack.app.modules.retrievalfields.repository.RetrievalFieldRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.util.SecurityUtils;
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
 * builds one parameterized JPQL query per request against a fixed LEFT JOIN skeleton, with the
 * SELECT and WHERE clauses assembled from admin-defined {@link RetrievalFieldEntity} metadata.
 *
 * Every operation is scoped by {@link RetrievalScope}: the legacy "الاسترجاع البياني لبنك
 * المعلومات", "استرجاع الملفات الاضافية" and "استـرجـاع الصحف والمجلات" menu items share the
 * sort_form UI but not its data (bnkout vs POUT metadata, user_ist_no '01' / '02' / '06' user
 * marks, MAIN-rooted tmp_result vs FORM-rooted tmp_result1 vs PERIOD-rooted tmp_result2) — see
 * RetrievalScope for the evidence.
 *
 * The condition tree ({@link RetrievalConditionNode}) replaces the legacy screen's literal
 * "(" / ")" text accumulation with real nesting — a group's children are combined among
 * themselves, then the group as a whole combines with its own siblings, which is exactly what
 * parenthesization means without the fragility of matching text delimiters.
 */
@Service
public class RetrievalService {

    private final RetrievalFieldRepository fieldRepository;
    private final RetrievalUserFieldRepository userFieldRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public RetrievalService(RetrievalFieldRepository fieldRepository, RetrievalUserFieldRepository userFieldRepository) {
        this.fieldRepository = fieldRepository;
        this.userFieldRepository = userFieldRepository;
    }

    @Transactional(readOnly = true)
    public List<RetrievalFieldOption> listFields(RetrievalScope scope) {
        return fieldRepository.findByModuleAndEnabledTrueOrderByCategoryAscDisplayOrderAsc(scope.module()).stream()
                .map(f -> new RetrievalFieldOption(f.getFieldKey(), f.getLabel(), f.getCategory(), f.getFieldType(),
                        f.isLookupEnabled(), f.getLegacySourceTable(), f.isHashMarked(),
                        scope.codedCondition(f.getFieldKey()) != null))
                .toList();
    }

    /**
     * Legacy sort_from.frm Form_Load (lines 2078-2099): BNKOUT2.sql filters view_user_bnkout
     * (BANK, user_ist_no '01') or view_user_pout (ADDITIONAL_FILES, user_ist_no '02') to the
     * current user's rows where user_out_choice is 1 or 2 — i.e. only fields that user has ever
     * marked on THAT screen. Returns exactly that: the current user's persisted marks for the scope.
     */
    @Transactional(readOnly = true)
    public List<RetrievalUserFieldState> myFieldState(RetrievalScope scope) {
        String userNo = currentUserNo();
        return userFieldRepository.findByUserNoAndModule(userNo, scope.module()).stream()
                .map(e -> new RetrievalUserFieldState(e.getFieldKey(), e.isDisplay(), e.isOrderMark()))
                .toList();
    }

    /** Legacy DBList2_DblClick — toggles this user's user_out_choice for one field. */
    @Transactional
    public RetrievalUserFieldState toggleDisplay(RetrievalScope scope, String fieldKey) {
        requireField(fieldKey, allFieldsByKey(scope));
        RetrievalUserFieldEntity e = findOrCreate(currentUserNo(), scope, fieldKey);
        e.setDisplay(!e.isDisplay());
        userFieldRepository.save(e);
        return new RetrievalUserFieldState(e.getFieldKey(), e.isDisplay(), e.isOrderMark());
    }

    /** Legacy DBList2_KeyDown (F10) — toggles this user's user_out_choi1 for one field. */
    @Transactional
    public RetrievalUserFieldState toggleOrder(RetrievalScope scope, String fieldKey) {
        requireField(fieldKey, allFieldsByKey(scope));
        RetrievalUserFieldEntity e = findOrCreate(currentUserNo(), scope, fieldKey);
        e.setOrderMark(!e.isOrderMark());
        userFieldRepository.save(e);
        return new RetrievalUserFieldState(e.getFieldKey(), e.isDisplay(), e.isOrderMark());
    }

    /**
     * Legacy Command3_Click ("تعليم حقول العرض") — bulk-marks every field in the given category
     * as display=true for the current user (legacy loops f_cat rows for the M_OUT_CAT-selected
     * category and calls upd_user_bnkout_choice per field).
     */
    @Transactional
    public List<RetrievalUserFieldState> markCategoryForDisplay(RetrievalScope scope, String category) {
        String userNo = currentUserNo();
        List<RetrievalFieldEntity> inCategory = fieldRepository.findByModuleAndEnabledTrue(scope.module()).stream()
                .filter(f -> category.equals(f.getCategory()))
                .toList();
        List<RetrievalUserFieldState> result = new ArrayList<>();
        for (RetrievalFieldEntity f : inCategory) {
            RetrievalUserFieldEntity e = findOrCreate(userNo, scope, f.getFieldKey());
            e.setDisplay(true);
            userFieldRepository.save(e);
            result.add(new RetrievalUserFieldState(e.getFieldKey(), e.isDisplay(), e.isOrderMark()));
        }
        return result;
    }

    /**
     * Legacy DBList2_77 (F2) — toggles the GLOBAL (not per-user) OUT_CHIOCE/OUT_CHIO1 "#" marker
     * on the metadata row itself (a bnkout row on BANK, a POUT row on ADDITIONAL_FILES, since
     * BNKOUT2 reads view_user_bnkout / view_user_pout respectively). See the exact state machine quoted in the V29
     * migration comment and in the frontend's hashMarkState doc comment.
     */
    @Transactional
    public RetrievalFieldOption toggleHashMark(RetrievalScope scope, String fieldKey) {
        RetrievalFieldEntity f = fieldRepository.findByModuleAndFieldKey(scope.module(), fieldKey)
                .orElseThrow(() -> new BusinessException("Unknown retrieval field: " + fieldKey));
        if (!f.isHashMarked()) {
            f.setHashMarked(true);
            f.setHashChio1(2);
        } else {
            f.setHashMarked(false);
            // out_chio1 is left as-is on unmark, exactly like legacy's DBList2_77 (it only ever
            // reads it on the strip branch; legacy never resets it back here either).
        }
        fieldRepository.save(f);
        return new RetrievalFieldOption(f.getFieldKey(), f.getLabel(), f.getCategory(), f.getFieldType(),
                f.isLookupEnabled(), f.getLegacySourceTable(), f.isHashMarked(),
                scope.codedCondition(f.getFieldKey()) != null);
    }

    private RetrievalUserFieldEntity findOrCreate(String userNo, RetrievalScope scope, String fieldKey) {
        return userFieldRepository.findByUserNoAndModuleAndFieldKey(userNo, scope.module(), fieldKey)
                .orElseGet(() -> {
                    RetrievalUserFieldEntity e = new RetrievalUserFieldEntity();
                    e.setUserNo(userNo);
                    e.setModule(scope.module());
                    e.setFieldKey(fieldKey);
                    return e;
                });
    }

    /**
     * Legacy's box_user_no (the user_bnkout/view_user_bnkout scoping key) has no 1:1 equivalent
     * claim in our JWT; the authenticated username is the real, stable per-user identity in
     * this system and is used in its place.
     */
    private String currentUserNo() {
        String username = SecurityUtils.getCurrentUsername();
        if (username == null) {
            throw new BusinessException("No authenticated user");
        }
        return username;
    }

    @Transactional(readOnly = true)
    public List<String> lookupValues(RetrievalScope scope, String fieldKey, String term) {
        RetrievalFieldEntity field = requireField(fieldKey, allFieldsByKey(scope));
        if (!field.isLookupEnabled()) {
            throw new BusinessException("Field does not offer a value picker: " + fieldKey);
        }
        String column = qualify(scope, field);
        StringBuilder jpql = new StringBuilder("SELECT DISTINCT ").append(column).append(scope.joinSkeleton())
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

    /**
     * Name/code pairs for a coded condition (legacy c_getcond: ListField = name, BoundColumn =
     * code), drawn from the same source and filter as {@link #lookupValues}.
     */
    @Transactional(readOnly = true)
    public List<RetrievalCodeOption> lookupCodes(RetrievalScope scope, String fieldKey, String term) {
        RetrievalFieldEntity field = requireField(fieldKey, allFieldsByKey(scope));
        RetrievalScope.CodedCondition coded = scope.codedCondition(fieldKey);
        if (coded == null) {
            throw new BusinessException("Field is not a coded condition: " + fieldKey);
        }
        String column = qualify(scope, field);
        StringBuilder jpql = new StringBuilder("SELECT DISTINCT ").append(coded.codeColumn()).append(", ").append(column)
                .append(scope.joinSkeleton()).append("WHERE ").append(column).append(" IS NOT NULL");
        boolean hasTerm = term != null && !term.isBlank();
        if (hasTerm) {
            jpql.append(" AND LOWER(").append(column).append(") LIKE :term");
        }
        jpql.append(" ORDER BY ").append(column);

        TypedQuery<Object[]> query = entityManager.createQuery(jpql.toString(), Object[].class);
        if (hasTerm) {
            query.setParameter("term", "%" + term.toLowerCase() + "%");
        }
        return query.setMaxResults(50).getResultList().stream()
                .map(r -> new RetrievalCodeOption((String) r[0], (String) r[1]))
                .toList();
    }

    @Transactional(readOnly = true)
    public RetrievalSearchResponse search(RetrievalScope scope, RetrievalSearchRequest request) {
        Map<String, RetrievalFieldEntity> fields = allFieldsByKey(scope);

        List<String> outputKeys = request.getOutputFieldKeys();
        List<String> selectParts = new ArrayList<>();
        List<String> outputAliases = new ArrayList<>();
        List<RetrievalSearchResponse.RetrievalColumn> columns = new ArrayList<>();
        for (String key : outputKeys) {
            RetrievalFieldEntity field = requireField(key, fields);
            selectParts.add(qualify(scope, field));
            outputAliases.add(alias(scope, field));
            columns.add(new RetrievalSearchResponse.RetrievalColumn(key, field.getLabel()));
        }
        List<String> conditionAliases = new ArrayList<>();
        if (request.getRootCondition() != null) {
            collectConditionAliases(scope, request.getRootCondition(), fields, conditionAliases);
        }

        Map<String, Object> params = new HashMap<>();
        String whereClause = request.getRootCondition() == null
                ? ""
                : " WHERE " + buildPredicate(scope, request.getRootCondition(), fields, params, new AtomicInteger());

        // Legacy F10 ("حقول العرض في الجدول" / DBList2_KeyDown / user_out_choi1) — fields marked
        // for ordering feed cmd_result_Click's "order by" clause in the order they were marked.
        String orderClause = "";
        List<String> orderKeys = request.getOrderFieldKeys();
        if (orderKeys != null && !orderKeys.isEmpty()) {
            List<String> orderParts = new ArrayList<>();
            for (String key : orderKeys) {
                // SELECT DISTINCT requires ORDER BY columns to appear in the SELECT list (same
                // constraint legacy avoided implicitly since F10 marks fields on the same
                // DBList2 list the output-column dblclick toggle uses) — enforce that here
                // rather than emitting a query Postgres would reject.
                if (!outputKeys.contains(key)) {
                    throw new BusinessException(
                            "Order field '" + key + "' must also be one of the selected output fields");
                }
                orderParts.add(qualify(scope, requireField(key, fields)));
            }
            orderClause = " ORDER BY " + String.join(", ", orderParts);
        }

        boolean keyed = !scope.distinctOnOutputOnly();
        String jpql = "SELECT DISTINCT " + (keyed ? scope.rootKey() + ", " : "") + String.join(", ", selectParts)
                + scope.fromClause(conditionAliases, outputAliases) + whereClause + orderClause;
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
            // A single selected column comes back as a bare value, not an Object[].
            Object[] row = rowObj instanceof Object[] cells ? cells : new Object[] {rowObj};
            int offset = keyed ? 1 : 0;
            String appNo = keyed ? rowKey(row[0]) : null;
            Map<String, Object> values = new LinkedHashMap<>();
            for (int i = 0; i < outputKeys.size(); i++) {
                values.put(outputKeys.get(i), row[i + offset]);
            }
            rows.add(new RetrievalSearchResponse.RetrievalResultRow(appNo, values));
        }

        return new RetrievalSearchResponse(columns, rows, total, page, size);
    }

    /** Table aliases of the FIELD nodes in pre-order — the order the legacy conditions were added. */
    private void collectConditionAliases(RetrievalScope scope, RetrievalConditionNode node,
                                         Map<String, RetrievalFieldEntity> fields, List<String> out) {
        if ("GROUP".equalsIgnoreCase(node.getType())) {
            if (node.getChildren() != null) {
                node.getChildren().forEach(c -> collectConditionAliases(scope, c, fields, out));
            }
        } else {
            RetrievalScope.CodedCondition coded = scope.codedCondition(node.getFieldKey());
            out.add(coded != null ? coded.conditionAlias() : alias(scope, requireField(node.getFieldKey(), fields)));
        }
    }

    /** Root keys are strings (MN_APP_NO, SUB_NO) except PERIOD.PER_PER_NO, a float column holding whole numbers. */
    private String rowKey(Object key) {
        if (key instanceof Double d && d == Math.rint(d)) {
            return String.valueOf(d.longValue());
        }
        return key == null ? null : key.toString();
    }

    private String buildPredicate(RetrievalScope scope, RetrievalConditionNode node, Map<String, RetrievalFieldEntity> fields,
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
                sb.append(buildPredicate(scope, child, fields, params, paramSeq));
            }
            return sb.append(")").toString();
        }
        if (!"FIELD".equalsIgnoreCase(node.getType())) {
            throw new BusinessException("Unknown condition node type: " + node.getType());
        }

        RetrievalFieldEntity field = requireField(node.getFieldKey(), fields);
        RetrievalScope.CodedCondition coded = scope.codedCondition(field.getFieldKey());
        String column = coded != null ? coded.conditionColumn() : qualify(scope, field);
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

    private String qualify(RetrievalScope scope, RetrievalFieldEntity field) {
        return alias(scope, field) + "." + field.getEntityPath();
    }

    private String alias(RetrievalScope scope, RetrievalFieldEntity field) {
        return (field.getJoinPath() == null || field.getJoinPath().isBlank()) ? scope.rootAlias() : field.getJoinPath();
    }

    private Map<String, RetrievalFieldEntity> allFieldsByKey(RetrievalScope scope) {
        return fieldRepository.findByModuleAndEnabledTrue(scope.module()).stream()
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
