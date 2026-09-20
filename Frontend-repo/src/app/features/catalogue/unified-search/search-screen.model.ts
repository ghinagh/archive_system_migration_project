/**
 * Legacy "شاشة البحث" (user_inetrface.frm, Section 1 — Command1_Click). One property
 * per one of the 22 physical input controls; every one is optional and strictly
 * AND-combined server-side. See SearchScreenService/SearchScreenController on the backend.
 */
export interface SearchScreenRequest {
  /** Option1/Option2 (m_typ_serh) — governs only the 6 lookup-popup fields below. */
  searchMode?: 'STARTS_WITH' | 'CONTAINS';

  subjectDescriptorCode?: string;   // m_desc_no "الموضوع"
  relatedDescriptorCode?: string;   // m_rel_text "المترابط"
  narrowerDescriptorCode?: string;  // m_nar_text "الاضيق"
  additionalFileCode?: string;      // m_file_no "الملف الاضافي"
  geoLocationCode?: string;         // m_geo_text "المكان الجغرافي"
  photoPlaceCode?: string;          // m_geo_chrt "مكان التصوير/النشر"

  titleWord?: string;               // m_word "كلمة من العناوين"
  digitAssetNo?: string;            // m_dig_dig_no "رقم digital"
  oldArchiveNo?: string;            // m_dig_nochrt "رقم الارشيف القديم"
  abstractWord?: string;            // m_mn_result "كلمة من المستخلص"
  fullText?: string;                // m_txt_text "كلمة من النص"
  pageNo?: string;                  // m_art_pg_no "عدد الصفحات"

  language?: string;                // m_art_lang "اللغة"
  articleType?: string;             // m_art_sub_ty "نوع الوثيقة" (right column)
  periodicalNo?: number;            // m_art_per_no "جهة الصدور"
  responsiblePersonNo?: number;     // m_res_no "المسؤول البياني"
  documentType?: string;            // m_dig_typ1 "نوع الوثيقة" (bottom-left)
  dataEntryOperator?: string;       // m_mn_data_en "مدخل البيانات"

  dateFrom?: string;                // M_art_dte "من تاريخ"
  dateTo?: string;                  // M_art_dte1 "الى تاريخ"
  entryDateFrom?: string;           // m_ent_dte "من تاريخ الادخال"
  entryDateTo?: string;             // m_ent_dte1 "الى تاريخ الادخال"
}
