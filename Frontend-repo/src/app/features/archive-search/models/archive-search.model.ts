export interface ArchiveSearchRequest {
  word?: string;
  dateFrom?: string;
  dateTo?: string;
  articleType?: string;
  documentType?: string;
  responsiblePersonNo?: number;
  generalIndexNo?: string;
  /** Legacy m_file_no1 "ملف له" — a second, independently-typed FILE_ADD lookup. */
  generalIndexNo2?: string;
  geoLocation?: string;
  /** Legacy m_desc_no "رقم من قسم البحث الموضوعي" */
  descriptorNumber?: string;
  /** Legacy m_nar_desc "كل العناصر: محافظات_مراكز_الجهات_البنية الادارية" */
  narrativeDescriptor?: string;
  /** Legacy m_txt_text "نصوص من النص" */
  textSearch?: string;
  descriptorNo?: string;
  relatedDescriptorNo?: string;
  narrowerDescriptorNo?: string;
  fullText?: string;
  abstractWord?: string;
  entryDateFrom?: string;
  entryDateTo?: string;
  language?: string;
  periodicalNo?: number;
  pageNo?: string;
  digitAssetNo?: string;
  chartNo?: string;
  /** 'STARTS_WITH' (legacy F8) or 'CONTAINS' (legacy F9, default) */
  searchMode?: 'STARTS_WITH' | 'CONTAINS';
}

export interface ArchiveSearchResult {
  appNo: string;
  activeTitleAr: string;
  additionalTitle: string | null;
  articleDate: string | null;
  pageNo: string | null;
  periodicalName: string | null;
  digitNo: string | null;
  documentType: string | null;
  documentType1: string | null;
  docTypeDescription: string | null;
  choice: number | null;
  highType: string | null;
  machineStock: string | null;
  durationHours: number | null;
  durationMinutes: number | null;
  durationSeconds: number | null;
  durationHours1: number | null;
  durationMinutes1: number | null;
  durationSeconds1: number | null;
  responsiblePersonName: string | null;
  language: string | null;
  abstractText: string | null;
  fileType?: string | null; // Alias for documentType for display purposes
}

/**
 * The two storage tiers ranjpath.rjp_typ distinguishes: HIGH (rjp_typ 1) is the broadcast
 * master, LOW (rjp_typ 2) the preview proxy. The legacy player always used LOW; the demand's
 * stored path and every delivery pipeline use HIGH.
 */
export type StockTier = 'HIGH' | 'LOW';

export interface MediaResolveInfo {
  resolvedPath: string;
  fileExists: boolean;
}
