export interface NewsItem {
  newsNo: string;
  newsDoc: string;
  newsDteD: string | null;
  newsDte: string | null;
  newsNum: number | null;
  newsTit1: string;
  newsTit2: string;
  newsDesT: string;
  newsDesD: string | null;
  newsDesP: number | null;
  newsPub: number | null;
  newsDesN: string;
  newsMlh: number | null;
  keywords: string[];
}

export interface NewsRequest {
  newsNo: string;
  newsDoc: string;
  newsDteD: string | null;
  newsDte: string | null;
  newsNum: number | null;
  newsTit1: string;
  newsTit2: string;
  newsDesT: string;
  newsDesD: string | null;
  newsDesP: number | null;
  newsPub: number | null;
  newsDesN: string;
  newsMlh: number | null;
}

export interface NewsKeyword {
  wrdAppNo: string;
  wrdWord: string;
}
