/** One MACNZ row in a Form5 DataList — SUB_DESC shown, sub_code behind it. */
export interface ThesaurusTerm {
  code: string | null;
  level: string | null;
  description: string | null;
}

/**
 * The RecordSource held by one of Form5's macnz1/2/3 data controls; "Refresh" re-runs it.
 *  LEVEL1   — execute proc_macnz1
 *  CHILDREN — execute proc_macnz 1, 2|6, level, Mid(parentCode, 1, 2|6)
 *  PREFIX   — execute serh_macnz desc, Len(Trim(desc))
 *  WORD     — execute serh_wrdmacnz desc, Len(Trim(desc))
 */
export type ThesaurusQuery =
  | { query: 'LEVEL1' }
  | { query: 'CHILDREN'; level: '2' | '3'; parentCode: string }
  | { query: 'PREFIX'; text: string }
  | { query: 'WORD'; text: string };

export interface SubjectThesaurusContext {
  userNo: string | null;
  canWrite: boolean;
}
