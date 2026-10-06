/** CODING row (DBList1 = cod2, DBList2 = cod1; ListField SUB_DESC). */
export interface CodingRow { level: string | null; code: string | null; description: string | null; }

/** form row (pay_form / nam_form / serh_*; ListField SUB_NAME); code = SUB_TYP + SUB_NO. */
export interface FormRow { type: string | null; number: string | null; name: string | null; code: string | null; }

/** POSITION row (DBList5; ListField pos_nam). */
export interface PositionRow { number: string | null; name: string | null; recorded: string | null; }

/** rel_form_proc row (DBList6; ListField m_name). */
export interface FormRelationRow {
  form1: string | null; form2: string | null; relation: string | null; name: string | null;
  start: string | null; end: string | null;
}

/** subject_proc row (DBList7; ListField m_sub_desc). */
export interface SubjectRelationRow {
  form: string | null; macnz: string | null; relation: string | null; description: string | null;
  start: string | null; end: string | null;
}

/** MACNZ row for the DBList8 picker (ListField sub_desc). */
export interface MacnzRow { code: string | null; level: string | null; description: string | null; }

export type FormQueryName =
  'COUNTRIES' | 'COUNTRY_SEARCH' | 'NAMES' | 'NAME_SEARCH' | 'ALL_SEARCH' | 'LIKE_SEARCH' | 'WORD_SEARCH';

/** A RecordSource of pays1 / name_form1 / frm_mcnz — Refresh re-runs it. */
export interface FormQuery {
  query: FormQueryName;
  type?: string; country?: string; text?: string; lent?: number; pays?: string;
}

export type MacnzQuery = { query: 'ALL' } | { query: 'PREFIX' | 'WORD'; text: string; lent: number };

export interface SaveResult { saved: boolean; }

/** tmp_fileadd row as tmp_file.frm's DataGrid1 shows it. */
export interface AdditionalFileRow {
  fileNo: string | null; finalFlag: number | null; fileName: string | null; remark: string | null;
  place: string | null; date: string | null; userNo: string | null; serial: number | null;
}

/** One condition of tmp_file.frm's crit1. */
export interface AdditionalFileCriterion {
  kind: 'FROM' | 'TO' | 'USER' | 'WORD' | 'FINAL' | 'NOT_FINAL';
  date?: string | null;
  text?: string | null;
}
