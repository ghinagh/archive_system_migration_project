export type SearchType = 'all' | 'book' | 'article' | 'news';

export interface PublicSearchResult {
  id: string | null;
  title: string | null;
  additionalTitle: string | null;
  type: string;
  date: string | null;
}
