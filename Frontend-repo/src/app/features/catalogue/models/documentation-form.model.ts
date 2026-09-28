export interface DocumentationFormRequest {
  appNo: string;
  activeTitleAr: string | null;
  additionalCatalogueTitle: string | null;
  dataEntry: string | null;
  appDoc: string | null;
  entryDate: string | null;
  result: string | null;
  documentNature: string | null;
  date: string | null;
  periodicalNo: number | null;
  subjectType: string | null;
  pageNo: string | null;
  articleNo: number | null;
  lang: string | null;
  lang1: string | null;
  date1: string | null;
  periodical1: number | null;
}

export interface DocumentationFormResponse {
  appNo: string;
  catalogueTitle: string | null;
  additionalTitle: string | null;
  dataEntry: string | null;
  appDoc: string | null;
  entryDate: string | null;
  result: string | null;
  documentNature: string | null;
  date: string | null;
  periodicalNo: number | null;
  periodicalName: string | null;
  subjectType: string | null;
  pageNo: string | null;
  articleNo: number | null;
  lang: string | null;
  lang1: string | null;
  date1: string | null;
  periodical1: number | null;
  /** PERIOD name for periodical1 — "مصدر الترجمة" display text. */
  periodical1Name?: string | null;
  locked: boolean | null;
}
