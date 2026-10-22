/** One config row exactly as "select config.* from config" returns it (column name → value). */
export type ConfigRow = Record<string, string | number | null>;

/** DataGrid3 (t_bnkout) row; istNo addresses the user_bnkout row behind it. */
export interface FieldRow {
  istNo: string | null;
  userNo: string | null;
  outNum: number | null;
  outDesc: string | null;
  outChoice: number | null;
  outIndex: string | null;
}

/** DataGrid2 (ranjpath) row. */
export interface RangeRow {
  rjpNo: number;
  rjpNofrom: string | null;
  rjpNoto: string | null;
  rjpPath: string | null;
  rjpTyp: number | null;
}

/** m_ist_no "نوع الاستمارة" item (VIEW_CODING38). */
export interface FormType {
  code: string;
  desc: string | null;
}
