export interface BorrowingRecord {
  iarNo: string;
  serial: number;
  borrowingType: number;
  borrowDate: string | null;
  personNo: string;
  personName: string;
  type: number;
  cause: string;
  period: number;
  dueDate: string | null;
  returnDate: string | null;
  remark: string;
  type1: number;
  bookNo: string;
  bookTitle: string;
  entity: string;
  regNo: number;
  deposit: number;
}

export interface BorrowingRequest {
  iarNo: string;
  serial: number;
  borrowingType: number;
  borrowDate: string;
  personNo: string;
  type: number;
  cause: string;
  period: number;
  dueDate: string;
  bookNo: string;
  entity: string;
}

export interface ReturnRequest {
  returnDate: string;
}

export type BorrowingStatus = 'ACTIVE' | 'RETURNED' | 'OVERDUE';

export interface BorrowingBook {
  borrowingNo: string;
  serial: number;
  bookNo: string;
}

export interface BorrowingBookRequest {
  bookNo: string;
}

export interface BorrowingOther {
  borrowingNo: string;
  serial: number;
  title: string;
  type: number | null;
  count: number | null;
}

export interface BorrowingOtherRequest {
  title: string;
  type: number | null;
  count: number | null;
}

export interface BookResult {
  appNo: string;
  activeTitleAr: string;
}
