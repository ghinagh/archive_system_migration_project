export interface SearchResult {
  appNo: string;
  title: string;
  typeBadge: string;
  route: string;
}

export interface UnifiedSearchResult {
  appNo: string;
  title: string;
  type: 'BOOK' | 'ARTICLE' | 'NEWS' | 'PERIODICAL' | 'CATALOGUE';
  date: string | null;
  matchedWord: string | null;
}
