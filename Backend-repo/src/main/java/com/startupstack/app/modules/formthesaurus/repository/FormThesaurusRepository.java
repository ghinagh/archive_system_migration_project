package com.startupstack.app.modules.formthesaurus.repository;

import com.startupstack.app.modules.formthesaurus.dto.CodingRow;
import com.startupstack.app.modules.formthesaurus.dto.FormRelationRow;
import com.startupstack.app.modules.formthesaurus.dto.FormRow;
import com.startupstack.app.modules.formthesaurus.dto.MacnzRow;
import com.startupstack.app.modules.formthesaurus.dto.PositionRow;
import com.startupstack.app.modules.formthesaurus.dto.SubjectRelationRow;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

/**
 * The CODING / form / POSITION / REL_FORM / SUBJECT / MACNZ / WORD statements of "المكنز الشكلي"
 * (legacy coding.frm), one method per legacy procedure or data-control RecordSource.
 *
 * <p>Code columns (SUB_CODE, SUB_TYP, SUB_NO, POS_NO, RLF_FORM*, SUB_FORM, SUB_MCNZ, SUB_REL) are
 * compared here with the SQL Server "=" semantics that matter for codes: case-insensitive and
 * blind to trailing blanks. Comparisons, LIKE and ORDER BY on names/descriptions need the full
 * legacy collation and are applied by the service with {@code LegacyCollation}.
 */
@Repository
public class FormThesaurusRepository {

    private static final String FORM_COLS = "\"SUB_TYP\" AS typ, \"SUB_NO\" AS no, \"SUB_NAME\" AS name, "
            + "\"SUB_TYP\" || \"SUB_NO\" AS cod";

    private static final RowMapper<CodingRow> CODING = (rs, i) ->
            new CodingRow(rs.getString("leve"), rs.getString("code"), rs.getString("descr"));
    private static final RowMapper<FormRow> FORM = (rs, i) ->
            new FormRow(rs.getString("typ"), rs.getString("no"), rs.getString("name"), rs.getString("cod"));
    private static final RowMapper<PositionRow> POSITION = (rs, i) ->
            new PositionRow(rs.getString("no"), rs.getString("name"), toLocal(rs.getTimestamp("rec")));
    private static final RowMapper<FormRelationRow> FORM_RELATION = (rs, i) ->
            new FormRelationRow(rs.getString("f1"), rs.getString("f2"), rs.getString("rel"), rs.getString("m_name"),
                    toLocal(rs.getTimestamp("d1")), toLocal(rs.getTimestamp("d2")));
    private static final RowMapper<SubjectRelationRow> SUBJECT_RELATION = (rs, i) ->
            new SubjectRelationRow(rs.getString("frm"), rs.getString("mcnz"), rs.getString("rel"),
                    rs.getString("m_sub_desc"), toLocal(rs.getTimestamp("d1")), toLocal(rs.getTimestamp("d2")));
    private static final RowMapper<MacnzRow> MACNZ = (rs, i) ->
            new MacnzRow(rs.getString("code"), rs.getString("leve"), rs.getString("descr"));

    private final NamedParameterJdbcTemplate jdbc;

    public FormThesaurusRepository(NamedParameterJdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    /** SQL Server "=" on a code column: case-insensitive, trailing blanks ignored; NULL never matches. */
    private static String eq(String column, String param) {
        return "rtrim(lower(" + column + ")) = rtrim(lower(:" + param + "))";
    }

    private static LocalDateTime toLocal(Timestamp t) {
        return t == null ? null : t.toLocalDateTime();
    }

    // ─── CODING ─────────────────────────────────────────────────────────

    /** proc_v_coding1: SELECT SUB_LEVE, SUB_CODE, SUB_DESC FROM coding WHERE sub_leve = '1' (no ORDER BY). */
    public List<CodingRow> codingLevelOne() {
        return jdbc.query("SELECT \"SUB_LEVE\" AS leve, \"SUB_CODE\" AS code, \"SUB_DESC\" AS descr FROM \"CODING\" "
                + "WHERE " + eq("\"SUB_LEVE\"", "lvl"), new MapSqlParameterSource("lvl", "1"), CODING);
    }

    /** coding_proc @cod nvarchar(2): where SUBSTRING(sub_code, 1, 2) = @cod (ordered by the service). */
    public List<CodingRow> codingChildren(String prefix) {
        return jdbc.query("SELECT \"SUB_LEVE\" AS leve, \"SUB_CODE\" AS code, \"SUB_DESC\" AS descr FROM \"CODING\" "
                + "WHERE " + eq("substr(\"SUB_CODE\", 1, 2)", "cod"), new MapSqlParameterSource("cod", prefix), CODING);
    }

    /** find_coding @m_code nvarchar(4): select coding.* from coding where sub_code = @m_code */
    public List<CodingRow> findCoding(String code) {
        return jdbc.query("SELECT \"SUB_LEVE\" AS leve, \"SUB_CODE\" AS code, \"SUB_DESC\" AS descr FROM \"CODING\" "
                + "WHERE " + eq("\"SUB_CODE\"", "code"), new MapSqlParameterSource("code", code), CODING);
    }

    /** coding.Resultset.AddNew / Update — insert into coding (sub_code, sub_desc, sub_leve) */
    public void insertCoding(String code, String description, String level) {
        jdbc.update("INSERT INTO \"CODING\" (\"SUB_CODE\", \"SUB_DESC\", \"SUB_LEVE\") VALUES (:code, :descr, :lvl)",
                new MapSqlParameterSource("code", code).addValue("descr", description).addValue("lvl", level));
    }

    /** upd_coding: update coding set sub_desc = @desc where sub_code = @m_code */
    public void updateCoding(String description, String code) {
        jdbc.update("UPDATE \"CODING\" SET \"SUB_DESC\" = :descr WHERE " + eq("\"SUB_CODE\"", "code"),
                new MapSqlParameterSource("descr", description).addValue("code", code));
    }

    /** del_coding: delete from coding where sub_code = @sa */
    public void deleteCoding(String code) {
        jdbc.update("DELETE FROM \"CODING\" WHERE " + eq("\"SUB_CODE\"", "code"), new MapSqlParameterSource("code", code));
    }

    // ─── form ───────────────────────────────────────────────────────────

    /** view pay_form: SELECT DISTINCT FORM.*, SUB_TYP + SUB_NO AS sub_cod FROM FORM WHERE SUBSTRING(SUB_NO, 4, 5) = '00000' */
    public List<FormRow> countries() {
        return jdbc.query("SELECT " + FORM_COLS + " FROM (SELECT DISTINCT * FROM form WHERE "
                        + eq("substr(\"SUB_NO\", 4, 5)", "z") + ") f",
                new MapSqlParameterSource("z", "00000"), FORM);
    }

    /** serh_form scope: SELECT form.* FROM form WHERE SUBSTRING(form.sub_no, 4, 5) = '00000' (no DISTINCT). */
    public List<FormRow> countryRows() {
        return jdbc.query("SELECT " + FORM_COLS + " FROM form WHERE " + eq("substr(\"SUB_NO\", 4, 5)", "z"),
                new MapSqlParameterSource("z", "00000"), FORM);
    }

    /** Every form row (serh_allform / serh_wrdform scan the whole table). */
    public List<FormRow> allForms() {
        return jdbc.query("SELECT " + FORM_COLS + " FROM form", new MapSqlParameterSource(), FORM);
    }

    /** nam_form / serh1_form filter: form.sub_typ = @v_typ AND SUBSTRING(form.sub_no, 1, 3) = @v_cod */
    public List<FormRow> formsOf(String type, String countryPrefix) {
        return jdbc.query("SELECT " + FORM_COLS + " FROM form WHERE " + eq("\"SUB_TYP\"", "typ")
                        + " AND " + eq("substr(\"SUB_NO\", 1, 3)", "cod"),
                new MapSqlParameterSource("typ", type).addValue("cod", countryPrefix), FORM);
    }

    /** op_form / max_form scope: substring(sub_typ + sub_no, 1, 5) = @m_sub */
    public List<FormRow> formsWithPrefix(String sub) {
        return jdbc.query("SELECT " + FORM_COLS + " FROM form WHERE " + eq("substr(\"SUB_TYP\" || \"SUB_NO\", 1, 5)", "sub"),
                new MapSqlParameterSource("sub", sub), FORM);
    }

    /**
     * serh_wrdform1: SELECT form.* FROM word INNER JOIN form ON WORD.SUB_CODE6 = form.sub_typ + FORM.SUB_NO
     * WHERE sub_typ6 = '2' AND substring(word.sub_code6, 1, 5) = @m_pays — plus SUB_DESC6 for the
     * service's prefix test.
     */
    public List<Object[]> wordJoinedForms(String pays) {
        return jdbc.query("SELECT " + FORM_COLS.replace("\"SUB_", "f.\"SUB_") + ", w.\"SUB_DESC6\" AS word FROM \"WORD\" w "
                        + "JOIN form f ON " + "rtrim(lower(w.\"SUB_CODE6\")) = rtrim(lower(f.\"SUB_TYP\" || f.\"SUB_NO\"))"
                        + " WHERE " + eq("w.\"SUB_TYP6\"", "t") + " AND " + eq("substr(w.\"SUB_CODE6\", 1, 5)", "pays"),
                new MapSqlParameterSource("t", "2").addValue("pays", pays),
                (rs, i) -> new Object[]{FORM.mapRow(rs, i), rs.getString("word")});
    }

    /** find_form: select FORM.* from FORM where (sub_NO = @M_SUB_NO AND SUB_TYP = @M_SUB_TYP) */
    public List<FormRow> findForm(String number, String type) {
        return jdbc.query("SELECT " + FORM_COLS + " FROM form WHERE " + eq("\"SUB_NO\"", "no") + " AND " + eq("\"SUB_TYP\"", "typ"),
                new MapSqlParameterSource("no", number).addValue("typ", type), FORM);
    }

    /** insr_form: insert into form (sub_typ, sub_no, sub_name, sub_dte) values (@m_sub_typ, @m_sub_no, @desc, @m_date) */
    public void insertForm(String type, String number, String name, LocalDate date) {
        jdbc.update("INSERT INTO form (\"SUB_TYP\", \"SUB_NO\", \"SUB_NAME\", \"SUB_DTE\") VALUES (:typ, :no, :name, :dte)",
                new MapSqlParameterSource("typ", type).addValue("no", number).addValue("name", name)
                        .addValue("dte", date == null ? null : Timestamp.valueOf(date.atStartOfDay())));
    }

    /** upd_form: update form set sub_name = @desc where (sub_no = @m_sub_no AND SUB_TYP = @M_SUB_TYP) */
    public void updateForm(String name, String number, String type) {
        jdbc.update("UPDATE form SET \"SUB_NAME\" = :name WHERE " + eq("\"SUB_NO\"", "no") + " AND " + eq("\"SUB_TYP\"", "typ"),
                new MapSqlParameterSource("name", name).addValue("no", number).addValue("typ", type));
    }

    /** del_form: delete from form where (sub_no = @m_sub_no and sub_typ = @m_sub_typ) */
    public void deleteForm(String number, String type) {
        jdbc.update("DELETE FROM form WHERE " + eq("\"SUB_NO\"", "no") + " AND " + eq("\"SUB_TYP\"", "typ"),
                new MapSqlParameterSource("no", number).addValue("typ", type));
    }

    // ─── POSITION ───────────────────────────────────────────────────────

    /** proc_pos: select position.* from position where (pos_no = @m_pos_no) order by dat_rec */
    public List<PositionRow> positions(String number) {
        return jdbc.query("SELECT \"POS_NO\" AS no, \"POS_NAM\" AS name, \"DAT_REC\" AS rec FROM \"POSITION\" WHERE "
                        + eq("\"POS_NO\"", "no") + " ORDER BY \"DAT_REC\" NULLS FIRST",
                new MapSqlParameterSource("no", number), POSITION);
    }

    /** insr_pos: insert into position (pos_no, pos_nam, dat_rec) values (@m_sub_no, @desc, @m_date) */
    public void insertPosition(String number, String name, LocalDate date) {
        jdbc.update("INSERT INTO \"POSITION\" (\"POS_NO\", \"POS_NAM\", \"DAT_REC\") VALUES (:no, :name, :dte)",
                new MapSqlParameterSource("no", number).addValue("name", name)
                        .addValue("dte", date == null ? null : Timestamp.valueOf(date.atStartOfDay())));
    }

    /** upd_position: update position set pos_nam = @desc where (pos_no = @m_sub_no AND pos_nam = @desc1) — names resolved by the collation. */
    public void updatePositions(String name, String number, Collection<String> storedNames) {
        jdbc.update("UPDATE \"POSITION\" SET \"POS_NAM\" = :name WHERE " + eq("\"POS_NO\"", "no") + " AND \"POS_NAM\" IN (:names)",
                new MapSqlParameterSource("name", name).addValue("no", number).addValue("names", storedNames));
    }

    /** del_position: delete from POSITION where (POS_no = @m_sub_no and POS_NAM = @m_POS_NAM) — names resolved by the collation. */
    public void deletePositions(String number, Collection<String> storedNames) {
        jdbc.update("DELETE FROM \"POSITION\" WHERE " + eq("\"POS_NO\"", "no") + " AND \"POS_NAM\" IN (:names)",
                new MapSqlParameterSource("no", number).addValue("names", storedNames));
    }

    // ─── REL_FORM ───────────────────────────────────────────────────────

    /**
     * rel_form_proc: SELECT rel_form.*, view_form.SUB_NAME AS m_name FROM rel_form INNER JOIN view_form
     * ON rel_form.rlf_form2 = view_form.sub_cod WHERE rlf_form1 = @m_rlf_form AND rlf_rel = @m_rel
     */
    public List<FormRelationRow> formRelations(String form, String relation) {
        return jdbc.query("SELECT r.\"RLF_FORM1\" AS f1, r.\"RLF_FORM2\" AS f2, r.\"RLF_REL\" AS rel, f.\"SUB_NAME\" AS m_name, "
                        + "r.\"RLF_DTE\" AS d1, r.\"RLF_DTE1\" AS d2 FROM \"REL_FORM\" r JOIN form f "
                        + "ON rtrim(lower(r.\"RLF_FORM2\")) = rtrim(lower(f.\"SUB_TYP\" || f.\"SUB_NO\")) WHERE "
                        + eq("r.\"RLF_FORM1\"", "frm") + " AND " + eq("r.\"RLF_REL\"", "rel"),
                new MapSqlParameterSource("frm", form).addValue("rel", relation), FORM_RELATION);
    }

    /** insr_rel_form: insert into rel_form (rlf_form1, rlf_form2, rlf_rel) values (...) */
    public void insertFormRelation(String first, String second, String relation) {
        jdbc.update("INSERT INTO \"REL_FORM\" (\"RLF_FORM1\", \"RLF_FORM2\", \"RLF_REL\") VALUES (:a, :b, :rel)",
                new MapSqlParameterSource("a", first).addValue("b", second).addValue("rel", relation));
    }

    /** upd_rfl_dte: update rel_form set rlf_dte, rlf_dte1 where rlf_form1, rlf_form2, rlf_rel match */
    public void updateFormRelationDates(String first, String second, String relation, LocalDate start, LocalDate end) {
        jdbc.update("UPDATE \"REL_FORM\" SET \"RLF_DTE\" = :d1, \"RLF_DTE1\" = :d2 WHERE " + eq("\"RLF_FORM1\"", "a")
                        + " AND " + eq("\"RLF_FORM2\"", "b") + " AND " + eq("\"RLF_REL\"", "rel"),
                relationParams(first, second, relation).addValue("d1", ts(start)).addValue("d2", ts(end)));
    }

    /** del_rel_form */
    public void deleteFormRelation(String first, String second, String relation) {
        jdbc.update("DELETE FROM \"REL_FORM\" WHERE " + eq("\"RLF_FORM1\"", "a") + " AND " + eq("\"RLF_FORM2\"", "b")
                + " AND " + eq("\"RLF_REL\"", "rel"), relationParams(first, second, relation));
    }

    // ─── SUBJECT ────────────────────────────────────────────────────────

    /**
     * subject_proc: SELECT subject.*, macnz.sub_desc AS m_sub_desc FROM subject INNER JOIN macnz
     * ON subject.sub_mcnz = macnz.sub_code WHERE sub_form = @m_sub_form AND sub_rel = @m_rel
     */
    public List<SubjectRelationRow> subjectRelations(String form, String relation) {
        return jdbc.query("SELECT s.\"SUB_FORM\" AS frm, s.\"SUB_MCNZ\" AS mcnz, s.\"SUB_REL\" AS rel, "
                        + "m.\"SUB_DESC\" AS m_sub_desc, s.\"SUB_DTE\" AS d1, s.\"SUB_DTE1\" AS d2 FROM \"SUBJECT\" s "
                        + "JOIN \"MACNZ\" m ON rtrim(lower(s.\"SUB_MCNZ\")) = rtrim(lower(m.\"SUB_CODE\")) WHERE "
                        + eq("s.\"SUB_FORM\"", "frm") + " AND " + eq("s.\"SUB_REL\"", "rel"),
                new MapSqlParameterSource("frm", form).addValue("rel", relation), SUBJECT_RELATION);
    }

    /** insr_subject: insert into subject (sub_form, sub_mcnz, sub_rel) values (...) */
    public void insertSubjectRelation(String form, String macnz, String relation) {
        jdbc.update("INSERT INTO \"SUBJECT\" (\"SUB_FORM\", \"SUB_MCNZ\", \"SUB_REL\") VALUES (:a, :b, :rel)",
                new MapSqlParameterSource("a", form).addValue("b", macnz).addValue("rel", relation));
    }

    /** upd_sub_dte */
    public void updateSubjectRelationDates(String form, String macnz, String relation, LocalDate start, LocalDate end) {
        jdbc.update("UPDATE \"SUBJECT\" SET \"SUB_DTE\" = :d1, \"SUB_DTE1\" = :d2 WHERE " + eq("\"SUB_FORM\"", "a")
                        + " AND " + eq("\"SUB_MCNZ\"", "b") + " AND " + eq("\"SUB_REL\"", "rel"),
                relationParams(form, macnz, relation).addValue("d1", ts(start)).addValue("d2", ts(end)));
    }

    /** del_subject */
    public void deleteSubjectRelation(String form, String macnz, String relation) {
        jdbc.update("DELETE FROM \"SUBJECT\" WHERE " + eq("\"SUB_FORM\"", "a") + " AND " + eq("\"SUB_MCNZ\"", "b")
                + " AND " + eq("\"SUB_REL\"", "rel"), relationParams(form, macnz, relation));
    }

    // ─── MACNZ / WORD ───────────────────────────────────────────────────

    /** frm_mcnz.sql = "select * from macnz" (table order) */
    public List<MacnzRow> allMacnz() {
        return jdbc.query("SELECT \"SUB_CODE\" AS code, \"SUB_LEVEL\" AS leve, \"SUB_DESC\" AS descr FROM \"MACNZ\"",
                new MapSqlParameterSource(), MACNZ);
    }

    /** del_word: delete from word where (sub_code6 = @m_no and sub_typ6 = @m_typ) */
    public void deleteWords(String code, String type) {
        jdbc.update("DELETE FROM \"WORD\" WHERE " + eq("\"SUB_CODE6\"", "code") + " AND " + eq("\"SUB_TYP6\"", "typ"),
                new MapSqlParameterSource("code", code).addValue("typ", type));
    }

    /** insr_word: insert into word (sub_typ6, sub_code6, sub_desc6) values (@m_typ, @m_no, @desc) */
    public void insertWord(String word, String code, String type) {
        jdbc.update("INSERT INTO \"WORD\" (\"SUB_TYP6\", \"SUB_CODE6\", \"SUB_DESC6\") VALUES (:typ, :code, :word)",
                new MapSqlParameterSource("typ", type).addValue("code", code).addValue("word", word));
    }

    private static MapSqlParameterSource relationParams(String first, String second, String relation) {
        return new MapSqlParameterSource("a", first).addValue("b", second).addValue("rel", relation);
    }

    private static Timestamp ts(LocalDate d) {
        return d == null ? null : Timestamp.valueOf(d.atStartOfDay());
    }
}
