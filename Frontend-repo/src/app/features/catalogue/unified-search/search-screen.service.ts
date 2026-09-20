import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { ArchiveSearchResult } from '../../archive-search/models/archive-search.model';
import { SearchScreenRequest } from './search-screen.model';

/** Legacy "شاشة البحث" (user_inetrface.frm) — Command1_Click "النتيجة". */
@Injectable({ providedIn: 'root' })
export class SearchScreenService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  search(request: SearchScreenRequest, page: number, size: number): Observable<ApiResponse<PageResponse<ArchiveSearchResult>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.post<ApiResponse<PageResponse<ArchiveSearchResult>>>(
      `${this.api}/api/search-screen/search`, request, { params });
  }

  /** Legacy DataGrid1_KeyDown F9 "الاختيار" (:2590-2605). */
  setChoice(digitNo: string, type1: string, choice: number): Observable<ApiResponse<void>> {
    const params = new HttpParams().set('type1', type1).set('choice', choice);
    return this.http.put<ApiResponse<void>>(
      `${this.api}/api/search-screen/results/${encodeURIComponent(digitNo)}/choice`, null, { params });
  }
}
