package com.startupstack.app.modules.retrievalbuild.repository;

import com.startupstack.app.shared.exception.BusinessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Direct table access for Form4 ("ملف بناء الاسترجاعات") and CAT_OUTFRM ("معالجة حقول الاسترجاع").
 * Both legacy forms bind grids straight to bnkout / pout / catogorie (MSRDC / Adodc recordsets), so
 * edits go to the tables as typed; values are cast to each column's own type, an empty cell is NULL.
 */
@Repository
public class RetrievalBuildRepository {

    /** Form4's two recordsets: "select * from pout order by out_ist", "select * from bnkout order by out_num". */
    public static final Map<String, String[]> FORM4_TABLES = Map.of(
            "pout", new String[] {"\"POUT\"", "POUT", "lower(\"OUT_IST\")"},
            "bnkout", new String[] {"bnkout", "bnkout", "\"OUT_NUM\""});

    /** CAT_OUTFRM DataGrid1 editable columns (Column02-04; 00 المتسلسل and 01 اسم الحقل are Locked). */
    public static final Map<String, String> FIELD_COLUMNS = Map.of(
            "OUT_INDX", "OUT_INDX", "OUT_INDX3", "OUT_INDX3", "out_cond", "OUT_COND");

    private static final String FIELD_SELECT =
            "SELECT b.\"OUT_NUM\", b.\"OUT_COND\" AS out_cond, b.\"OUT_DESC\", b.\"OUT_INDX\", b.\"OUT_INDX3\", "
                    + "b.\"OUT_CAT\", c.\"SUB_DESC\" AS desc_cat FROM bnkout b "
                    + "LEFT OUTER JOIN \"CODING\" c ON '37' || b.\"OUT_CAT\" = c.\"SUB_CODE\" ";

    private final NamedParameterJdbcTemplate jdbc;

    public RetrievalBuildRepository(NamedParameterJdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    // ---------------- generic column metadata ----------------

    /** Column name → PostgreSQL type (udt_name), in table order. */
    public Map<String, String> columns(String tableName) {
        Map<String, String> cols = new LinkedHashMap<>();
        jdbc.query("SELECT column_name, udt_name FROM information_schema.columns "
                        + "WHERE table_schema = 'public' AND table_name = :t ORDER BY ordinal_position",
                new MapSqlParameterSource("t", tableName),
                rs -> { cols.put(rs.getString(1), rs.getString(2)); });
        return cols;
    }

    private static String q(String identifier) {
        return "\"" + identifier.replace("\"", "\"\"") + "\"";
    }

    /** Text typed in a cell → the column's type; empty → NULL. */
    private static Object value(String text) {
        return text == null || text.isEmpty() ? null : text;
    }

    // ---------------- Form4 ----------------

    public List<Map<String, Object>> form4Rows(String key) {
        String[] t = form4(key);
        return jdbc.queryForList("SELECT * FROM " + t[0] + " ORDER BY " + t[2] + ", auto",
                new MapSqlParameterSource());
    }

    public int form4Update(String key, int auto, String column, String text) {
        String[] t = form4(key);
        String type = columns(t[1]).get(column);
        if (type == null || column.equalsIgnoreCase("auto")) throw new BusinessException("عمود غير معروف");
        return jdbc.update("UPDATE " + t[0] + " SET " + q(column) + " = CAST(:v AS " + type + ") WHERE auto = :a",
                new MapSqlParameterSource("v", value(text)).addValue("a", auto));
    }

    private static String[] form4(String key) {
        String[] t = FORM4_TABLES.get(key);
        if (t == null) throw new BusinessException("جدول غير معروف");
        return t;
    }

    // ---------------- CAT_OUTFRM DataGrid1 (f_tmp over bnkout + CODING '37') ----------------

    /** Form_Load: no filter; Check1 "حقول العرض": OUT_CHIOCE > 0; Check2 "اسئلة الاسترجاع": OUT_IF > 0. */
    public List<Map<String, Object>> fields(String filter) {
        String where = switch (filter == null ? "" : filter) {
            case "DISPLAY" -> "WHERE b.\"OUT_CHIOCE\" > 0 ";
            // OUT_IF is varchar; SQL Server converted it to a number for "OUT_IF > 0"
            case "QUESTIONS" -> "WHERE trim(b.\"OUT_IF\") ~ '^-?[0-9]+(\\.[0-9]+)?$' AND CAST(trim(b.\"OUT_IF\") AS numeric) > 0 ";
            default -> "";
        };
        return jdbc.queryForList(FIELD_SELECT + where + "ORDER BY b.\"OUT_NUM\", b.auto", new MapSqlParameterSource());
    }

    public int updateField(double outNum, String column, String text) {
        String target = FIELD_COLUMNS.get(column);
        if (target == null) throw new BusinessException("هذا العمود للقراءة فقط");
        String type = columns("bnkout").get(target);
        return jdbc.update("UPDATE bnkout SET " + q(target) + " = CAST(:v AS " + type + ") WHERE \"OUT_NUM\" = :n",
                new MapSqlParameterSource("v", value(text)).addValue("n", outNum));
    }

    /** DataGrid1 AllowAddNew: the editable columns typed on the new row. */
    public void insertField(Map<String, String> values) {
        Map<String, String> types = columns("bnkout");
        StringBuilder cols = new StringBuilder();
        StringBuilder vals = new StringBuilder();
        MapSqlParameterSource p = new MapSqlParameterSource();
        int i = 0;
        for (Map.Entry<String, String> e : values.entrySet()) {
            String target = FIELD_COLUMNS.get(e.getKey());
            if (target == null || e.getValue() == null || e.getValue().isEmpty()) continue;
            if (i > 0) { cols.append(", "); vals.append(", "); }
            cols.append(q(target));
            vals.append("CAST(:v").append(i).append(" AS ").append(types.get(target)).append(")");
            p.addValue("v" + i, e.getValue());
            i++;
        }
        if (i == 0) return;
        jdbc.update("INSERT INTO bnkout (" + cols + ") VALUES (" + vals + ")", p);
    }

    /** DataGrid1 AllowDelete: the bnkout row behind the grid row. */
    public int deleteField(double outNum) {
        return jdbc.update("DELETE FROM bnkout WHERE \"OUT_NUM\" = :n", new MapSqlParameterSource("n", outNum));
    }

    /** upd_OUT_CAT @m_num, @M_OUT_CAT: update bnkout set OUT_CAT = @M_OUT_CAT where out_num = @m_num */
    public int updateFieldCategory(double outNum, String category) {
        return jdbc.update("UPDATE bnkout SET \"OUT_CAT\" = CAST(:c AS bpchar) WHERE \"OUT_NUM\" = :n",
                new MapSqlParameterSource("c", category).addValue("n", outNum));
    }

    // ---------------- categories (VIEW_coding37, proc_catogorie, insr_catogorie) ----------------

    /** VIEW_CODING37: CODING where SUBSTRING(SUB_CODE,1,2) = '37'. */
    public List<Map<String, Object>> categories() {
        return jdbc.queryForList("SELECT \"SUB_CODE\" AS sub_code, \"SUB_DESC\" AS sub_desc FROM \"CODING\" "
                + "WHERE substring(\"SUB_CODE\", 1, 2) = '37' ORDER BY \"SUB_CODE\"", new MapSqlParameterSource());
    }

    /** proc_catogorie @m_cat_no: catogorie ⟕ CODING('37'+cat_no) ⟕ bnkout(OUT_NUM = cat_num) where cat_no = @m_cat_no */
    public List<Map<String, Object>> categoryFields(String catNo) {
        return jdbc.queryForList("SELECT k.auto, k.cat_num, c.\"SUB_DESC\" AS desc_cat, k.cat_no, b.\"OUT_DESC\" AS desc_out "
                        + "FROM catogorie k LEFT JOIN \"CODING\" c ON '37' || k.cat_no = c.\"SUB_CODE\" "
                        + "LEFT JOIN bnkout b ON b.\"OUT_NUM\" = k.cat_num WHERE k.cat_no = CAST(:c AS bpchar) ORDER BY k.auto",
                new MapSqlParameterSource("c", catNo));
    }

    /** insr_catogorie @m_code: insert into catogorie (cat_no) values (@m_code) */
    public void insertCategoryField(String catNo) {
        jdbc.update("INSERT INTO catogorie (cat_no) VALUES (CAST(:c AS bpchar))", new MapSqlParameterSource("c", catNo));
    }

    /** DataGrid2 AllowAddNew (the "*" line): the typed رقم الحقل / cat_no; cat_no defaults to the open category. */
    public void insertCategoryRow(String catNo, String catNum) {
        jdbc.update("INSERT INTO catogorie (cat_no, cat_num) VALUES (CAST(:c AS bpchar), CAST(:n AS int4))",
                new MapSqlParameterSource("c", catNo).addValue("n", catNum == null || catNum.isEmpty() ? null : catNum));
    }

    /** DataGrid2 cells: cat_num, cat_no (catogorie) and desc_out (bnkout.OUT_DESC of cat_num). */
    public int updateCategoryField(int auto, String column, String text) {
        MapSqlParameterSource p = new MapSqlParameterSource("v", value(text)).addValue("a", auto);
        return switch (column) {
            case "cat_num" -> jdbc.update("UPDATE catogorie SET cat_num = CAST(:v AS int4) WHERE auto = :a", p);
            case "cat_no" -> jdbc.update("UPDATE catogorie SET cat_no = CAST(:v AS bpchar) WHERE auto = :a", p);
            case "desc_out" -> jdbc.update("UPDATE bnkout SET \"OUT_DESC\" = CAST(:v AS "
                    + columns("bnkout").get("OUT_DESC") + ") WHERE \"OUT_NUM\" = (SELECT cat_num FROM catogorie WHERE auto = :a)", p);
            default -> throw new BusinessException("هذا العمود للقراءة فقط");
        };
    }

    public int deleteCategoryField(int auto) {
        return jdbc.update("DELETE FROM catogorie WHERE auto = :a", new MapSqlParameterSource("a", auto));
    }
}
