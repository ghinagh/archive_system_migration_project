package com.startupstack.app.modules.searchscreen.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Mirrors the legacy "شاشة البحث" (user_interface.frm, Section 1 — Command1_Click,
 * :1885-2204) search-criteria panel: one property per one of the 22 physical input
 * controls, all optional and strictly AND-combined (legacy never ORs any two fields).
 *
 * This is a dedicated DTO/service, deliberately not sharing ArchiveSearchRequest/
 * ArchiveSearchService — those belong to the separate "شاشة البحث فيديو + صوتي"
 * screen (USER_INTERFACE1.frm, already migrated as /archive-search) and reproduce
 * different join semantics (e.g. an OR between descriptor fields, an INNER JOIN on
 * the file lookup) that would be wrong here.
 */
@Getter
@Setter
public class SearchScreenRequest {

    /** Legacy Option1/Option2 (m_typ_serh). "STARTS_WITH" or "CONTAINS"; governs only
     *  the 6 lookup-popup fields below, never {@link #titleWord}. */
    private String searchMode;

    // --- 6 lookup-popup fields (DBList1/DBList2), value = the code picked from the popup ---

    /** m_desc_no "الموضوع" — ANALIS.AN_DESC_NO. */
    private String subjectDescriptorCode;
    /** m_rel_text "المترابط" — RELATIVE.REL_REL_NO. */
    private String relatedDescriptorCode;
    /** m_nar_text "الاضيق" — NAROWER.NAR_NAR_NO. */
    private String narrowerDescriptorCode;
    /** m_file_no "الملف الاضافي" — FILE_ADD.FAD_FAD_NO. */
    private String additionalFileCode;
    /** m_geo_text "المكان الجغرافي" — GEO.GEO_GEO_NO. */
    private String geoLocationCode;
    /** m_geo_chrt "مكان التصوير/النشر" — DIGIT.dig_geochrt. */
    private String photoPlaceCode;

    // --- 6 plain text fields ---

    /** m_word "كلمة من العناوين" — MAIN.MN_ACT_TTL + MN_ADD_TTL LIKE. */
    private String titleWord;
    /** m_dig_dig_no "رقم digital" — DIGIT.DIG_DIG_NO LIKE. */
    private String digitAssetNo;
    /** m_dig_nochrt "رقم الارشيف القديم" — DIGIT.DIG_NOCHRT LIKE. */
    private String oldArchiveNo;
    /** m_mn_result "كلمة من المستخلص" — MAIN.MN_RESULT LIKE. */
    private String abstractWord;
    /** m_txt_text "كلمة من النص" — TEXT.TXT_MEM LIKE, joined via TEXT.TXT_APP_NO. */
    private String fullText;
    /** m_art_pg_no "عدد الصفحات" — ARTICLE.ART_PG_NO, compared as Val(text) (numeric coercion). */
    private String pageNo;

    // --- 6 DataCombo dropdowns, value = 2-char domain-stripped code (Mid(BoundText,3,2))
    //     except periodicalNo/responsiblePersonNo which are exact numeric codes (no stripping) ---

    /** m_art_lang "اللغة" — ARTICLE.ART_LANG1. */
    private String language;
    /** m_art_sub_ty "نوع الوثيقة" (right column) — ARTICLE.ART_SUB_TY. */
    private String articleType;
    /** m_art_per_no "جهة الصدور" — ARTICLE.ART_PER_NO / PERIOD.PER_PER_NO. */
    private Double periodicalNo;
    /** m_res_no "المسؤول البياني" — RES.RES_RES_NO / AUTHER.AUT_NO. */
    private Double responsiblePersonNo;
    /** m_dig_typ1 "نوع الوثيقة" (bottom-left) — DIGIT.DIG_TYP1. */
    private String documentType;
    /** m_mn_data_en "مدخل البيانات" — MAIN.MN_DATA_EN. */
    private String dataEntryOperator;

    // --- 4 date fields ---

    /** M_art_dte "من تاريخ" — ARTICLE.ART_DTE >=. */
    private LocalDateTime dateFrom;
    /** M_art_dte1 "الى تاريخ" — ARTICLE.ART_DTE <=. */
    private LocalDateTime dateTo;
    /** m_ent_dte "من تاريخ الادخال" — MAIN.MN_ENT_DTE >=. */
    private LocalDateTime entryDateFrom;
    /** m_ent_dte1 "الى تاريخ الادخال" — MAIN.MN_ENT_DTE <=. */
    private LocalDateTime entryDateTo;
}
