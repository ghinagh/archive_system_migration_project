export interface Periodical {
  perNo: number;
  name: string;
  publishLocation: number | null;
  startDate: string | null;
  lang: string;
  rdmd: string;
  type: number | null;
  geo: string;
  type1: string;
  frequency: string;
  address: string;
  phone: string;
  amount: number | null;
  price: number | null;
  price1: number | null;
  publisher: number | null;
  pub: string;
  institution: string;
  editor: string;
  director: string;
  president: string;
  fax: string;
  creator: string;
  email: string;
  website: string;
  date: string | null;
  utils: string;
  geo1: string;
  tah1: string;
}

export interface PeriodicalRequest {
  name: string;
  publishLocation: number | null;
  startDate: string | null;
  lang: string;
  rdmd: string;
  type: number | null;
  geo: string;
  type1: string;
  frequency: string;
  address: string;
  phone: string;
  amount: number | null;
  price: number | null;
  price1: number | null;
  publisher: number | null;
  pub: string;
  institution: string;
  editor: string;
  director: string;
  president: string;
  fax: string;
  creator: string;
  email: string;
  website: string;
  date: string | null;
  utils: string;
  geo1: string;
  tah1: string;
}

export interface Transaction {
  trsOpno: number;
  trsNo: number;
  trsDte: string | null;
  trsNum: string;
  trsNb: number | null;
  trsYear: number | null;
  trsTyp: number | null;
  trsDte1: string | null;
}

export interface TransactionRequest {
  trsOpno: number;
  trsNo: number;
  trsDte: string | null;
  trsNum: string;
  trsNb: number | null;
  trsYear: number | null;
  trsTyp: number | null;
  trsDte1: string | null;
}
