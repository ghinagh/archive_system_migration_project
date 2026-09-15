export interface OutputTemplate {
  id: number;
  outputNum: number;
  description: string;
  name: string;
  field: string;
  extension: string;
  length: number;
  length1: number;
  condition: string;
  display: string;
  selectClause: string;
  fieldSelect: string;
  seek: string;
  ifCondition: string;
  choice: number;
  nature: string;
  type: string;
  category: string;
  subCondition?: string;
  mainCondition?: string;
  subCondition0?: string;
  codeName?: string;
}

export interface ColumnMeta {
  fieldName: string;
  label: string;
  width: number;
}

export interface ReportExecutionResult {
  templateNum: number;
  title: string;
  columns: ColumnMeta[];
  rows: Record<string, unknown>[];
  totalRows: number;
}

export interface OutputTemplateRequest {
  outputNum?: number;
  description?: string;
  name?: string;
  field?: string;
  extension?: string;
  length?: number;
  length1?: number;
  condition?: string;
  display?: string;
  selectClause?: string;
  fieldSelect?: string;
  seek?: string;
  ifCondition?: string;
  choice?: number;
  nature?: string;
  type?: string;
  category?: string;
}

export interface UserOutput {
  institutionNo: string;
  userNo: string;
  outputNum: number;
  outputChoice: number;
  userIndex: string;
  sign: string;
  outputChoice1: number;
  sign1: string;
}

export interface UserOutputRequest {
  institutionNo: string;
  userNo: string;
  outputNum: number;
  outputChoice?: number;
  userIndex?: string;
  sign?: string;
  outputChoice1?: number;
  sign1?: string;
}
