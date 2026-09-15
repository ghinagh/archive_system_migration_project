package com.startupstack.app.modules.archivesearch.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Mirrors the legacy USER_INTERFACE1.frm "البحث في الارشيف" (Archive Search) criteria panel —
 * one field per filter the librarian could fill in, all optional and AND-combined.
 */
@Getter
@Setter
public class ArchiveSearchRequest {

    /** Word from the scene title/abstract (mn_result + mn_act_ttl + mn_add_ttl LIKE). */
    @Size(max = 200)
    private String word;

    private LocalDateTime dateFrom;
    private LocalDateTime dateTo;

    /** Article subtype (ART_SUB_TY). */
    @Size(max = 3)
    private String articleType;

    /** Document/digital type (DIG_TYP1). */
    @Size(max = 2)
    private String documentType;

    /** Author/responsible-person number (AUT_NO). */
    private Double responsiblePersonNo;

    /** General index entry (persons/institutions/places/events/misc — FAD_FAD_NO). */
    @Size(max = 20)
    private String generalIndexNo;

    /** Second general-index entry — legacy m_file_no1 "ملف له", a distinct FILE_ADD lookup
     *  restricted to FAD_FAD_T2 = '1' (its own join alias, independent of generalIndexNo). */
    @Size(max = 20)
    private String generalIndexNo2;

    /** Scene shooting location (DIG_GEOCHRT). */
    @Size(max = 10)
    private String geoLocation;

    /** Subject-analysis descriptor code (ANALIS) — legacy m_desc_no "المستخلص". */
    @Size(max = 20)
    private String descriptorNo;

    /** Related/relative thesaurus term (RELATIVE) — legacy m_rel_text "المترابط", distinct from descriptorNo. */
    @Size(max = 20)
    private String relatedDescriptorNo;

    /** Narrower thesaurus term (NAROWER) — legacy m_nar_text "الاضيق". */
    @Size(max = 20)
    private String narrowerDescriptorNo;

    /** Free full-text search (text1.txt_text) — legacy m_txt_text "الموضوع". */
    @Size(max = 200)
    private String fullText;

    /** Word from the abstract (main.MN_RESULT) — legacy m_mn_result "كلمة من النص", distinct from fullText's text1 join. */
    @Size(max = 200)
    private String abstractWord;

    /** "شاشة البحث" (user_interface.frm) additions — this same query engine also backs that screen. */

    private LocalDateTime entryDateFrom;
    private LocalDateTime entryDateTo;

    /** Article language (ART_LANG). */
    @Size(max = 5)
    private String language;

    /** Issuing periodical (PER_PER_NO). */
    private Double periodicalNo;

    /** Page count (ART_PG_NO). */
    @Size(max = 5)
    private String pageNo;

    /** Exact digitized-asset number (DIG_DIG_NO). */
    @Size(max = 6)
    private String digitAssetNo;

    /** Old archive/chart number (DIG_NOCHRT) — distinct from geoLocation (DIG_GEOCHRT). */
    @Size(max = 6)
    private String chartNo;

    /**
     * STARTS_WITH or CONTAINS. Retained for the sibling user_interface.frm screen that shares
     * this DTO. It is deliberately NOT applied to {@code word}: on USER_INTERFACE1.frm the
     * equivalent legacy flag (m_typ_serh) drives only the lookup popups, while the main
     * title/abstract match at :3033 is unconditionally {@code LIKE '%token%'}.
     */
    @Size(max = 12)
    private String searchMode;
}
