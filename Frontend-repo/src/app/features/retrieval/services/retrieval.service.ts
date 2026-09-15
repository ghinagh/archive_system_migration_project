import { Injectable, inject, signal } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { RetrievalFieldOption, RetrievalSearchRequest, RetrievalSearchResponse } from '../models/retrieval.model';

@Injectable({ providedIn: 'root' })
export class RetrievalService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  /** Holds the request built by the graphical retrieval builder for the results screen to run — the "نتائج البحث" hand-off. */
  pendingSearch = signal<RetrievalSearchRequest | null>(null);

  getFields(): Observable<ApiResponse<RetrievalFieldOption[]>> {
    return this.http.get<ApiResponse<RetrievalFieldOption[]>>(`${this.api}/api/retrieval/fields`);
  }

  lookupValues(fieldKey: string, term?: string): Observable<ApiResponse<string[]>> {
    let params = new HttpParams().set('fieldKey', fieldKey);
    if (term) {
      params = params.set('term', term);
    }
    return this.http.get<ApiResponse<string[]>>(`${this.api}/api/retrieval/lookup-values`, { params });
  }

  search(request: RetrievalSearchRequest): Observable<ApiResponse<RetrievalSearchResponse>> {
    return this.http.post<ApiResponse<RetrievalSearchResponse>>(`${this.api}/api/retrieval/search`, request);
  }
}
