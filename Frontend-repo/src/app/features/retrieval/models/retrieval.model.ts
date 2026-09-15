export type RetrievalFieldType = 'STRING' | 'NUMBER' | 'DATE';

export interface RetrievalFieldOption {
  fieldKey: string;
  label: string;
  category: string;
  fieldType: RetrievalFieldType;
  lookupEnabled: boolean;
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
