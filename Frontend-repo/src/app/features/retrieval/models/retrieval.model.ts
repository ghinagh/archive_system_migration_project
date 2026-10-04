/**
 * Which legacy sort_form branch a screen talks to (ARCHIVE.frm main_form 1 / 2 / 3): the bank
 * retrieval (bnkout / view_user_bnkout / tmp_result over MAIN), the additional-files retrieval
 * (POUT '02' / view_user_pout / tmp_result1 over FORM) or the newspapers & magazines retrieval
 * (POUT '06' / view_user_pout / tmp_result2 over PERIOD + TRANS). Same UI, different data — see
 * the backend RetrievalScope enum for the evidence.
 */
export type RetrievalScope = 'BANK' | 'ADDITIONAL_FILES' | 'PERIODICALS';

/** Route and title of each scope's builder screen (results live at `${path}/results`). */
export const RETRIEVAL_SCOPE_SCREENS: Record<RetrievalScope, { path: string; titleKey: string }> = {
  BANK: { path: '/retrieval', titleKey: 'RETRIEVAL.TITLE' },
  ADDITIONAL_FILES: { path: '/retrieval/additional-files', titleKey: 'NAV.FILES_RETRIEVAL' },
  PERIODICALS: { path: '/retrieval/periodicals', titleKey: 'NAV.PERIODICALS_RETRIEVAL' }
};

export type RetrievalFieldType = 'STRING' | 'NUMBER' | 'DATE';

export interface RetrievalFieldOption {
  fieldKey: string;
  label: string;
  category: string;
  fieldType: RetrievalFieldType;
  lookupEnabled: boolean;
  /**
   * Legacy bnkout.out_slct1 equivalent (the field's legacy source table), used to gate the
   * F8/F9 keyboard shortcuts exactly as sort_form.frm's c_getcond_KeyDown did. Null until real
   * legacy row data is supplied — see the migration audit for why it can't be reconstructed.
   */
  legacySourceTable: string | null;
  /** Legacy F2 (DBList2_77) "#" marker — global per-field flag, not per-user. */
  hashMarked: boolean;
  /**
   * Legacy coded condition (out_nature 2, c_getcond): the value is picked by name from
   * lookupCodes and the condition carries its code.
   */
  codeLookup: boolean;
}

/** One c_getcond entry: the name shown (ListField) and the code it resolves to (BoundColumn). */
export interface RetrievalCodeOption {
  code: string;
  label: string;
}

/** One field's persisted per-user display/order marks (legacy view_user_bnkout row). */
export interface RetrievalUserFieldState {
  fieldKey: string;
  display: boolean;
  orderMark: boolean;
}

export type RetrievalConjunction = 'AND' | 'OR';

export interface RetrievalConditionNode {
  type: 'FIELD' | 'GROUP';
  conjunction: RetrievalConjunction;
  fieldKey?: string;
  operator?: string;
  value?: string;
  value2?: string;
  children?: RetrievalConditionNode[];
}

export interface RetrievalSearchRequest {
  rootCondition: RetrievalConditionNode | null;
  outputFieldKeys: string[];
  /** Legacy F10 ("حقول العرض في الجدول") order-field marks, in the order they were marked. */
  orderFieldKeys?: string[];
  page: number;
  size: number;
}

export interface RetrievalColumn {
  fieldKey: string;
  label: string;
}

export interface RetrievalResultRow {
  appNo: string;
  values: Record<string, unknown>;
}

export interface RetrievalSearchResponse {
  columns: RetrievalColumn[];
  rows: RetrievalResultRow[];
  totalElements: number;
  page: number;
  size: number;
}

/** One token in the accumulator, in the exact order the user built it — mirrors legacy x_criteria. */
export type AccumulatorToken =
  | { kind: 'CONDITION'; display: string; fieldKey: string; operator: string; value: string; value2?: string }
  | { kind: 'AND' | 'OR' | 'LPAREN' | 'RPAREN' };
