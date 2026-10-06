package com.startupstack.app.modules.formthesaurus.repository;

import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileRow;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * tmp_fileadd statements of "ملفات اضافية للادخال" (legacy tmp_file.frm): the table read behind the
 * generated tmp_result procedure, op_tmp, and the writes ADO made for DataGrid1 edits. tmp_fileadd has
 * no key in legacy, so a row is addressed by all its original column values, as ADO did.
 */
@Repository
public class AdditionalFilesRepository {

    /** DataGrid1 column → tmp_fileadd column. */
    public static final Map<String, String> COLUMNS = new LinkedHashMap<>();

    static {
        COLUMNS.put("fileNo", "tmp_fad_no");
        COLUMNS.put("finalFlag", "tmp_final");
        COLUMNS.put("fileName", "tmp_file_name");
        COLUMNS.put("remark", "tmp_rmrk");
        COLUMNS.put("place", "tmp_mk");
        COLUMNS.put("date", "tmp_date");
        COLUMNS.put("userNo", "tmp_user_no");
        COLUMNS.put("serial", "tmp_ser");
    }

    private static final RowMapper<AdditionalFileRow> ROW = (rs, i) -> new AdditionalFileRow(
            rs.getString("tmp_fad_no"),
            (Integer) rs.getObject("tmp_final", Integer.class),
            rs.getString("tmp_file_name"),
            rs.getString("tmp_rmrk"),
            rs.getString("tmp_mk"),
            rs.getTimestamp("tmp_date") == null ? null : rs.getTimestamp("tmp_date").toLocalDateTime(),
            rs.getString("tmp_user_no"),
            (Double) rs.getObject("tmp_ser", Double.class));

    private final NamedParameterJdbcTemplate jdbc;

    public AdditionalFilesRepository(NamedParameterJdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    /** Every tmp_fileadd row (the WHERE / DISTINCT / ORDER BY of tmp_result are applied by the service). */
    public List<AdditionalFileRow> all() {
        return jdbc.query("SELECT tmp_fad_no, tmp_final, tmp_file_name, tmp_rmrk, tmp_mk, tmp_date, tmp_user_no, tmp_ser "
                + "FROM tmp_fileadd", new MapSqlParameterSource(), ROW);
    }

    /** op_tmp: max(tmp_ser) where tmp_user_no = @m_user_no — compared like SQL Server char(3) "=". */
    public Double maxSerial(String userNo) {
        return jdbc.queryForObject("SELECT max(tmp_ser) FROM tmp_fileadd WHERE rtrim(lower(tmp_user_no)) = rtrim(lower(:u))",
                new MapSqlParameterSource("u", userNo), Double.class);
    }

    /** op_tmp: insert into tmp_fileadd (tmp_ser, tmp_user_no, tmp_fad_no, tmp_date, tmp_final) values (…, 0) */
    public void insertOp(double serial, String userNo, String fileNo, Timestamp date) {
        jdbc.update("INSERT INTO tmp_fileadd (tmp_ser, tmp_user_no, tmp_fad_no, tmp_date, tmp_final) VALUES (:s, :u, :f, :d, 0)",
                new MapSqlParameterSource("s", serial).addValue("u", userNo).addValue("f", fileNo).addValue("d", date));
    }

    /** ADO update of one field, WHERE every original column value matches. */
    public int updateColumn(String column, Object value, AdditionalFileRow original) {
        MapSqlParameterSource p = match(original).addValue("v", value);
        return jdbc.update("UPDATE tmp_fileadd SET " + column + " = :v WHERE " + whereAll(), p);
    }

    /** ADO AddNew / Update — the columns the user filled in the new grid row. */
    public void insert(Map<String, Object> values) {
        MapSqlParameterSource p = new MapSqlParameterSource();
        StringBuilder cols = new StringBuilder();
        StringBuilder vals = new StringBuilder();
        for (Map.Entry<String, Object> e : values.entrySet()) {
            if (cols.length() > 0) { cols.append(", "); vals.append(", "); }
            cols.append(e.getKey());
            vals.append(':').append(e.getKey());
            p.addValue(e.getKey(), e.getValue());
        }
        jdbc.update("INSERT INTO tmp_fileadd (" + cols + ") VALUES (" + vals + ")", p);
    }

    /** ADO Delete (DataGrid1 AllowDelete) — WHERE every original column value matches. */
    public int delete(AdditionalFileRow original) {
        return jdbc.update("DELETE FROM tmp_fileadd WHERE " + whereAll(), match(original));
    }

    private static String whereAll() {
        return "tmp_fad_no IS NOT DISTINCT FROM :o_no AND tmp_final IS NOT DISTINCT FROM :o_final "
                + "AND tmp_file_name IS NOT DISTINCT FROM :o_name AND tmp_rmrk IS NOT DISTINCT FROM :o_rmrk "
                + "AND tmp_mk IS NOT DISTINCT FROM :o_mk AND tmp_date IS NOT DISTINCT FROM CAST(:o_date AS timestamp) "
                + "AND tmp_user_no IS NOT DISTINCT FROM CAST(:o_user AS char(3)) AND tmp_ser IS NOT DISTINCT FROM CAST(:o_ser AS double precision)";
    }

    private static MapSqlParameterSource match(AdditionalFileRow o) {
        return new MapSqlParameterSource("o_no", o.fileNo())
                .addValue("o_final", o.finalFlag())
                .addValue("o_name", o.fileName())
                .addValue("o_rmrk", o.remark())
                .addValue("o_mk", o.place())
                .addValue("o_date", o.date() == null ? null : Timestamp.valueOf(o.date()))
                .addValue("o_user", o.userNo())
                .addValue("o_ser", o.serial());
    }
}
