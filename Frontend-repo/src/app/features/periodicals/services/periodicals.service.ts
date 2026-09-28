import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { Periodical, PeriodicalRequest } from '../models/periodical.model';
import { SearchCondition } from '../../../shared/models/search-condition.model';

@Injectable({ providedIn: 'root' })
export class PeriodicalsService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/periodicals`;

  /**
   * name doubles as the legacy "البحث بالعنوان" (search by title) filter — the
   * controller/specification only support name + lang server-side, matching what
   * PERIOD1.frm's بحث/البحث بالعنوان buttons actually query (per_per_no exact lookup
   * is handled separately via getById()).
   */
  getAll(page: number, size: number, name?: string, lang?: string): Observable<ApiResponse<PageResponse<Periodical>>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (name) params = params.set('name', name);
    if (lang) params = params.set('lang', lang);
    return this.http.get<ApiResponse<PageResponse<Periodical>>>(this.baseUrl, { params });
  }

  /**
   * Legacy البحث بالعنوان (Command8 / m_typ_serh=3 -> execute serh_period1):
   * free-text title search returning candidate matches to pick from, backed by
   * GET /api/periodicals/search?q=.
   */
  searchByTitle(q: string): Observable<ApiResponse<Periodical[]>> {
    const params = new HttpParams().set('q', q);
    return this.http.get<ApiResponse<Periodical[]>>(`${this.baseUrl}/search`, { params });
  }

  advancedSearch(conditions: SearchCondition[], page: number, size: number): Observable<ApiResponse<PageResponse<Periodical>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.post<ApiResponse<PageResponse<Periodical>>>(`${this.baseUrl}/search`, { conditions }, { params });
  }

  getById(perNo: number): Observable<ApiResponse<Periodical>> {
    return this.http.get<ApiResponse<Periodical>>(`${this.baseUrl}/${perNo}`);
  }

  /** Legacy اضافة (Add) behavior: next PER_PER_NO = max(existing) + 1. */
  getNextPerNo(): Observable<ApiResponse<number>> {
    return this.http.get<ApiResponse<number>>(`${this.baseUrl}/next-no`);
  }

  getNext(perNo: number): Observable<ApiResponse<Periodical>> {
    return this.http.get<ApiResponse<Periodical>>(`${this.baseUrl}/${perNo}/next`);
  }

  getPrevious(perNo: number): Observable<ApiResponse<Periodical>> {
    return this.http.get<ApiResponse<Periodical>>(`${this.baseUrl}/${perNo}/previous`);
  }

  create(data: PeriodicalRequest): Observable<ApiResponse<Periodical>> {
    return this.http.post<ApiResponse<Periodical>>(this.baseUrl, data);
  }

  update(perNo: number, data: PeriodicalRequest): Observable<ApiResponse<Periodical>> {
    return this.http.put<ApiResponse<Periodical>>(`${this.baseUrl}/${perNo}`, data);
  }

  delete(perNo: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${perNo}`);
  }
}
