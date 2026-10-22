package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.AnalysisTextResponse;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * The analysis screen's (Form2.frm) free text and abstract.
 *
 * <p>text1 has no key in the legacy schema: one text is the set of rows for
 * (txt_no, txt_ser_no = descriptor serial, txt_rltv_n = relation number), one row per 3900-character
 * page numbered by txt_nbpage. Read with serh_text1, written page by page with upd_text1 /
 * insr_text1, surplus pages removed with del_text2 — so plain SQL over those columns, not the
 * (txt_no, txt_ser_no)-keyed entity, which would fold pages and relations together.
 */
@Service
public class AnalysisPageService {

    static final int PAGE_SIZE = 3900;
    private static final String FILTERED_CHARS = "'\"/?<>*\\|\u061F:\r\n";

    private final NamedParameterJdbcTemplate jdbc;
    private final CatalogueLockGuard lockGuard;

    public AnalysisPageService(NamedParameterJdbcTemplate jdbc, CatalogueLockGuard lockGuard) {
        this.jdbc = jdbc;
        this.lockGuard = lockGuard;
    }

    /** serh_text1 @doc, @rel, @ser — pages appended in order (Form2.frm DBList1 Enter / تقدم / تراجع). */
    @Transactional(readOnly = true)
    public AnalysisTextResponse getText(String appNo, String serNo, String relNo) {
        List<String> pages = jdbc.queryForList(
                "SELECT txt_text FROM text1 WHERE txt_no = :no AND txt_ser_no = :ser AND txt_rltv_n = :rel "
                        + "ORDER BY txt_nbpage",
                params(appNo, serNo, relNo), String.class);
        StringBuilder sb = new StringBuilder();
        for (String p : pages) {
            if (p != null) sb.append(p);
        }
        return new AnalysisTextResponse(serNo, relNo, sb.toString(), pages.size());
    }

    /**
     * frm_result F5 — serh_text5 @doc (missing from the DDL): every text1 page of the document,
     * in descriptor / relation / page order, appended into one text like the F4 path.
     */
    @Transactional(readOnly = true)
    public AnalysisTextResponse getAllText(String appNo) {
        List<String> pages = jdbc.queryForList(
                "SELECT txt_text FROM text1 WHERE txt_no = :no ORDER BY txt_ser_no, txt_rltv_n, txt_nbpage",
                new MapSqlParameterSource("no", appNo), String.class);
        StringBuilder sb = new StringBuilder();
        for (String p : pages) {
            if (p != null) sb.append(p);
        }
        return new AnalysisTextResponse(null, null, sb.toString(), pages.size());
    }

    /**
     * m_txt_text_KeyPress Esc: filter_desc, then the text split into 3900-character pages; existing
     * pages are rewritten, new ones inserted, surplus ones deleted (here: replaced as a whole).
     * txt_rltv_typ = '2' when the relation number is above 1, otherwise '1'.
     */
    @Transactional
    public AnalysisTextResponse saveText(String appNo, String serNo, String relNo, String descNo, String text) {
        lockGuard.assertEditable(appNo);
        String clean = filterDesc(text == null ? "" : text).strip();
        String typ = parseInt(relNo) > 1 ? "2" : "1";
        jdbc.update("DELETE FROM text1 WHERE txt_no = :no AND txt_ser_no = :ser AND txt_rltv_n = :rel",
                params(appNo, serNo, relNo));
        int page = 0;
        for (int start = 0; start < clean.length(); start += PAGE_SIZE) {
            page++;
            MapSqlParameterSource p = params(appNo, serNo, relNo)
                    .addValue("desc", descNo)
                    .addValue("typ", typ)
                    .addValue("text", clean.substring(start, Math.min(clean.length(), start + PAGE_SIZE)))
                    .addValue("page", page);
            jdbc.update("INSERT INTO text1 (txt_no, txt_desc_n, txt_ser_no, txt_rltv_typ, txt_rltv_n, txt_text, txt_nbpage) "
                    + "VALUES (:no, :desc, :ser, :typ, :rel, :text, :page)", p);
        }
        return new AnalysisTextResponse(serNo, relNo, clean, page);
    }

    /** m_mn_result Esc → upd_mn_result (legacy runs it without the is_trans lock check). */
    @Transactional
    public void saveAbstract(String appNo, String result) {
        String r = result == null ? null : (result.length() > 1000 ? result.substring(0, 1000) : result);
        jdbc.update("UPDATE main SET \"MN_RESULT\" = :r WHERE \"MN_APP_NO\" = :no",
                new MapSqlParameterSource().addValue("r", r).addValue("no", appNo));
    }

    /** bok.bas filter_desc: ' " / ? < > * \ | ؟ : and line breaks become spaces (after LTrim). */
    static String filterDesc(String v) {
        StringBuilder sb = new StringBuilder(v.length());
        for (char c : v.stripLeading().toCharArray()) {
            sb.append(FILTERED_CHARS.indexOf(c) >= 0 ? ' ' : c);
        }
        return sb.toString();
    }

    private static MapSqlParameterSource params(String appNo, String serNo, String relNo) {
        return new MapSqlParameterSource().addValue("no", appNo).addValue("ser", serNo).addValue("rel", relNo);
    }

    private static int parseInt(String v) {
        try {
            return Integer.parseInt(v == null ? "" : v.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
