package com.startupstack.app.modules.configusers.repository;

import com.startupstack.app.modules.configusers.dto.FieldRow;
import com.startupstack.app.modules.configusers.dto.FormTypeRow;
import com.startupstack.app.modules.configusers.dto.RangeRow;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * The statements behind "معالجة المستخدمين" (legacy config_users.frm): the RESULT, t_bnkout, ranj,
 * coding38, BNKOUT2 and pout1 data controls, the procs they execute, and the writes ADO made for the
 * DataGrid edits. config has no key in legacy, so a config row is addressed by all its original
 * column values, as ADO did.
 */
@Repository
public class ConfigUsersRepository {

    /** config columns (select config.* from config) and the PostgreSQL type each one is compared as. */
    public static final Map<String, String> CONFIG_COLUMNS = new LinkedHashMap<>();

    static {
        CONFIG_COLUMNS.put("user_no", "bpchar");
        CONFIG_COLUMNS.put("user_name", "bpchar");
        CONFIG_COLUMNS.put("user_password", "varchar");
        CONFIG_COLUMNS.put("user_cnf_path", "bpchar");
        CONFIG_COLUMNS.put("user_start", "integer");
        CONFIG_COLUMNS.put("USER_PWD", "integer");
        CONFIG_COLUMNS.put("user_cmpvd", "bpchar");
        CONFIG_COLUMNS.put("user_video_path", "bpchar");
        CONFIG_COLUMNS.put("user_company", "integer");
        CONFIG_COLUMNS.put("user_video_path1", "bpchar");
        CONFIG_COLUMNS.put("SITE_WLY", "integer");
        CONFIG_COLUMNS.put("user_level", "bpchar");
        CONFIG_COLUMNS.put("user_permition", "integer");
        CONFIG_COLUMNS.put("user_ent", "bpchar");
        CONFIG_COLUMNS.put("user_doc", "bpchar");
    }

    /** DataGrid2 columns (rjp_no is the hidden identity). */
    public static final List<String> RANGE_COLUMNS = List.of("rjp_nofrom", "rjp_noto", "rjp_path", "rjp_typ");

    private static final RowMapper<FieldRow> FIELD = (rs, i) -> new FieldRow(
            rs.getString("user_ist_no"), rs.getString("user_no"), (Integer) rs.getObject("user_out_num", Integer.class),
            rs.getString("user_out_desc"), (Integer) rs.getObject("user_out_choice", Integer.class),
            rs.getString("user_out_index"));

    private static final RowMapper<RangeRow> RANGE = (rs, i) -> new RangeRow(
            (Integer) rs.getObject("rjp_no", Integer.class), rs.getString("rjp_nofrom"), rs.getString("rjp_noto"),
            rs.getString("rjp_path"), (Integer) rs.getObject("rjp_typ", Integer.class));

    private final NamedParameterJdbcTemplate jdbc;

    public ConfigUsersRepository(NamedParameterJdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    private static String q(String column) {
        return column.equals(column.toLowerCase()) ? column : "\"" + column + "\"";
    }

    // ─── coding38: SELECT * FROM VIEW_CODING38 ───

    public List<FormTypeRow> formTypes() {
        return jdbc.query("SELECT \"SUB_CODE\", \"SUB_DESC\" FROM \"CODING\" "
                        + "WHERE substring(\"SUB_CODE\", 1, 2) = '38' AND \"SUB_LEVE\" = '2'",
                new MapSqlParameterSource(), (rs, i) -> new FormTypeRow(rs.getString(1), rs.getString(2)));
    }

    // ─── RESULT: select config.* from config ───

    public List<Map<String, Object>> configRows() {
        String cols = CONFIG_COLUMNS.keySet().stream().map(c -> q(c) + " AS \"" + c + "\"").collect(Collectors.joining(", "));
        return jdbc.queryForList("SELECT " + cols + " FROM config", new MapSqlParameterSource());
    }

    /** ADO update of one config field, the row located by every original column value. */
    public int updateConfig(String column, Object value, Map<String, Object> original) {
        MapSqlParameterSource p = matchConfig(original).addValue("v", value);
        return jdbc.update("UPDATE config SET " + q(column) + " = :v WHERE " + whereConfig(), p);
    }

    /** Duplicate guard formerly done by UNIQUE (user_no); the legacy table has no key. */
    public boolean userNoExists(Object userNo) {
        Integer n = jdbc.queryForObject("SELECT count(*) FROM config WHERE user_no = CAST(:u AS bpchar)",
                new MapSqlParameterSource("u", userNo == null ? null : userNo.toString()), Integer.class);
        return n != null && n > 0;
    }

    /** Duplicate guard formerly done by user_bnkout's primary key (user_ist_no, user_no, user_out_num). */
    public boolean userFieldExists(String userNo, int outNum, String istNo) {
        Integer n = jdbc.queryForObject("SELECT count(*) FROM user_bnkout WHERE lower(user_no) = lower(CAST(:u AS bpchar)) "
                + "AND lower(user_ist_no) = lower(CAST(:i AS bpchar)) AND user_out_num = :n",
                userParams(userNo, istNo).addValue("n", outNum), Integer.class);
        return n != null && n > 0;
    }

    /** DataGrid1 AllowAddNew: the filled columns inserted, the others NULL. */
    public void insertConfig(Map<String, Object> values) {
        MapSqlParameterSource p = new MapSqlParameterSource();
        List<String> cols = new ArrayList<>(values.keySet());
        for (int i = 0; i < cols.size(); i++) {
            p.addValue("v" + i, values.get(cols.get(i)));
        }
        jdbc.update("INSERT INTO config (" + cols.stream().map(ConfigUsersRepository::q).collect(Collectors.joining(", "))
                + ") VALUES (" + java.util.stream.IntStream.range(0, cols.size()).mapToObj(i -> ":v" + i)
                .collect(Collectors.joining(", ")) + ")", p);
    }

    /** DataGrid1 AllowDelete. */
    public int deleteConfig(Map<String, Object> original) {
        return jdbc.update("DELETE FROM config WHERE " + whereConfig(), matchConfig(original));
    }

    private static String whereConfig() {
        List<String> parts = new ArrayList<>();
        int i = 0;
        for (Map.Entry<String, String> c : CONFIG_COLUMNS.entrySet()) {
            parts.add(q(c.getKey()) + " IS NOT DISTINCT FROM CAST(:o" + i++ + " AS " + c.getValue() + ")");
        }
        return String.join(" AND ", parts);
    }

    private static MapSqlParameterSource matchConfig(Map<String, Object> original) {
        MapSqlParameterSource p = new MapSqlParameterSource();
        int i = 0;
        for (Map.Entry<String, String> c : CONFIG_COLUMNS.entrySet()) {
            Object v = original.get(c.getKey());
            if ("integer".equals(c.getValue()) && v instanceof Number n) v = n.intValue();
            else if (v != null && !"integer".equals(c.getValue())) v = v.toString();
            p.addValue("o" + i++, v);
        }
        return p;
    }

    // ─── t_bnkout ───

    /** Form_Load RecordSource: select user_no, user_out_num, user_out_desc, user_out_choice, user_out_index from view_user_bnkout */
    public List<FieldRow> allUserFields() {
        return jdbc.query("SELECT u.user_ist_no, u.user_no, u.user_out_num, b.\"OUT_DESC\" AS user_out_desc, "
                + "u.user_out_choice, u.user_index AS user_out_index "
                + "FROM bnkout b JOIN user_bnkout u ON b.\"OUT_NUM\" = u.user_out_num", new MapSqlParameterSource(), FIELD);
    }

    /** execute proc_user_bnkout @m_user_no char(3), @m_user_ist_no char(2) — order by user_out_index */
    public List<FieldRow> procUserBnkout(String userNo, String istNo) {
        return jdbc.query("SELECT u.user_ist_no, u.user_no, u.user_out_num, b.\"OUT_DESC\" AS user_out_desc, "
                + "u.user_out_choice, u.user_index AS user_out_index "
                + "FROM bnkout b JOIN user_bnkout u ON b.\"OUT_NUM\" = u.user_out_num "
                + "WHERE lower(u.user_no) = lower(CAST(:u AS bpchar)) AND lower(u.user_ist_no) = lower(CAST(:i AS bpchar)) "
                + "ORDER BY lower(u.user_index) NULLS FIRST", userParams(userNo, istNo), FIELD);
    }

    /** execute proc_user_pout @m_user_no char(3), @m_user_ist_no char(2) — pout joined on out_ist too */
    public List<FieldRow> procUserPout(String userNo, String istNo) {
        return jdbc.query("SELECT u.user_ist_no, u.user_no, u.user_out_num, p.\"OUT_DESC\" AS user_out_desc, "
                + "u.user_out_choice, u.user_index AS user_out_index "
                + "FROM \"POUT\" p JOIN user_bnkout u ON p.\"OUT_NUM\" = u.user_out_num "
                + "AND lower(rtrim(p.\"OUT_IST\")) = lower(rtrim(u.user_ist_no)) "
                + "WHERE lower(u.user_no) = lower(CAST(:u AS bpchar)) AND lower(u.user_ist_no) = lower(CAST(:i AS bpchar)) "
                + "ORDER BY lower(u.user_index) NULLS FIRST", userParams(userNo, istNo), FIELD);
    }

    /** execute serh_user_bnkout: select user_bnkout.* where user_no = @m_user_no and user_ist_no = @m_user_ist_no */
    public int countUserFields(String userNo, String istNo) {
        Integer n = jdbc.queryForObject("SELECT count(*) FROM user_bnkout "
                + "WHERE lower(user_no) = lower(CAST(:u AS bpchar)) AND lower(user_ist_no) = lower(CAST(:i AS bpchar))",
                userParams(userNo, istNo), Integer.class);
        return n == null ? 0 : n;
    }

    /** BNKOUT2: SELECT * FROM bnkout where out_chioce = 1 or out_chioce = 2 — (out_num, out_indx3) */
    public List<Object[]> bnkoutChoices() {
        return jdbc.query("SELECT \"OUT_NUM\", \"OUT_INDX3\" FROM bnkout WHERE \"OUT_CHIOCE\" = 1 OR \"OUT_CHIOCE\" = 2",
                new MapSqlParameterSource(), (rs, i) -> new Object[]{rs.getObject(1), rs.getObject(2)});
    }

    /** pout1: SELECT * FROM pout where (out_chioce = 1 or out_chioce = 2) and out_ist = <ist> (a numeric comparison) */
    public List<Object[]> poutChoices(int ist) {
        return jdbc.query("SELECT \"OUT_NUM\", \"OUT_INDX3\" FROM \"POUT\" WHERE (\"OUT_CHIOCE\" = 1 OR \"OUT_CHIOCE\" = 2) "
                        + "AND \"OUT_IST\" ~ '^\\s*[+-]?[0-9]+\\s*$' AND CAST(trim(\"OUT_IST\") AS integer) = :ist",
                new MapSqlParameterSource("ist", ist), (rs, i) -> new Object[]{rs.getObject(1), rs.getObject(2)});
    }

    /** insr_user_bnkout: insert into user_bnkout values (@m_user_no, @m_out_num, 2, @m_out_index, ' ', @m_user_ist_no, 2) */
    public void insertUserField(String userNo, int outNum, String outIndex, String istNo) {
        jdbc.update("INSERT INTO user_bnkout (user_no, user_out_num, user_out_choice, user_index, user_sing, user_ist_no, user_out_choi1) "
                        + "VALUES (:u, :n, 2, :x, ' ', :i, 2)",
                userParams(userNo, istNo).addValue("n", outNum).addValue("x", outIndex));
    }

    /** del_user_bnkout @m_user_no, @m_user_ist_no — the display fields serh_user_bnkout finds. */
    public int deleteUserFields(String userNo, String istNo) {
        return jdbc.update("DELETE FROM user_bnkout "
                + "WHERE lower(user_no) = lower(CAST(:u AS bpchar)) AND lower(user_ist_no) = lower(CAST(:i AS bpchar))",
                userParams(userNo, istNo));
    }

    /** DataGrid3 cell edit: user_out_choice / user_out_index are user_bnkout.user_out_choice / user_index. */
    public int updateUserField(String column, Object value, FieldRow row) {
        return jdbc.update("UPDATE user_bnkout SET " + column + " = :v WHERE user_ist_no = CAST(:i AS bpchar) "
                        + "AND user_no = CAST(:u AS bpchar) AND user_out_num = :n",
                userParams(row.userNo(), row.istNo()).addValue("n", row.outNum()).addValue("v", value));
    }

    private static MapSqlParameterSource userParams(String userNo, String istNo) {
        return new MapSqlParameterSource("u", userNo).addValue("i", istNo);
    }

    // ─── ranj: select ranjpath.* from ranjpath ───

    public List<RangeRow> ranges() {
        return jdbc.query("SELECT rjp_no, rjp_nofrom, rjp_noto, rjp_path, rjp_typ FROM ranjpath", new MapSqlParameterSource(), RANGE);
    }

    public int updateRange(int rjpNo, String column, Object value) {
        return jdbc.update("UPDATE ranjpath SET " + column + " = :v WHERE rjp_no = :no",
                new MapSqlParameterSource("v", value).addValue("no", rjpNo));
    }

    public void insertRange(Map<String, Object> values) {
        MapSqlParameterSource p = new MapSqlParameterSource();
        List<String> cols = new ArrayList<>(values.keySet());
        for (int i = 0; i < cols.size(); i++) {
            p.addValue("v" + i, values.get(cols.get(i)));
        }
        jdbc.update("INSERT INTO ranjpath (" + String.join(", ", cols) + ") VALUES ("
                + java.util.stream.IntStream.range(0, cols.size()).mapToObj(i -> ":v" + i).collect(Collectors.joining(", ")) + ")", p);
    }

    public int deleteRange(int rjpNo) {
        return jdbc.update("DELETE FROM ranjpath WHERE rjp_no = :no", new MapSqlParameterSource("no", rjpNo));
    }
}
