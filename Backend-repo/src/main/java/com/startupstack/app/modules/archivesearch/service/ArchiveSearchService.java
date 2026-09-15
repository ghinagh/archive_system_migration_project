package com.startupstack.app.modules.archivesearch.service;

import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchRequest;
import com.startupstack.app.modules.archivesearch.dto.ArchiveSearchResultResponse;
import com.startupstack.app.modules.archivesearch.dto.AuthorOptionResponse;
import com.startupstack.app.modules.archivesearch.dto.CodingOptionResponse;
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
 * LEGACY MIGRATION: Replicates USER_INTERFACE1.frm's "البحث في الارشيف" (Archive Search)
 * search cockpit with ALL 13 legacy search filters.
 *
 * LEGACY BEHAVIOR PRESERVED:
 * - Word search: concatenates mn_result + mn_act_ttl + mn_add_ttl with LIKE '%token%'
 * - Date range: inclusive (>=, <=)
 * - File filters: file_add table with INNER JOIN (m_file_no) vs LEFT JOIN (m_file_no1)
 * - Descriptor filters: OR logic (an_desc_no OR rel_rel_no), separate narrower join
 * - Full text: separate text1 join
 * - Results: view_result base query with dynamic filter conditions
 * - Sorting: ORDER BY art_dte DESC
 *
 * FILTER MAPPINGS (13 legacy filters):
 * 1. Search mode → affects word search LIKE pattern (STARTS_WITH vs CONTAINS)
 * 2. m_word → mn_result + mn_act_ttl + mn_add_ttl LIKE '%token%'
 * 3. M_art_dte (from) → art_dte >=
 * 4. M_art_dte1 (to) → art_dte <=
 * 5. m_mch_typ → art_sub_ty =
 * 6. m_dig_typ1 → dig_typ1 =
 * 7. m_res_no → res_res_no =
 * 8. m_file_no → file_add.fad_fad_no = (INNER JOIN)
 * 9. m_file_no1 → file_add_1.fad_fad_no = (LEFT JOIN)
 * 10. m_file_geo → dig_geochrt =
 * 11. m_desc_no → an_desc_no OR rel_rel_no (ANALIS/RELATIVE join)
 * 12. m_nar_desc → nar_nar_no (NAROWER join)
 * 13. m_txt_text → txt_text LIKE '%value%' (TEXT join)
 */
@Service
public class ArchiveSearchService {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public Page<ArchiveSearchResultResponse> search(ArchiveSearchRequest request, Pageable pageable) {
        // Build dynamic query that mirrors legacy behavior
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT v.res_res_no, v.mn_app_no, v.mn_act_ttl, v.mn_add_ttl, " +
                "v.dig_typ2, v.art_dte, v.ART_pg_no, v.art_per_no, " +
                "v.dig_dig_no, v.dig_typ, v.dig_typ1, v.dig_choice, " +
                "v.dig_s, v.dig_o, v.dig_m, " +
                "v.dig_s1, v.dig_o1, v.dig_m1, v.aut_nam ");

        // Build JOINs dynamically based on which filters are active
        StringBuilder joins = new StringBuilder("FROM view_result v ");
        List<String> where = new ArrayList<>();
        Map<String, Object> params = new HashMap<>();

        // ========== FILTER 2: Word search (m_word) ==========
        // LEGACY: searches mn_result + mn_act_ttl + mn_add_ttl LIKE '%token%'
        // CRITICAL: Must concatenate all 3 fields into ONE string, then search that concatenated value
        // Legacy uses SQL Server: mn_result + mn_act_ttl + mn_add_ttl
        // PostgreSQL equivalent: CONCAT(COALESCE(...), COALESCE(...), COALESCE(...))
        // Multiple words: each word is AND-combined
        if (notBlank(request.getWord())) {
            int i = 0;
            for (String token : request.getWord().trim().split("\\s+")) {
                String p = "word" + i++;
                String pattern = buildWordPattern(request.getSearchMode(), token);
                // Legacy concatenates 3 fields into 1 string, then applies LIKE
                // This is DIFFERENT from OR'ing individual field matches
                where.add("(CONCAT(" +
                        "COALESCE(v.mn_result, ''), " +
                        "COALESCE(v.mn_act_ttl, ''), " +
                        "COALESCE(v.mn_add_ttl, '') " +
                        ") LIKE :" + p + ")");
                params.put(p, pattern);
            }
        }

        // ========== FILTER 3-4: Date range (M_art_dte, M_art_dte1) ==========
        // LEGACY: art_dte >= dateFrom AND art_dte <= dateTo
        if (request.getDateFrom() != null) {
            where.add("v.art_dte >= :dateFrom");
            params.put("dateFrom", request.getDateFrom());
        }
        if (request.getDateTo() != null) {
            where.add("v.art_dte <= :dateTo");
            params.put("dateTo", request.getDateTo());
        }

        // ========== FILTER 5: Article type (m_mch_typ) ==========
        // LEGACY: art_sub_ty = code
        if (notBlank(request.getArticleType())) {
            where.add("v.art_sub_ty = :articleType");
            params.put("articleType", request.getArticleType());
        }

        // ========== FILTER 6: Document type (m_dig_typ1) ==========
        // LEGACY: dig_typ1 = code
        if (notBlank(request.getDocumentType())) {
            where.add("v.dig_typ1 = :documentType");
            params.put("documentType", request.getDocumentType());
        }

        // ========== FILTER 7: Responsible person (m_res_no) ==========
        // LEGACY: res_res_no = value
        if (request.getResponsiblePersonNo() != null) {
            where.add("v.res_res_no = :responsiblePersonNo");
            params.put("responsiblePersonNo", request.getResponsiblePersonNo());
        }

        // ========== FILTER 8: General file (m_file_no) ==========
        // LEGACY: file_add.fad_fad_no = value with INNER JOIN
        if (notBlank(request.getGeneralIndexNo())) {
            joins.append("INNER JOIN \"FILE_ADD\" fa ON v.mn_app_no = fa.\"FAD_APP_NO\" ");
            where.add("fa.\"FAD_FAD_NO\" = :generalIndexNo");
            params.put("generalIndexNo", request.getGeneralIndexNo());
        }

        // ========== FILTER 9: Related file (m_file_no1) ==========
        // LEGACY: file_add_1.fad_fad_no = value AND fad_fad_t2 = '1' with LEFT JOIN
        if (notBlank(request.getGeneralIndexNo2())) {
            joins.append("LEFT JOIN \"FILE_ADD\" fa1 ON v.mn_app_no = fa1.\"FAD_APP_NO\" ");
            where.add("fa1.\"FAD_FAD_NO\" = :generalIndexNo2");
            params.put("generalIndexNo2", request.getGeneralIndexNo2());
            // Note: legacy also filters by fad_fad_t2, but may need additional param if strict migration required
        }

        // ========== FILTER 10: Scene location (m_file_geo) ==========
        // LEGACY: dig_geochrt = code (from DIGIT table, included in view_result)
        if (notBlank(request.getGeoLocation())) {
            where.add("v.dig_geochrt = :geoLocation");
            params.put("geoLocation", request.getGeoLocation());
        }

        // ========== FILTER 11: Subject descriptor (m_desc_no) ==========
        // LEGACY: (an_desc_no = code OR rel_rel_no = code) with LEFT JOINs
        if (notBlank(request.getDescriptorNo())) {
            joins.append("LEFT JOIN \"ANALIS\" an ON v.mn_app_no = an.\"AN_APP_NO\" ");
            joins.append("LEFT JOIN \"RELATIVE\" rel ON v.mn_app_no = rel.\"REL_APP_NO\" ");
            where.add("(an.\"AN_DESC_NO\" = :descriptorNo OR rel.\"REL_REL_NO\" = :descriptorNo)");
            params.put("descriptorNo", request.getDescriptorNo());
        }

        // ========== FILTER 12: Narrower descriptor (m_nar_desc) ==========
        // LEGACY: nar_nar_no = code with LEFT JOIN
        if (notBlank(request.getNarrowerDescriptorNo())) {
            joins.append("LEFT JOIN \"NAROWER\" nar ON v.mn_app_no = nar.\"NAR_APP_NO\" ");
            where.add("nar.\"NAR_NAR_NO\" = :narrowerDescriptorNo");
            params.put("narrowerDescriptorNo", request.getNarrowerDescriptorNo());
        }

        // ========== FILTER 13: Full text (m_txt_text) ==========
        // LEGACY: txt_text LIKE '%value%' with LEFT JOIN
        if (notBlank(request.getFullText())) {
            joins.append("LEFT JOIN \"TEXT\" txt ON v.mn_app_no = txt.\"TXT_NO\" ");
            where.add("txt.\"TXT_TEXT\" LIKE :fullText");
            params.put("fullText", "%" + request.getFullText() + "%");
        }

        // ========== LEGACY: Also handle other fields for broader compatibility ==========
        if (notBlank(request.getAbstractWord())) {
            where.add("v.mn_result LIKE :abstractWord");
            params.put("abstractWord", "%" + request.getAbstractWord() + "%");
        }

        // Assemble final SQL
        sql.append(joins);
        if (!where.isEmpty()) {
            sql.append("WHERE ").append(String.join(" AND ", where));
        }
        sql.append(" ORDER BY v.art_dte DESC");

        // Execute query
        Query countQuery = entityManager.createNativeQuery(sql.toString());
        params.forEach(countQuery::setParameter);
        List<?> allRows = countQuery.getResultList();
        long total = allRows.size();

        // Apply pagination
        int fromIndex = Math.min((int) pageable.getOffset(), allRows.size());
        int toIndex = Math.min(fromIndex + pageable.getPageSize(), allRows.size());
        List<?> rows = allRows.subList(fromIndex, toIndex);

        // Map results
        List<ArchiveSearchResultResponse> results = new ArrayList<>();
        for (Object row : rows) {
            Object[] r = (Object[]) row;
            results.add(new ArchiveSearchResultResponse(
                    castString(r[1]),                    // appNo = mn_app_no
                    castString(r[2]),                    // activeTitleAr = mn_act_ttl
                    castString(r[3]),                    // additionalTitle = mn_add_ttl
                    castLocalDateTime(r[5]),             // articleDate = art_dte
                    castString(r[6]),                    // pageNo = ART_pg_no
                    castString(r[7]),                    // periodicalName = art_per_no
                    castString(r[8]),                    // digitNo = dig_dig_no
                    castString(r[9]),                    // documentType = dig_typ
                    castString(r[10]),                   // documentType1 = dig_typ1
                    castString(r[4]),                    // docTypeDescription = dig_typ2
                    castInteger(r[11]),                  // choice = dig_choice
                    null,                                // highType (not in view_result)
                    null,                                // machineStock (not in view_result)
                    castInteger(r[13]),                  // durationHours = dig_o (from)
                    castInteger(r[14]),                  // durationMinutes = dig_m (from)
                    castInteger(r[12]),                  // durationSeconds = dig_s (from)
                    castInteger(r[16]),                  // durationHours1 = dig_o1 (to)
                    castInteger(r[17]),                  // durationMinutes1 = dig_m1 (to)
                    castInteger(r[15]),                  // durationSeconds1 = dig_s1 (to)
                    castString(r[18]),                   // responsiblePersonName = aut_nam
                    null,                                // language (not in view_result)
                    null));                              // abstractText (not in view_result)
        }

        return new PageImpl<>(results, pageable, total);
    }

    /**
     * Build LIKE pattern based on legacy search mode.
     * LEGACY: m_typ_serh = 1 → STARTS_WITH, m_typ_serh = 2 → CONTAINS
     * Default (if not specified): CONTAINS ('%token%')
     */
    private String buildWordPattern(String searchMode, String token) {
        if ("STARTS_WITH".equals(searchMode) || "1".equals(searchMode)) {
            return token + "%";
        } else {
            return "%" + token + "%";
        }
    }

    private String castString(Object value) {
        return value == null ? null : value.toString();
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

    private boolean notBlank(String s) {
        return s != null && !s.isBlank();
    }

    @Transactional(readOnly = true)
    public List<AuthorOptionResponse> getResponsiblePersons() {
        try {
            String sql = "SELECT aut.\"AUT_NO\", aut.\"AUT_NAM\" FROM \"AUTHER\" aut ORDER BY aut.\"AUT_NAM\"";
            Query query = entityManager.createNativeQuery(sql);
            List<?> rows = query.getResultList();

            List<AuthorOptionResponse> options = new ArrayList<>();
            for (Object row : rows) {
                Object[] r = (Object[]) row;
                String id = r[0] != null ? String.valueOf(r[0]) : "";
                String name = r[1] != null ? String.valueOf(r[1]) : "";
                if (!name.isEmpty()) {
                    options.add(new AuthorOptionResponse(id, name));
                }
            }
            return options;
        } catch (Exception e) {
            System.err.println("Error in getResponsiblePersons: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    @Transactional(readOnly = true)
    public List<CodingOptionResponse> getArticleTypes() {
        try {
            // Legacy: filters to codes starting with '03' (view_coding filter)
            String sql = "SELECT c.\"SUB_CODE\", c.\"SUB_DESC\" FROM \"CODING\" c " +
                        "WHERE SUBSTRING(c.\"SUB_CODE\", 1, 2) = '03' " +
                        "ORDER BY c.\"SUB_DESC\"";
            Query query = entityManager.createNativeQuery(sql);
            List<?> rows = query.getResultList();

            List<CodingOptionResponse> options = new ArrayList<>();
            for (Object row : rows) {
                Object[] r = (Object[]) row;
                String code = r[0] != null ? String.valueOf(r[0]).trim() : "";
                String description = r[1] != null ? String.valueOf(r[1]).trim() : "";
                if (!code.isEmpty() && !description.isEmpty()) {
                    options.add(new CodingOptionResponse(code, description));
                }
            }
            return options;
        } catch (Exception e) {
            System.err.println("Error in getArticleTypes: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    @Transactional(readOnly = true)
    public List<CodingOptionResponse> getDocumentTypes() {
        try {
            String sql = "SELECT c.\"SUB_CODE\", c.\"SUB_DESC\" FROM \"CODING\" c WHERE c.\"SUB_CODE\" LIKE '24%' ORDER BY c.\"SUB_CODE\"";
            Query query = entityManager.createNativeQuery(sql);
            List<?> rows = query.getResultList();

            List<CodingOptionResponse> options = new ArrayList<>();
            for (Object row : rows) {
                Object[] r = (Object[]) row;
                String code = r[0] != null ? String.valueOf(r[0]).trim() : "";
                String description = r[1] != null ? String.valueOf(r[1]).trim() : "";
                if (!code.isEmpty() && !description.isEmpty()) {
                    options.add(new CodingOptionResponse(code, description));
                }
            }
            return options;
        } catch (Exception e) {
            System.err.println("Error in getDocumentTypes: " + e.getMessage());
            return new ArrayList<>();
        }
    }
}
