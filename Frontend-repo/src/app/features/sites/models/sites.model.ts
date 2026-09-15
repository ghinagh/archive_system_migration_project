export interface FormDefinition {
  formNo: string;
  formType: string;
  name: string;
  date: string | null;
  user: string;
  section: number;
  jihadNo: number;
  printName: string;
}

export interface FormRequest {
  formNo: string;
  formType?: string;
  name?: string;
  date?: string;
  user?: string;
  section?: number;
  jihadNo?: number;
  printName?: string;
}

export interface Site {
  siteNo: string;
  formName: string;
  levelNo: string;
  level: string;
  process: string;
  description: string;
  docNo: string;
  startDate: string | null;
  endDate: string | null;
  free: number;
  type: string;
  wilyaNo: number;
  status: string;
  user: string;
  permission: number;
  accessLevel: string;
  kind: string;
}

export interface SiteRequest {
  siteNo: string;
  levelNo?: string;
  level?: string;
  process?: string;
  description?: string;
  docNo?: string;
  startDate?: string;
  endDate?: string;
  free?: number;
  type?: string;
  wilyaNo?: number;
  status?: string;
  user?: string;
  permission?: number;
  accessLevel?: string;
  kind?: string;
}

export interface Post {
  serial: string;
  formNo: string;
  formName: string;
  siteNo: string;
  docNo: string;
  startDate: string | null;
  endDate: string | null;
  wilyaNo: number;
  status: number;
  levelNo: string;
  type: number;
  user: string;
  permission: number;
  level: string;
}

export interface PostRequest {
  serial: string;
  formNo?: string;
  siteNo?: string;
  docNo?: string;
  startDate?: string;
  endDate?: string;
  wilyaNo?: number;
  status?: number;
  levelNo?: string;
  type?: number;
  user?: string;
  permission?: number;
  level?: string;
}

export interface SubjectLink {
  formNo: string;
  mcnzCode: string;
  mcnzDesc: string | null;
  subDte: string | null;
  subDte1: string | null;
  subRel: string | null;
}

export interface SubjectLinkRequest {
  mcnzCode: string;
  subDte?: string;
  subDte1?: string;
  subRel?: string;
}

export interface RelForm {
  form1No: string;
  form2No: string;
  form2Name: string | null;
  rlfDte: string | null;
  rlfDte1: string | null;
  rlfRel: string | null;
}

export interface RelFormRequest {
  form2No: string;
  rlfDte?: string;
  rlfDte1?: string;
  rlfRel?: string;
}

export interface Position {
  posNo: string;
  name: string | null;
  recordDate: string | null;
}

export interface PositionRequest {
  posNo: string;
  name?: string;
  recordDate?: string;
}
