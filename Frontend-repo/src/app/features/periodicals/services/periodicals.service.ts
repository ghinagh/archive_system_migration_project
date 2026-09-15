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

  getAll(page: number, size: number, name?: string, lang?: string, type?: number, frequency?: string): Observable<ApiResponse<PageResponse<Periodical>>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (name) params = params.set('name', name);
    if (lang) params = params.set('lang', lang);
    if (type != null) params = params.set('type', type);
    if (frequency) params = params.set('frequency', frequency);
    return this.http.get<ApiResponse<PageResponse<Periodical>>>(this.baseUrl, { params });
  }

  advancedSearch(conditions: SearchCondition[], page: number, size: number): Observable<ApiResponse<PageResponse<Periodical>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.post<ApiResponse<PageResponse<Periodical>>>(`${this.baseUrl}/search`, { conditions }, { params });
  }

  getById(perNo: number): Observable<ApiResponse<Periodical>> {
    return this.http.get<ApiResponse<Periodical>>(`${this.baseUrl}/${perNo}`);
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
