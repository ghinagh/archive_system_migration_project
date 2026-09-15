import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { ApiResponse } from '../models/api-response.model';
import { SearchResult, UnifiedSearchResult } from '../models/search.models';

@Injectable({ providedIn: 'root' })
export class SearchService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/search`;

  search(query: string): Observable<ApiResponse<SearchResult[]>> {
    const params = new HttpParams().set('q', query);
    return this.http.get<ApiResponse<SearchResult[]>>(`${this.baseUrl}/fulltext`, { params });
  }

  searchUnified(query: string): Observable<ApiResponse<UnifiedSearchResult[]>> {
    const params = new HttpParams().set('q', query);
    return this.http.get<ApiResponse<UnifiedSearchResult[]>>(`${this.baseUrl}/unified`, { params });
  }
}
