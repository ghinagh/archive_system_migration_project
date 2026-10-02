package com.startupstack.app.modules.retrieval.service;

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
            // ARTICLE.ART_PER1 (ArticleEntity.periodical1) is a second, distinct periodical
            // reference confirmed by upd_article2's own column list (art_per1) and, in Form6.frm,
            // by the DataCombo m_art_per1 (also bound to PERIOD) sitting at the exact form
            // position of the Label captioned "مصدر الترجمة" ("translation source") — i.e. the
            // original periodical a translated article came from.
            "LEFT JOIN PeriodicalEntity p1 ON p1.perNo = a.periodical1 " +
            "LEFT JOIN ResEntity r ON r.appNo = c.appNo " +
            "LEFT JOIN AuthorEntity au ON au.autNo = r.authorNo " +
            "LEFT JOIN SubjectAnalysisEntity sl ON sl.appNo = c.appNo " +
            "LEFT JOIN MacnzEntity sub ON sub.subCode = sl.descriptorNo " +
            "LEFT JOIN FileAddEntity fa ON fa.appNo = c.appNo " +
            "LEFT JOIN CatalogueEntity rd ON rd.appNo = fa.fileNo " +
            // DigitEntity.catalogue is an existing @ManyToOne (DIG_NO=MN_APP_NO) — reused here,
            // not a new relationship — to surface "نوع المادة"/"نوع الشريط" (DIGIT.dig_typmat /
            // dig_typchrt), confirmed via Form6.frm's DataGrid DataField bindings + rel_digit_proc.
            "LEFT JOIN DigitEntity dg ON dg.docNo = c.appNo ";

    private final RetrievalFieldRepository fieldRepository;
    private final RetrievalUserFieldRepository userFieldRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public RetrievalService(RetrievalFieldRepository fieldRepository, RetrievalUserFieldRepository userFieldRepository) {
        this.fieldRepository = fieldRepository;
        this.userFieldRepository = userFieldRepository;
    }

    @Transactional(readOnly = true)
    public List<RetrievalFieldOption> listFields() {
        return fieldRepository.findByModuleAndEnabledTrueOrderByCategoryAscDisplayOrderAsc(MODULE).stream()
                .map(f -> new RetrievalFieldOption(f.getFieldKey(), f.getLabel(), f.getCategory(), f.getFieldType(),
                        f.isLookupEnabled(), f.getLegacySourceTable(), f.isHashMarked()))
                .toList();
    }

    /**
     * Legacy sort_from.frm Form_Load (lines 2078-2081): BNKOUT2.sql filters view_user_bnkout to
     * the current user's rows where user_out_choice is 1 or 2 — i.e. only fields that user has
     * ever marked. Returns exactly that: the current user's persisted display/order marks.
     */
    @Transactional(readOnly = true)
    public List<RetrievalUserFieldState> myFieldState() {
        String userNo = currentUserNo();
        return userFieldRepository.findByUserNo(userNo).stream()
                .map(e -> new RetrievalUserFieldState(e.getFieldKey(), e.isDisplay(), e.isOrderMark()))
                .toList();
    }

    /** Legacy DBList2_DblClick — toggles this user's user_out_choice for one field. */
    @Transactional
    public RetrievalUserFieldState toggleDisplay(String fieldKey) {
        requireField(fieldKey, allFieldsByKey());
        RetrievalUserFieldEntity e = findOrCreate(currentUserNo(), fieldKey);
        e.setDisplay(!e.isDisplay());
        userFieldRepository.save(e);
        return new RetrievalUserFieldState(e.getFieldKey(), e.isDisplay(), e.isOrderMark());
    }

    /** Legacy DBList2_KeyDown (F10) — toggles this user's user_out_choi1 for one field. */
    @Transactional
    public RetrievalUserFieldState toggleOrder(String fieldKey) {
        requireField(fieldKey, allFieldsByKey());
        RetrievalUserFieldEntity e = findOrCreate(currentUserNo(), fieldKey);
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
    public List<RetrievalUserFieldState> markCategoryForDisplay(String category) {
        String userNo = currentUserNo();
        List<RetrievalFieldEntity> inCategory = fieldRepository.findByModuleAndEnabledTrue(MODULE).stream()
                .filter(f -> category.equals(f.getCategory()))
                .toList();
        List<RetrievalUserFieldState> result = new ArrayList<>();
        for (RetrievalFieldEntity f : inCategory) {
            RetrievalUserFieldEntity e = findOrCreate(userNo, f.getFieldKey());
            e.setDisplay(true);
            userFieldRepository.save(e);
            result.add(new RetrievalUserFieldState(e.getFieldKey(), e.isDisplay(), e.isOrderMark()));
        }
        return result;
    }

    /**
     * Legacy DBList2_77 (F2) — toggles the GLOBAL (not per-user) bnkout.OUT_CHIOCE/OUT_CHIO1
     * "#" marker on the catalogue row itself. See the exact state machine quoted in the V29
     * migration comment and in the frontend's hashMarkState doc comment.
     */
    @Transactional
    public RetrievalFieldOption toggleHashMark(String fieldKey) {
        RetrievalFieldEntity f = fieldRepository.findByModuleAndFieldKey(MODULE, fieldKey)
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
                f.isLookupEnabled(), f.getLegacySourceTable(), f.isHashMarked());
    }

    private RetrievalUserFieldEntity findOrCreate(String userNo, String fieldKey) {
        return userFieldRepository.findByUserNoAndFieldKey(userNo, fieldKey)
                .orElseGet(() -> {
                    RetrievalUserFieldEntity e = new RetrievalUserFieldEntity();
                    e.setUserNo(userNo);
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
                orderParts.add(qualify(requireField(key, fields)));
            }
            orderClause = " ORDER BY " + String.join(", ", orderParts);
        }

        String jpql = "SELECT DISTINCT c.appNo, " + String.join(", ", selectParts) + JOIN_SKELETON + whereClause + orderClause;
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
