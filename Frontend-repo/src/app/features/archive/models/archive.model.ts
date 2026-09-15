export interface ChartItem {
  id: number;
  chaNo: string;
  subject: string;
  type: number;
  time: number;
  date: string | null;
  number: number;
  type1: number;
  source: string;
  date1: string | null;
  title: string;
  stock: number;
  nbDis: number;
  subjectCode: string;
  fromSite: string;
  toSite: string;
  fromPerson: string;
  toPerson: string;
  operationNo: string;
  timeCode: string;
}

export interface ChartRequest {
  chaNo: string;
  subject?: string;
  type?: number;
  time?: number;
  date?: string;
  number?: number;
  type1?: number;
  source?: string;
  date1?: string;
  title?: string;
  stock?: number;
  nbDis?: number;
  subjectCode?: string;
  fromSite?: string;
  toSite?: string;
  fromPerson?: string;
  toPerson?: string;
  operationNo?: string;
  timeCode?: string;
}

export interface ChartOperation {
  id: number;
  oprNo: string;
  serial: number;
  chartNo: string;
  subject: string;
  date: string | null;
  time: string;
  fromSite: string;
  fromPerson: string;
  toSite: string;
  toPerson: string;
  returnDate: string | null;
  remark: string;
  title: string;
  transferred: boolean;
  choice: string;
  externalCode: string;
}

export interface OperationRequest {
  oprNo?: string;
  subject?: string;
  date?: string;
  time?: string;
  fromSite?: string;
  fromPerson?: string;
  toSite?: string;
  toPerson?: string;
  returnDate?: string;
  remark?: string;
  title?: string;
  transferred: boolean;
  choice?: string;
  externalCode?: string;
}
