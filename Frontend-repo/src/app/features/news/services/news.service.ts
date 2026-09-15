import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { NewsItem, NewsRequest } from '../models/news.model';
import { SearchCondition } from '../../../shared/models/search-condition.model';

@Injectable({ providedIn: 'root' })
export class NewsService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/news`;

  getAll(page: number, size: number, docType?: string, dateFrom?: string, dateTo?: string,
         publication?: number, title?: string, sort?: string): Observable<ApiResponse<PageResponse<NewsItem>>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (docType) params = params.set('docType', docType);
    if (dateFrom) params = params.set('dateFrom', dateFrom);
    if (dateTo) params = params.set('dateTo', dateTo);
    if (publication != null) params = params.set('publication', publication);
    if (title) params = params.set('title', title);
    if (sort) params = params.set('sort', sort);
    return this.http.get<ApiResponse<PageResponse<NewsItem>>>(this.baseUrl, { params });
  }

  advancedSearch(conditions: SearchCondition[], page: number, size: number): Observable<ApiResponse<PageResponse<NewsItem>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.post<ApiResponse<PageResponse<NewsItem>>>(`${this.baseUrl}/search`, { conditions }, { params });
  }

  getById(newsNo: string): Observable<ApiResponse<NewsItem>> {
    return this.http.get<ApiResponse<NewsItem>>(`${this.baseUrl}/${newsNo}`);
  }

  create(data: NewsRequest): Observable<ApiResponse<NewsItem>> {
    return this.http.post<ApiResponse<NewsItem>>(this.baseUrl, data);
  }

  update(newsNo: string, data: NewsRequest): Observable<ApiResponse<NewsItem>> {
    return this.http.put<ApiResponse<NewsItem>>(`${this.baseUrl}/${newsNo}`, data);
  }

  delete(newsNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${newsNo}`);
  }

  getKeywords(newsNo: string): Observable<ApiResponse<string[]>> {
    return this.http.get<ApiResponse<string[]>>(`${this.baseUrl}/${newsNo}/keywords`);
  }

  addKeyword(newsNo: string, word: string): Observable<ApiResponse<string[]>> {
    return this.http.post<ApiResponse<string[]>>(`${this.baseUrl}/${newsNo}/keywords`, { word });
  }

  removeKeyword(newsNo: string, word: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${newsNo}/keywords/${encodeURIComponent(word)}`);
  }
}
