package com.startupstack.app.modules.retrieval.service;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * Which legacy retrieval screen a request belongs to. Both ARCHIVE.frm menu items open the same
 * sort_form shell, but the global {@code main_form} they set (f2_Click = 1, f3_Click = 2) switches
 * every data source the screen touches (sort_from.frm Form_Load / cmd_result_Click, frm_result.frm
 * Form_Load). Each scope reproduces one of those branches:
 *
 * <ul>
 *   <li>{@link #BANK} — "الاسترجاع البياني لبنك المعلومات" (main_form = 1, var_ist = '01'):
 *       field metadata from {@code bnkout}, per-user marks from {@code view_user_bnkout}, results
 *       from the generated {@code tmp_result} proc, whose captured bodies in macnz_manar_ddl.sql
 *       are all rooted on MAIN joined to ARTICLE / PERIOD / CODING / RES / AUTHER / ANALIS /
 *       FILE_ADD / DIGIT / BOOK.</li>
 *   <li>{@link #ADDITIONAL_FILES} — "استرجاع الملفات الاضافية" (main_form = 2, var_ist = '02'):
 *       field metadata from {@code POUT} (out_ist = '02'), per-user marks from
 *       {@code view_user_pout}, results from {@code tmp_result1}, whose captured bodies are all
 *       rooted on FORM / view_form1 joined to REL_FORM / POSITION / view_pos / SUBJECT — the
 *       form-file domain, never MAIN.</li>
 *   <li>{@link #PERIODICALS} — "استـرجـاع الصحف والمجلات" (f4_Click, main_form = 3, var_ist = '06'):
 *       field metadata from {@code POUT} (out_ist = '06'), per-user marks from
 *       {@code view_user_pout} (user_ist_no '06'), results from {@code tmp_result2}, whose captured
 *       body in macnz_manar_ddl.sql is rooted on PERIOD joined to TRANS (issue arrivals, the
 *       trs_period.frm "برنامج وصول الدوريات" table) and to FORM for the place of issue.</li>
 * </ul>
 *
 * Both legacy branches ran against the same SQL Server database (macnz_manar via the shared
 * {@code cn} rdoConnection / DSN "sqlserver"), so both scopes use the application's single
 * datasource; what differs is the metadata partition, the user-state partition and the join root.
 */
public enum RetrievalScope {

    BANK("GRAPHICAL_RETRIEVAL", "c", "c.appNo",
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
            // FILE_ADD belongs to THIS screen: captured tmp_result bodies join
            // "file_add inner join main on file_add.fad_app_no = main.mn_app_no".
            "LEFT JOIN FileAddEntity fa ON fa.appNo = c.appNo " +
            "LEFT JOIN CatalogueEntity rd ON rd.appNo = fa.fileNo " +
            // DigitEntity.catalogue is an existing @ManyToOne (DIG_NO=MN_APP_NO) — reused here,
            // not a new relationship — to surface "نوع المادة"/"نوع الشريط" (DIGIT.dig_typmat /
            // dig_typchrt), confirmed via Form6.frm's DataGrid DataField bindings + rel_digit_proc.
            "LEFT JOIN DigitEntity dg ON dg.docNo = c.appNo "),

    ADDITIONAL_FILES("ADDITIONAL_FILES_RETRIEVAL", "f", "f.formNo",
            // Root = FORM, with the same joins as the captured tmp_result1 bodies, e.g.
            //   rel_form inner join position on rel_form.rlf_form1 = position.pos_no
            //            left join view_form1 on rel_form.rlf_form1 = view_form1.sub_cod
            //   where rel_form.rlf_form2 = '...'
            //   rel_form inner join subject on rel_form.rlf_form1 = subject.sub_form ...
            //   where ... and subject.sub_mcnz = '...'
            //   from form where form.sub_dte = ...
            // Legacy keyed these joins on view_form1.sub_cod (SUB_TYP + SUB_NO). The migrated
            // schema replaced that composite with a unique form.SUB_NO and enforces it with FKs
            // (REL_FORM.RLF_FORM1/RLF_FORM2 -> form.SUB_NO, SUBJECT.SUB_FORM -> form.SUB_NO,
            // REL_FORM.RLF_FORM1 -> POSITION.POS_NO), so SUB_NO is the join key here — the same
            // key RelFormEntity / SubjectLinkEntity already map.
            " FROM FormEntity f " +
            "LEFT JOIN RelFormEntity rf ON rf.rlfForm1 = f.formNo " +
            "LEFT JOIN FormEntity rf2 ON rf2.formNo = rf.rlfForm2 " +
            "LEFT JOIN PositionEntity pos ON pos.posNo = f.formNo " +
            "LEFT JOIN SubjectLinkEntity sj ON sj.subForm = f.formNo " +
            "LEFT JOIN MacnzEntity sub ON sub.subCode = sj.subMcnz "),

    PERIODICALS("PERIODICALS_RETRIEVAL", "p", "p.perNo",
            // Tables per the captured tmp_result2 body (whose root was PERIOD because its first
            // condition was on PERIOD — see fromClause):
            //   from (period inner join trans on (period.[PER_PER_NO] = trans.[trs_no]))
            //        left join form on period.[per_geo] = form.[sub_typ] + form.[sub_no]
            // TRANS is LEFT-joined. The var_ist = '06' path (view_user_pout / user_ist_no) exists
            // only in the current sort_from.frm, whose cmd_result_Click emits " LEFT JOIN " for the
            // first table pair and " left join " for the rest — it has no INNER JOIN path at all —
            // and that builder demonstrably ran against this database (captured tmp_result body
            // "(res LEFT JOIN main on (...)) left join article on (...)", ddl line ~9615). The
            // captured INNER JOIN tmp_result2 matches the older compiled builds (macnz.exe /
            // new_macnz.exe / MACNZ5.exe: " inner join " sits in the builder's string pool where
            // the source has " LEFT JOIN ", and none of them contains view_user_pout/user_ist_no).
            // PER_GEO is written by PERIOD1.frm's M_PER_GEO DataCombo (BoundColumn = "SUB_NO" over
            // pays_form = form rows with SUB_TYP '04'), and the migrated form.SUB_NO is unique, so
            // SUB_NO alone is the join key — same decision as ADDITIONAL_FILES above.
            // This fixed skeleton serves only the value lookups; searches rebuild the FROM per
            // request exactly like legacy cmd_result_Click — see fromClause below.
            " FROM PeriodicalEntity p " +
            "LEFT JOIN TransEntity t ON t.trsNo = p.perNo " +
            "LEFT JOIN FormEntity g ON g.formNo = p.geo ") {

        /**
         * Legacy sort_from.frm builds the FROM from arr_table: add_question appends each
         * condition's base table (out_select) the first time it appears, in the order the
         * conditions were added; cmd_result_Click then appends the displayed fields' base tables
         * not yet present. arr_table(1) is the FROM root and every later table is chained with
         * " LEFT JOIN ... on (a.[out_rel] = b.[out_rel])" — here PER_PER_NO = trs_no. A single
         * table is selected alone ("tm_innerjoin = arr_table(1)"). Coded display fields
         * (out_nature 2, here per_geo -> form) add " left  join form on period.[per_geo] = ..."
         * after the chain, which is why their base table is PERIOD.
         *
         * With only PERIOD and TRANS as base tables, the root is therefore always the table of
         * the FIRST condition, whatever the display order.
         */
        @Override
        public String fromClause(List<String> conditionAliases, List<String> outputAliases) {
            Set<String> tables = new LinkedHashSet<>();
            conditionAliases.forEach(a -> tables.add(baseTable(a)));
            outputAliases.forEach(a -> tables.add(baseTable(a)));
            List<String> order = new ArrayList<>(tables);
            StringBuilder from = new StringBuilder(" FROM ").append(entity(order.get(0)));
            if (order.size() > 1) {
                from.append("LEFT JOIN ").append(entity(order.get(1))).append("ON t.trsNo = p.perNo ");
            }
            // Legacy joins FORM only for a displayed per_geo; a per_geo condition compares the
            // PERIOD code (see codedCondition), so it brings in PERIOD, not FORM.
            if (outputAliases.contains("g")) {
                from.append("LEFT JOIN FormEntity g ON g.formNo = p.geo ");
            }
            return from.toString();
        }

        /**
         * مكان الصدور is a coded (out_nature 2) POUT field: per_geo is displayed as
         * form.[sub_name] through " left  join form on period.[per_geo] = ..." (captured
         * tmp_result2). As a condition, sort_from.frm fills the c_getcond DataCombo with names
         * (ListField = out_namcod; F8/F9 serh_allform / serh_wrdform set BoundColumn = "sub_cod")
         * and add_question compares the stored code: OUT_scond & c_operation & "'" &
         * c_getcond.BoundText & "'" — i.e. period.[per_geo] = '<code>'. The migrated code is the
         * unique form.SUB_NO, the value PERIOD1.frm's M_PER_GEO writes (BoundColumn = "SUB_NO").
         */
        @Override
        public CodedCondition codedCondition(String fieldKey) {
            return "issue_place".equals(fieldKey) ? new CodedCondition("g.formNo", "p.geo") : null;
        }

        /** Legacy frm_result rows are "select distinct <displayed columns>" — no hidden key. */
        @Override
        public boolean distinctOnOutputOnly() {
            return true;
        }

        private String baseTable(String alias) {
            return switch (alias) {
                case "p", "g" -> "p";
                case "t" -> "t";
                default -> throw new IllegalArgumentException("Unknown periodicals alias: " + alias);
            };
        }

        private String entity(String alias) {
            return "p".equals(alias) ? "PeriodicalEntity p " : "TransEntity t ";
        }
    };

    /** retrieval_field.module / retrieval_user_field.module partition (legacy bnkout vs POUT, user_ist_no). */
    private final String module;
    /** Alias a field with no join_path is qualified against. */
    private final String rootAlias;
    /** JPQL expression for the row key returned with every result row. */
    private final String rootKey;
    private final String joinSkeleton;

    RetrievalScope(String module, String rootAlias, String rootKey, String joinSkeleton) {
        this.module = module;
        this.rootAlias = rootAlias;
        this.rootKey = rootKey;
        this.joinSkeleton = joinSkeleton;
    }

    public String module() { return module; }
    public String rootAlias() { return rootAlias; }
    public String rootKey() { return rootKey; }
    public String joinSkeleton() { return joinSkeleton; }

    /**
     * FROM/JOIN clause for one search, given the table aliases of the condition fields (in the
     * order the conditions were added) and of the output fields. Defaults to the fixed skeleton.
     */
    public String fromClause(List<String> conditionAliases, List<String> outputAliases) {
        return joinSkeleton;
    }

    /**
     * Legacy coded condition (out_nature 2): the user picks a name but the query compares the
     * code. {@code codeColumn} is the code behind each pickable name in the lookup source,
     * {@code conditionColumn} the stored column the condition compares. Null when not coded.
     */
    public CodedCondition codedCondition(String fieldKey) {
        return null;
    }

    public record CodedCondition(String codeColumn, String conditionColumn) {
        /** Table alias of the compared column. */
        public String conditionAlias() {
            return conditionColumn.substring(0, conditionColumn.indexOf('.'));
        }
    }

    /** True when SELECT DISTINCT must cover only the output columns (no root key column). */
    public boolean distinctOnOutputOnly() {
        return false;
    }
}
