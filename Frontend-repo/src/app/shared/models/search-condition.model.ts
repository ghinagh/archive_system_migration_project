export type SearchOperator = 'EQUALS' | 'CONTAINS' | 'GT' | 'GTE' | 'LT' | 'LTE' | 'BETWEEN';
export type SearchConjunction = 'AND' | 'OR';
export type SearchFieldType = 'STRING' | 'NUMBER' | 'DATE';

export interface SearchFieldDef {
  value: string;
  labelKey: string;
  type: SearchFieldType;
}

export interface SearchCondition {
  field: string;
  operator: SearchOperator;
  value: string;
  value2?: string;
  conjunction: SearchConjunction;
}

export const OPERATORS_BY_TYPE: Record<SearchFieldType, { value: SearchOperator; labelKey: string }[]> = {
  STRING: [
    { value: 'CONTAINS', labelKey: 'ADVANCED_SEARCH.OP_CONTAINS' },
    { value: 'EQUALS', labelKey: 'ADVANCED_SEARCH.OP_EQUALS' }
  ],
  NUMBER: [
    { value: 'EQUALS', labelKey: 'ADVANCED_SEARCH.OP_EQUALS' },
    { value: 'GT', labelKey: 'ADVANCED_SEARCH.OP_GT' },
    { value: 'GTE', labelKey: 'ADVANCED_SEARCH.OP_GTE' },
    { value: 'LT', labelKey: 'ADVANCED_SEARCH.OP_LT' },
    { value: 'LTE', labelKey: 'ADVANCED_SEARCH.OP_LTE' },
    { value: 'BETWEEN', labelKey: 'ADVANCED_SEARCH.OP_BETWEEN' }
  ],
  DATE: [
    { value: 'EQUALS', labelKey: 'ADVANCED_SEARCH.OP_EQUALS' },
    { value: 'GT', labelKey: 'ADVANCED_SEARCH.OP_AFTER' },
    { value: 'GTE', labelKey: 'ADVANCED_SEARCH.OP_ON_OR_AFTER' },
    { value: 'LT', labelKey: 'ADVANCED_SEARCH.OP_BEFORE' },
    { value: 'LTE', labelKey: 'ADVANCED_SEARCH.OP_ON_OR_BEFORE' },
    { value: 'BETWEEN', labelKey: 'ADVANCED_SEARCH.OP_BETWEEN' }
  ]
};
