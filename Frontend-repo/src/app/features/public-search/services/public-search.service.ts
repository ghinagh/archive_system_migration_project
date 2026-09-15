import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { PublicSearchResult, SearchType } from '../models/public-search.model';

@Injectable({ providedIn: 'root' })
export class PublicSearchService {
  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/public`;

  search(
    q: string,
    type: SearchType,
    page: number,
    size: number
  ): Observable<ApiResponse<PageResponse<PublicSearchResult>>> {
    let params = new HttpParams()
      .set('q', q)
      .set('page', page)
      .set('size', size);

    if (type !== 'all') {
      params = params.set('type', type);
    }

    return this.http.get<ApiResponse<PageResponse<PublicSearchResult>>>(
      `${this.baseUrl}/search`,
      { params }
    );
  }
}
