package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.reports.dto.ColumnMeta;
import com.startupstack.app.modules.reports.dto.TemplateExecutionResponse;
import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import com.startupstack.app.modules.reports.repository.ReportTemplateRepository;
import com.startupstack.app.shared.exception.ReportGenerationException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

/**
 * Executes a bnkout report template at runtime.
 *
 * Each bnkout row (sharing the same OUT_NUM) represents one output column.
 * The service reconstructs the VB6 dynamic SQL pattern:
 *   SELECT DISTINCT [fields] FROM [joined tables] WHERE [conditions] ORDER BY [index]
 *
 * Security: all table/column identifiers from bnkout are validated against a
 * whitelist and an injection blocklist before being embedded in the SQL string.
 * User-supplied filter values are always bound via named parameters.
 */
@Service
@Transactional(readOnly = true)
public class TemplateExecutionService {

    // All tables present in macnz_manar_postgres.sql (lower-cased for lookup)
    private static final Set<String> ALLOWED_TABLES = Set.of(
            "main", "book", "article", "news", "period", "auther",
            "person", "person1", "macnz", "charit", "opr_chrt", "istara",
            "digit", "form", "form1", "sites", "posts", "position",
            "bnkout", "pout", "pout1", "result", "demand", "coding",
            "arrays", "arrays1", "res"
    );

    // Detects SQL injection patterns that must never appear in bnkout condition fields
    private static final Pattern INJECTION = Pattern.compile(
            "(?i)(;|--|/\\*|\\*/|\\bxp_|\\bexec\\b|\\bexecute\\b|\\bdrop\\b" +
            "|\\btruncate\\b|\\bdelete\\b|\\binsert\\b|\\bupdate\\b|\\bcreate\\b" +
            "|\\balter\\b|\\bunion\\b|\\bsleep\\b|\\bwaitfor\\b" +
            "|\\bchar\\s*\\(|0x[0-9a-fA-F]+)"
    );

    // A safe SQL identifier: letter/underscore start, alphanumeric/underscore body
    private static final Pattern SAFE_IDENT = Pattern.compile("[A-Za-z_][A-Za-z0-9_]*");

    private final ReportTemplateRepository templateRepository;
    private final EntityManager entityManager;

    public TemplateExecutionService(ReportTemplateRepository templateRepository,
                                    EntityManager entityManager) {
        this.templateRepository = templateRepository;
        this.entityManager      = entityManager;
    }

    /**
     * @param templateNum OUT_NUM value identifying the bnkout template
     * @param userFilters query-param filters supplied by the caller (safely parameterized)
     */
    public TemplateExecutionResponse execute(Integer templateNum, Map<String, String> userFilters) {
        List<ReportTemplateEntity> rows =
                templateRepository.findByOutputNumOrderByIdAsc((double) templateNum);
        if (rows.isEmpty()) {
            throw new ResourceNotFoundException(
                    "No bnkout template found for report number: " + templateNum);
        }

        String reportTitle = firstNonBlank(rows.get(0).getDescription(), "Report " + templateNum);

        // ── Column / table collection ──────────────────────────────────────────
        List<String>        selectParts  = new ArrayList<>();
        List<ColumnMeta>    columns      = new ArrayList<>();

        // Primary source tables (ordered, deduplicated)
        List<String>        primaryTables = new ArrayList<>();
        Map<String, String> tableRelKey   = new LinkedHashMap<>();   // table → OUT_REL join field
        Set<String>         seenPrimary   = new LinkedHashSet<>();

        // nature=2 lookup joins: [lookupTable, ON-condition]
        List<String[]>      lookupJoins   = new ArrayList<>();
        Set<String>         seenLookups   = new LinkedHashSet<>();

        String       orderBy        = null;
        List<String> fixedConditions = new ArrayList<>();
        Set<String>  seenConditions  = new LinkedHashSet<>();

        for (ReportTemplateEntity row : rows) {

            // ── Primary source table ────────────────────────────────────────
            String srcTable = trimmed(row.getSelectClause());   // OUT_SELECT
            if (srcTable != null) {
                String lower = srcTable.toLowerCase();
                if (ALLOWED_TABLES.contains(lower) && seenPrimary.add(lower)) {
                    primaryTables.add(srcTable);
                    String rel = trimmed(row.getRelation());     // OUT_REL
                    if (rel != null && isSafeIdent(rel)) {
                        tableRelKey.put(srcTable, rel);
                    }
                }
            }

            // ── SELECT field expression ─────────────────────────────────────
            String nature    = trimmed(row.getNature());            // OUT_NATURE
            String alias     = trimmed(row.getName());              // OUT_NAME
            String label     = firstNonBlank(row.getDescription(), alias);
            int    width     = row.getLength1() != null ? row.getLength1().intValue()
                             : row.getLength()  != null ? row.getLength().intValue() : 100;

            if ("2".equals(nature)) {
                // Lookup join: LEFT JOIN out_slct1 ON (out_scond1), display out_namcod
                String lookupTable = trimmed(row.getSelectClause1()); // OUT_SLCT1
                String joinCond    = trimmed(row.getSubCondition1()); // OUT_SCOND1
                String displayFld  = trimmed(row.getCodeName());      // OUT_NAMCOD

                if (lookupTable != null
                        && ALLOWED_TABLES.contains(lookupTable.toLowerCase())
                        && seenLookups.add(lookupTable.toLowerCase())
                        && joinCond != null && isSafeFragment(joinCond)
                        && displayFld != null && isSafeIdent(displayFld)) {
                    lookupJoins.add(new String[]{lookupTable, bracketToQuote(joinCond)});
                }

                if (alias != null && lookupTable != null && displayFld != null
                        && isSafeIdent(displayFld)) {
                    selectParts.add(
                            "\"" + lookupTable + "\".\"" + displayFld + "\" AS \"" + alias + "\"");
                    columns.add(new ColumnMeta(alias, label, width));
                }

            } else {
                // Regular field: OUT_SCOND is the table-qualified field expression
                String fieldExpr = toPostgresExpr(row.getSubCondition()); // OUT_SCOND
                if (fieldExpr != null && alias != null) {
                    selectParts.add(fieldExpr + " AS \"" + alias + "\"");
                    columns.add(new ColumnMeta(alias, label, width));
                }
            }

            // ── Fixed WHERE conditions ──────────────────────────────────────
            addCondition(fixedConditions, seenConditions, row.getMainCondition());  // OUT_MCOND
            addCondition(fixedConditions, seenConditions, row.getMainCondition1()); // OUT_MCOND1
            addCondition(fixedConditions, seenConditions, row.getMainCondition2()); // OUT_MCOND2
            addCondition(fixedConditions, seenConditions, row.getSubCondition2());  // OUT_SCOND2
            addCondition(fixedConditions, seenConditions, row.getCondition());      // OUT_COND

            // ── ORDER BY ───────────────────────────────────────────────────
            if (orderBy == null) {
                String idx = toPostgresExpr(row.getIndex()); // OUT_INDX
                if (idx != null) orderBy = idx;
            }
        }

        // ── Fallback if template rows yielded nothing usable ───────────────
        if (primaryTables.isEmpty()) primaryTables.add("main");
        if (selectParts.isEmpty()) {
            selectParts.add("\"main\".\"MN_APP_NO\" AS \"MN_APP_NO\"");
            selectParts.add("\"main\".\"MN_ACT_TTL\" AS \"MN_ACT_TTL\"");
            columns.add(new ColumnMeta("MN_APP_NO", "App No", 80));
            columns.add(new ColumnMeta("MN_ACT_TTL", "Title", 200));
        }

        // ── Build SQL ──────────────────────────────────────────────────────
        String fromClause = buildFrom(primaryTables, tableRelKey, lookupJoins);

        List<String>        allConditions = new ArrayList<>(fixedConditions);
        Map<String, Object> params        = new HashMap<>();
        int                 pidx          = 0;

        for (Map.Entry<String, String> f : userFilters.entrySet()) {
            String col = f.getKey();
            String val = f.getValue();
            if (val != null && !val.isBlank() && isAllowedFilterCol(col)) {
                String paramName = "p" + pidx++;
                // table.col → "table"."col"; bare col → "col"
                String colRef = col.contains(".")
                        ? "CAST(\"" + col.replace(".", "\".\"") + "\" AS TEXT)"
                        : "CAST(\"" + col + "\" AS TEXT)";
                allConditions.add(colRef + " ILIKE :" + paramName);
                params.put(paramName, "%" + val.trim() + "%");
            }
        }

        StringBuilder sql = new StringBuilder("SELECT DISTINCT ")
                .append(String.join(", ", selectParts))
                .append(" FROM ")
                .append(fromClause);

        if (!allConditions.isEmpty()) {
            sql.append(" WHERE ").append(String.join(" AND ", allConditions));
        }
        if (orderBy != null) {
            sql.append(" ORDER BY ").append(orderBy);
        }
        sql.append(" LIMIT 1000");

        // ── Execute ────────────────────────────────────────────────────────
        try {
            Query nativeQuery = entityManager.createNativeQuery(sql.toString());
            params.forEach(nativeQuery::setParameter);

            @SuppressWarnings("unchecked")
            List<?> rawList = nativeQuery.getResultList();

            List<Map<String, Object>> resultRows = new ArrayList<>(rawList.size());
            for (Object raw : rawList) {
                Map<String, Object> rowMap = new LinkedHashMap<>();
                if (raw instanceof Object[] arr) {
                    for (int i = 0; i < columns.size() && i < arr.length; i++) {
                        rowMap.put(columns.get(i).fieldName(),
                                   arr[i] != null ? arr[i].toString().strip() : null);
                    }
                } else if (columns.size() == 1) {
                    rowMap.put(columns.get(0).fieldName(),
                               raw != null ? raw.toString().strip() : null);
                }
                resultRows.add(rowMap);
            }

            return new TemplateExecutionResponse(
                    templateNum, reportTitle, columns, resultRows, resultRows.size());

        } catch (Exception e) {
            throw new ReportGenerationException(
                    "Failed to execute template " + templateNum + ": " + e.getMessage(), e);
        }
    }

    // ── SQL building helpers ───────────────────────────────────────────────

    private String buildFrom(List<String> primaryTables,
                             Map<String, String> tableRelKey,
                             List<String[]> lookupJoins) {
        StringBuilder from = new StringBuilder("\"").append(primaryTables.get(0)).append("\"");

        for (int i = 1; i < primaryTables.size(); i++) {
            String prev    = primaryTables.get(i - 1);
            String curr    = primaryTables.get(i);
            String relPrev = tableRelKey.get(prev);
            String relCurr = tableRelKey.get(curr);
            from.append(" LEFT JOIN \"").append(curr).append("\"");
            if (relPrev != null && relCurr != null
                    && isSafeIdent(relPrev) && isSafeIdent(relCurr)) {
                from.append(" ON (\"").append(prev).append("\".\"").append(relPrev)
                    .append("\" = \"").append(curr).append("\".\"").append(relCurr).append("\")");
            } else {
                // No join key found — safe no-op join (let DB optimizer handle it)
                from.append(" ON (1=1)");
            }
        }

        for (String[] join : lookupJoins) {
            from.append(" LEFT JOIN \"").append(join[0])
                .append("\" ON (").append(join[1]).append(")");
        }

        return from.toString();
    }

    /**
     * Converts a VB6/SQL Server bracket-notation field expression to PostgreSQL form.
     *   "main.[MN_ACT_TTL]" → "main"."MN_ACT_TTL"
     *   "[MN_ACT_TTL]"      → "MN_ACT_TTL"
     *   "MN_ACT_TTL"        → "MN_ACT_TTL"
     * Returns null if the expression contains unsafe characters.
     */
    private String toPostgresExpr(String raw) {
        if (raw == null || raw.isBlank()) return null;
        String clean = raw.trim();
        if (INJECTION.matcher(clean).find()) return null;

        // Strip brackets to expose the plain identifier structure
        String plain = clean.replace("[", "").replace("]", "").trim();

        if (plain.contains(".")) {
            String[] parts = plain.split("\\.", 2);
            String tbl = parts[0].trim();
            String col = parts[1].trim();
            if (SAFE_IDENT.matcher(tbl).matches() && SAFE_IDENT.matcher(col).matches()) {
                return "\"" + tbl + "\".\"" + col + "\"";
            }
            return null;
        }

        if (SAFE_IDENT.matcher(plain).matches()) return "\"" + plain + "\"";
        return null;
    }

    /**
     * Converts VB bracket notation inside a condition/join string to PostgreSQL
     * double-quote notation without changing the logical structure of the expression.
     *   "main.[MN_APP_NO] = BOOK.[BK_APP_NO]"
     *   → "main"."MN_APP_NO" = "BOOK"."BK_APP_NO"
     */
    private String bracketToQuote(String cond) {
        if (cond == null) return null;
        // table.[col] → "table"."col"
        String result = cond.replaceAll(
                "([A-Za-z_]\\w*)\\.\\[([A-Za-z_]\\w*)\\]", "\"$1\".\"$2\"");
        // standalone [col] → "col"
        return result.replaceAll("\\[([A-Za-z_]\\w*)\\]", "\"$1\"");
    }

    private void addCondition(List<String> conditions, Set<String> seen, String raw) {
        if (raw == null || raw.isBlank()) return;
        String clean = bracketToQuote(raw.trim());
        if (clean == null) return;
        String upper = clean.toUpperCase().replaceAll("\\s+", " ");
        if (upper.equals("1 = 1") || upper.equals("1=1")) return;
        if (INJECTION.matcher(clean).find()) return;
        if (!seen.add(clean)) return;   // deduplicate
        conditions.add(clean);
    }

    private boolean isSafeIdent(String s) {
        return s != null && !s.isBlank() && SAFE_IDENT.matcher(s.trim()).matches();
    }

    private boolean isSafeFragment(String s) {
        return s != null && !s.isBlank() && !INJECTION.matcher(s).find();
    }

    private boolean isAllowedFilterCol(String col) {
        if (col == null || col.isBlank()) return false;
        // Allow bare identifier or table.column; reject anything else
        return col.matches("[A-Za-z_][A-Za-z0-9_.]*")
                && !INJECTION.matcher(col).find();
    }

    private String trimmed(String s) {
        return (s == null || s.isBlank()) ? null : s.trim();
    }

    private String firstNonBlank(String a, String b) {
        return (a != null && !a.isBlank()) ? a.trim() : b;
    }
}
