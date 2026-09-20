package com.startupstack.app.modules.searchscreen.service;

import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchResultResponse;
import com.startupstack.app.modules.digitization.entity.DigitEntity;
import com.startupstack.app.modules.digitization.repository.DigitRepository;
import com.startupstack.app.modules.searchscreen.dto.SearchScreenRequest;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * LEGACY MIGRATION: user_inetrface.frm, Section 1 — Command1_Click (:1885-2204).
 *
 * Deliberately separate from {@code archivesearch.ArchiveSearchService}: that service
 * replicates USER_INTERFACE1.frm ("شاشة البحث فيديو + صوتي", already migrated at
 * /archive-search) and has different, non-transferable join semantics — an OR between
 * descriptor fields, an INNER JOIN on the file lookup, several accepted-but-unfiltered
 * criteria. This screen (شاشة البحث, j1) is a flat AND of up to 22 independent criteria,
 * exactly as Command1_Click builds {@code crit1}: every field, when present, appends
 * " and " + its own condition — never OR, never grouped, never skipped.
 *
 * The results view (`view_result`) already carries the MAIN+ARTICLE+DIGIT+RES+PERIOD+
 * AUTHER+CODING joins this screen also needs for display; it is reused as the base
 * FROM and extended with a handful of narrow extra joins (aliased `art2`, `mn2`, `dg`)
 * purely to reach the few filter columns it doesn't expose (ART_SUB_TY, ART_LANG1,
 * MN_DATA_EN, MN_ENT_DTE, DIG_NOCHRT, dig_geochrt).
 */
@Service
public class SearchScreenService {

    @PersistenceContext
    private EntityManager entityManager;

    private final DigitRepository digitRepository;

    public SearchScreenService(DigitRepository digitRepository) {
        this.digitRepository = digitRepository;
    }

    /**
     * Legacy DataGrid1_KeyDown F9 (:2590-2605) — toggles DIGIT.dig_choice between 0/null and 1
     * for the row under the grid cursor ("الاختيار"), via `execute upd_dig_choice(V_REC, m_typ,
     * v_typ)` where V_REC=dig_dig_no, v_typ=dig_typ1. Reproduced as an explicit set rather than
     * a read-then-flip so a stale client value can never re-toggle a choice someone else just
     * set (legacy has no such protection since it's single-user desktop software; this is a
     * strictly additive safety improvement, not a behavior change).
     */
    @Transactional
    public void setChoice(String digitNo, String type1, int choice) {
        List<DigitEntity> rows = digitRepository.findByDigitNoAndType1(digitNo, type1);
        if (rows.isEmpty()) {
            throw new ResourceNotFoundException("Digit record not found: " + digitNo + "/" + type1);
        }
        for (DigitEntity row : rows) {
            row.setChoice(choice);
        }
        digitRepository.saveAll(rows);
    }

    @Transactional(readOnly = true)
    public Page<ArchiveSearchResultResponse> search(SearchScreenRequest request, Pageable pageable) {
        List<String> where = new ArrayList<>();
        Map<String, Object> params = new HashMap<>();
        StringBuilder joins = new StringBuilder(
                "FROM view_result v " +
                "LEFT JOIN \"ARTICLE\" art2 ON v.mn_app_no = art2.\"ART_APP_NO\" " +
                "LEFT JOIN \"main\" mn2 ON v.mn_app_no = mn2.\"MN_APP_NO\" " +
                "LEFT JOIN \"DIGIT\" dg ON v.mn_app_no = dg.\"DIG_NO\" ");

        // ===== m_word "كلمة من العناوين" — legacy :2067,3529 always CONTAINS, never
        // gated by Option1/Option2 (m_typ_serh only drives the 6 lookup popups) =====
        if (notBlank(request.getTitleWord())) {
            where.add("(COALESCE(v.mn_act_ttl,'') || COALESCE(v.mn_add_ttl,'')) LIKE :titleWord");
            params.put("titleWord", "%" + request.getTitleWord().trim() + "%");
        }

        // ===== M_art_dte / M_art_dte1 "من تاريخ" / "الى تاريخ" — :2945,2979 =====
        if (request.getDateFrom() != null) {
            where.add("v.art_dte >= :dateFrom");
            params.put("dateFrom", request.getDateFrom());
        }
        if (request.getDateTo() != null) {
            where.add("v.art_dte <= :dateTo");
            params.put("dateTo", request.getDateTo());
        }

        // ===== m_ent_dte / m_ent_dte1 "من/الى تاريخ الادخال" — :3166,3192 =====
        if (request.getEntryDateFrom() != null) {
            where.add("mn2.\"MN_ENT_DTE\" >= :entryDateFrom");
            params.put("entryDateFrom", request.getEntryDateFrom());
        }
        if (request.getEntryDateTo() != null) {
            where.add("mn2.\"MN_ENT_DTE\" <= :entryDateTo");
            params.put("entryDateTo", request.getEntryDateTo());
        }

        // ===== m_art_sub_ty "نوع الوثيقة" (right column) — :3051 art_sub_ty = Mid(BoundText,3,2) =====
        if (notBlank(request.getArticleType())) {
            where.add("art2.\"ART_SUB_TY\" = :articleType");
            params.put("articleType", request.getArticleType());
        }

        // ===== m_dig_typ1 "نوع الوثيقة" (bottom-left) — :3146 dig_Typ1 = Mid(BoundText,3,2) =====
        if (notBlank(request.getDocumentType())) {
            where.add("v.dig_typ1 = :documentType");
            params.put("documentType", request.getDocumentType());
        }

        // ===== m_art_per_no "جهة الصدور" — :3017 art_per_no = BoundText (exact, no Mid-strip) =====
        if (request.getPeriodicalNo() != null) {
            where.add("art2.\"ART_PER_NO\" = :periodicalNo");
            params.put("periodicalNo", request.getPeriodicalNo());
        }

        // ===== m_res_no "المسؤول البياني" — :3480 res_res_no = BoundText (exact) =====
        if (request.getResponsiblePersonNo() != null) {
            where.add("v.res_res_no = :responsiblePersonNo");
            params.put("responsiblePersonNo", request.getResponsiblePersonNo().intValue());
        }

        // ===== m_dig_dig_no "رقم digital" — :3113 dig_dig_no LIKE =====
        if (notBlank(request.getDigitAssetNo())) {
            where.add("v.dig_dig_no LIKE :digitAssetNo");
            params.put("digitAssetNo", "%" + request.getDigitAssetNo().trim() + "%");
        }

        // ===== m_dig_nochrt "رقم الارشيف القديم" — :3130 dig_nochrt LIKE =====
        if (notBlank(request.getOldArchiveNo())) {
            where.add("dg.\"DIG_NOCHRT\" LIKE :oldArchiveNo");
            params.put("oldArchiveNo", "%" + request.getOldArchiveNo().trim() + "%");
        }

        // ===== m_mn_data_en "مدخل البيانات" — :3357 mn_data_en = Mid(BoundText,3,2) =====
        if (notBlank(request.getDataEntryOperator())) {
            where.add("mn2.\"MN_DATA_EN\" = :dataEntryOperator");
            params.put("dataEntryOperator", request.getDataEntryOperator());
        }

        // ===== m_mn_result "كلمة من المستخلص" — :3372 mn_result LIKE =====
        if (notBlank(request.getAbstractWord())) {
            where.add("v.mn_result LIKE :abstractWord");
            params.put("abstractWord", "%" + request.getAbstractWord().trim() + "%");
        }

        // ===== m_txt_text "كلمة من النص" — :3512 txt_text LIKE, LEFT JOIN text1 =====
        // Migrated TEXT table exposes TXT_APP_NO/TXT_MEM (legacy's TXT_NO/TXT_TEXT were
        // renamed during migration — same join key and content column, different names).
        if (notBlank(request.getFullText())) {
            joins.append("LEFT JOIN \"TEXT\" txt ON v.mn_app_no = txt.\"TXT_APP_NO\" ");
            where.add("txt.\"TXT_MEM\" LIKE :fullText");
            params.put("fullText", "%" + request.getFullText().trim() + "%");
        }

        // ===== m_art_pg_no "عدد الصفحات" — :3035 art_pg_no = Val(text) numeric coercion =====
        if (notBlank(request.getPageNo())) {
            where.add("v.art_pg_no = :pageNo");
            params.put("pageNo", String.valueOf(val(request.getPageNo())));
        }

        // ===== m_art_lang "اللغة" — :3002 art_lang1 = Mid(BoundText,3,2) =====
        if (notBlank(request.getLanguage())) {
            where.add("art2.\"ART_LANG1\" = :language");
            params.put("language", request.getLanguage());
        }

        // ===== m_desc_no "الموضوع" — :2798 an_desc_no, LEFT JOIN analis =====
        if (notBlank(request.getSubjectDescriptorCode())) {
            joins.append("LEFT JOIN \"ANALIS\" an ON v.mn_app_no = an.\"AN_APP_NO\" ");
            where.add("an.\"AN_DESC_NO\" = :subjectDescriptorCode");
            params.put("subjectDescriptorCode", request.getSubjectDescriptorCode());
        }

        // ===== m_rel_text "المترابط" — :2813 rel_rel_no, LEFT JOIN relative =====
        if (notBlank(request.getRelatedDescriptorCode())) {
            joins.append("LEFT JOIN \"RELATIVE\" rel ON v.mn_app_no = rel.\"REL_APP_NO\" ");
            where.add("rel.\"REL_REL_NO\" = :relatedDescriptorCode");
            params.put("relatedDescriptorCode", request.getRelatedDescriptorCode());
        }

        // ===== m_nar_text "الاضيق" — :2828 nar_nar_no, LEFT JOIN narower =====
        if (notBlank(request.getNarrowerDescriptorCode())) {
            joins.append("LEFT JOIN \"NAROWER\" nar ON v.mn_app_no = nar.\"NAR_APP_NO\" ");
            where.add("nar.\"NAR_NAR_NO\" = :narrowerDescriptorCode");
            params.put("narrowerDescriptorCode", request.getNarrowerDescriptorCode());
        }

        // ===== m_file_no "الملف الاضافي" — :2673 fad_fad_no, LEFT JOIN file_add (legacy uses
        // LEFT JOIN here, not INNER — preserved exactly) =====
        if (notBlank(request.getAdditionalFileCode())) {
            joins.append("LEFT JOIN \"FILE_ADD\" fa ON v.mn_app_no = fa.\"FAD_APP_NO\" ");
            where.add("fa.\"FAD_FAD_NO\" = :additionalFileCode");
            params.put("additionalFileCode", request.getAdditionalFileCode());
        }

        // ===== m_geo_text "المكان الجغرافي" — :2690 geo_geo_no, LEFT JOIN geo =====
        if (notBlank(request.getGeoLocationCode())) {
            joins.append("LEFT JOIN \"GEO\" geo ON v.mn_app_no = geo.\"GEO_APP_NO\" ");
            where.add("geo.\"GEO_GEO_NO\" = :geoLocationCode");
            params.put("geoLocationCode", request.getGeoLocationCode());
        }

        // ===== m_geo_chrt "مكان التصوير/النشر" — :2707 dig_geochrt (no join added in legacy) =====
        if (notBlank(request.getPhotoPlaceCode())) {
            where.add("dg.\"dig_geochrt\" = :photoPlaceCode");
            params.put("photoPlaceCode", request.getPhotoPlaceCode());
        }

        // ===== Legacy :2201-2202 "يجب طرح السؤال اولا....." — Command1_Click refuses to run
        // an empty query. =====
        if (where.isEmpty()) {
            throw new BusinessException("يجب طرح السؤال اولا.....");
        }

        String sql = "SELECT DISTINCT v.res_res_no, v.mn_app_no, v.mn_act_ttl, v.mn_add_ttl, " +
                "v.dig_typ2, v.art_dte, v.art_pg_no, v.art_per_no, " +
                "v.dig_dig_no, v.dig_typ, v.dig_typ1, v.dig_choice, " +
                "v.dig_s, v.dig_o, v.dig_m, v.dig_s1, v.dig_o1, v.dig_m1, v.aut_nam " +
                joins + "WHERE " + String.join(" AND ", where) + " ORDER BY v.art_dte DESC";

        Query query = entityManager.createNativeQuery(sql);
        params.forEach(query::setParameter);
        @SuppressWarnings("unchecked")
        List<Object[]> allRows = query.getResultList();
        long total = allRows.size();

        int fromIndex = Math.min((int) pageable.getOffset(), allRows.size());
        int toIndex = Math.min(fromIndex + pageable.getPageSize(), allRows.size());
        List<Object[]> rows = allRows.subList(fromIndex, toIndex);

        List<ArchiveSearchResultResponse> results = new ArrayList<>();
        for (Object[] r : rows) {
            results.add(new ArchiveSearchResultResponse(
                    castString(r[1]),                    // appNo = mn_app_no
                    castString(r[2]),                    // activeTitleAr = mn_act_ttl
                    castString(r[3]),                    // additionalTitle = mn_add_ttl
                    castLocalDateTime(r[5]),              // articleDate = art_dte
                    castString(r[6]),                    // pageNo = art_pg_no
                    castString(r[7]),                    // periodicalName = art_per_no
                    castString(r[8]),                    // digitNo = dig_dig_no
                    castString(r[9]),                    // documentType = dig_typ
                    castString(r[10]),                   // documentType1 = dig_typ1
                    castString(r[4]),                    // docTypeDescription = dig_typ2
                    castInteger(r[11]),                  // choice = dig_choice
                    null,
                    null,
                    castInteger(r[13]),                  // durationHours = dig_o
                    castInteger(r[14]),                  // durationMinutes = dig_m
                    castInteger(r[12]),                  // durationSeconds = dig_s
                    castInteger(r[16]),                  // durationHours1 = dig_o1
                    castInteger(r[17]),                  // durationMinutes1 = dig_m1
                    castInteger(r[15]),                  // durationSeconds1 = dig_s1
                    castString(r[18]),                   // responsiblePersonName = aut_nam
                    null,
                    null));
        }

        return new PageImpl<>(results, pageable, total);
    }

    /**
     * VB6 {@code Val()} (legacy :3035): reads a leading numeric prefix and stops at the
     * first character that doesn't extend a valid number, returning 0 for none.
     */
    private double val(String text) {
        String t = text.trim();
        int i = 0;
        boolean seenDigit = false;
        boolean seenDot = false;
        if (i < t.length() && (t.charAt(i) == '+' || t.charAt(i) == '-')) i++;
        int start = i;
        while (i < t.length()) {
            char c = t.charAt(i);
            if (Character.isDigit(c)) {
                seenDigit = true;
            } else if (c == '.' && !seenDot) {
                seenDot = true;
            } else {
                break;
            }
            i++;
        }
        if (!seenDigit) return 0;
        String numeric = t.substring(0, i);
        try {
            return Double.parseDouble(numeric.startsWith(".") ? "0" + numeric : numeric);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private boolean notBlank(String s) {
        return s != null && !s.isBlank();
    }

    private String castString(Object value) {
        if (value == null) return null;
        String s = value.toString();
        return s.trim().isEmpty() ? null : s;
    }

    private Integer castInteger(Object value) {
        if (value == null) return null;
        if (value instanceof Integer) return (Integer) value;
        if (value instanceof Number) return ((Number) value).intValue();
        return null;
    }

    private LocalDateTime castLocalDateTime(Object value) {
        return (value instanceof LocalDateTime) ? (LocalDateTime) value : null;
    }
}
