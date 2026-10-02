import { Injectable, inject, signal } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { RetrievalFieldOption, RetrievalSearchRequest, RetrievalSearchResponse, RetrievalUserFieldState } from '../models/retrieval.model';

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

  /** Legacy sort_from.frm Form_Load's BNKOUT2 query — this user's persisted display/order marks. */
  myFieldState(): Observable<ApiResponse<RetrievalUserFieldState[]>> {
    return this.http.get<ApiResponse<RetrievalUserFieldState[]>>(`${this.api}/api/retrieval/my-field-state`);
  }

  /** Legacy DBList2_DblClick. */
  toggleDisplay(fieldKey: string): Observable<ApiResponse<RetrievalUserFieldState>> {
    return this.http.post<ApiResponse<RetrievalUserFieldState>>(`${this.api}/api/retrieval/my-field-state/${fieldKey}/toggle-display`, {});
  }

  /** Legacy DBList2_KeyDown (F10). */
  toggleOrder(fieldKey: string): Observable<ApiResponse<RetrievalUserFieldState>> {
    return this.http.post<ApiResponse<RetrievalUserFieldState>>(`${this.api}/api/retrieval/my-field-state/${fieldKey}/toggle-order`, {});
  }

  /** Legacy Command3_Click ("تعليم حقول العرض"). */
  markCategoryForDisplay(category: string): Observable<ApiResponse<RetrievalUserFieldState[]>> {
    return this.http.post<ApiResponse<RetrievalUserFieldState[]>>(`${this.api}/api/retrieval/my-field-state/mark-category`, {}, { params: { category } });
  }

  /** Legacy DBList2_77 (F2) — global per-field "#" marker, not per-user. */
  toggleHashMark(fieldKey: string): Observable<ApiResponse<RetrievalFieldOption>> {
    return this.http.post<ApiResponse<RetrievalFieldOption>>(`${this.api}/api/retrieval/fields/${fieldKey}/toggle-hash-mark`, {});
  }
}
