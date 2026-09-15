export interface Article {
  appNo: string;
  perNo: number | null;
  periodicalName: string;
  year: number | null;
  volume: number | null;
  articleNo: number | null;
  date: string | null;
  subjectType: string;
  pageNo: string;
  cote: string;
  serial: string;
  filmNo: string;
  type: number | null;
  lang: string;
  choice: number | null;
  pictureCode: string;
}

export interface ArticleRequest {
  appNo: string;
  perNo: number | null;
  year: number | null;
  volume: number | null;
  articleNo: number | null;
  date: string | null;
  subjectType: string;
  pageNo: string;
  cote: string;
  serial: string;
  filmNo: string;
  type: number | null;
  lang: string;
  choice: number | null;
  pictureCode: string;
}

export interface ArticleSubject {
  subjectCode: string;
  subjectName: string;
  level: number;
}

export interface ArticleDescriptor {
  type: string;
  value: string;
}
