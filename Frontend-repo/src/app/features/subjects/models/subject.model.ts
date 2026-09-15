export interface MacnzSubject {
  code: string;
  level: string;
  description: string;
  logic: number | null;
}

export interface MacnzRequest {
  code: string;
  level: string;
  description: string;
}

export interface SubjectTreeNode {
  code: string;
  description: string;
  level: string;
  children: SubjectTreeNode[];
}

export interface SubjectAnalysis {
  id: number;
  appNo: string;
  descriptorNo: string;
  serialNo: string;
}

export interface SubjectAnalysisRequest {
  descriptorNo: string;
  serialNo: string;
}

export interface CodingEntry {
  level: string;
  code: string;
  description: string | null;
}

export interface CodingRequest {
  level: string;
  code: string;
  description?: string;
}

export interface ChartItem {
  id: number;
  chaNo: string;
  title: string | null;
  date: string | null;
  stock: number | null;
}
