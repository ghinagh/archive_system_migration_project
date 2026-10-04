import { Injectable, inject, signal } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { RetrievalCodeOption, RetrievalFieldOption, RetrievalScope, RetrievalSearchRequest, RetrievalSearchResponse, RetrievalUserFieldState } from '../models/retrieval.model';

@Injectable({ providedIn: 'root' })
export class RetrievalService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  /**
   * Holds the request built by a retrieval builder for the results screen to run — the "نتائج البحث"
   * hand-off. Carries its scope so the results screen never runs one screen's query against the other's data.
   */
  pendingSearch = signal<{ scope: RetrievalScope; request: RetrievalSearchRequest } | null>(null);

  getFields(scope: RetrievalScope): Observable<ApiResponse<RetrievalFieldOption[]>> {
    return this.http.get<ApiResponse<RetrievalFieldOption[]>>(`${this.api}/api/retrieval/fields`, { params: { scope } });
  }

  lookupValues(scope: RetrievalScope, fieldKey: string, term?: string): Observable<ApiResponse<string[]>> {
    let params = new HttpParams().set('scope', scope).set('fieldKey', fieldKey);
    if (term) {
      params = params.set('term', term);
    }
    return this.http.get<ApiResponse<string[]>>(`${this.api}/api/retrieval/lookup-values`, { params });
  }

  /** Legacy c_getcond for a coded condition — names with the code each one resolves to. */
  lookupCodes(scope: RetrievalScope, fieldKey: string, term?: string): Observable<ApiResponse<RetrievalCodeOption[]>> {
    let params = new HttpParams().set('scope', scope).set('fieldKey', fieldKey);
    if (term) {
      params = params.set('term', term);
    }
    return this.http.get<ApiResponse<RetrievalCodeOption[]>>(`${this.api}/api/retrieval/lookup-codes`, { params });
  }

  search(scope: RetrievalScope, request: RetrievalSearchRequest): Observable<ApiResponse<RetrievalSearchResponse>> {
    return this.http.post<ApiResponse<RetrievalSearchResponse>>(`${this.api}/api/retrieval/search`, request, { params: { scope } });
  }

  /** Legacy sort_from.frm Form_Load's BNKOUT2 query — this user's persisted display/order marks for the scope. */
  myFieldState(scope: RetrievalScope): Observable<ApiResponse<RetrievalUserFieldState[]>> {
    return this.http.get<ApiResponse<RetrievalUserFieldState[]>>(`${this.api}/api/retrieval/my-field-state`, { params: { scope } });
  }

  /** Legacy DBList2_DblClick. */
  toggleDisplay(scope: RetrievalScope, fieldKey: string): Observable<ApiResponse<RetrievalUserFieldState>> {
    return this.http.post<ApiResponse<RetrievalUserFieldState>>(`${this.api}/api/retrieval/my-field-state/${fieldKey}/toggle-display`, {}, { params: { scope } });
  }

  /** Legacy DBList2_KeyDown (F10). */
  toggleOrder(scope: RetrievalScope, fieldKey: string): Observable<ApiResponse<RetrievalUserFieldState>> {
    return this.http.post<ApiResponse<RetrievalUserFieldState>>(`${this.api}/api/retrieval/my-field-state/${fieldKey}/toggle-order`, {}, { params: { scope } });
  }

  /** Legacy Command3_Click ("تعليم حقول العرض"). */
  markCategoryForDisplay(scope: RetrievalScope, category: string): Observable<ApiResponse<RetrievalUserFieldState[]>> {
    return this.http.post<ApiResponse<RetrievalUserFieldState[]>>(`${this.api}/api/retrieval/my-field-state/mark-category`, {}, { params: { scope, category } });
  }

  /** Legacy DBList2_77 (F2) — global per-field "#" marker, not per-user. */
  toggleHashMark(scope: RetrievalScope, fieldKey: string): Observable<ApiResponse<RetrievalFieldOption>> {
    return this.http.post<ApiResponse<RetrievalFieldOption>>(`${this.api}/api/retrieval/fields/${fieldKey}/toggle-hash-mark`, {}, { params: { scope } });
  }
}
