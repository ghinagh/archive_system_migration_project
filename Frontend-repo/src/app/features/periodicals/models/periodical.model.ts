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
  utils: number | null;
  geo1: string;
  editingManager: string;
}

/**
 * PER_PUB_LO (publishLocation) and PER_TYP (type) are hardcoded to 0 by
 * PERIOD1.frm on every save (never user-editable); PER_ST_DTE (startDate)
 * and PER_CREAT (creator) are never touched at all by this legacy form's
 * INSR_period/UPD_period calls. None of the four belong in the save payload
 * this screen sends — the backend now owns hardcoding/ignoring them.
 */
export interface PeriodicalRequest {
  perNo: number;
  name: string;
  lang: string;
  rdmd: string;
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
  email: string;
  website: string;
  date: string | null;
  utils: number | null;
  geo1: string;
  editingManager: string;
}
