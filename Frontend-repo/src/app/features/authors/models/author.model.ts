export interface Author {
  autNo: number;
  type: string | null;
  name: string | null;
  subjectNo: string | null;
}

export interface AuthorRequest {
  autNo: number;
  type?: string;
  name?: string;
  subjectNo?: string;
}
