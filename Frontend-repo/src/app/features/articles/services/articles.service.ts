import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { Article, ArticleRequest, ArticleSubject, ArticleDescriptor } from '../models/article.model';

@Injectable({ providedIn: 'root' })
export class ArticlesService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/articles`;

  getAll(page: number, size: number, perNo?: number, year?: number, lang?: string): Observable<ApiResponse<PageResponse<Article>>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (perNo) params = params.set('perNo', perNo);
    if (year) params = params.set('year', year);
    if (lang) params = params.set('lang', lang);
    return this.http.get<ApiResponse<PageResponse<Article>>>(this.baseUrl, { params });
  }

  getById(appNo: string): Observable<ApiResponse<Article>> {
    return this.http.get<ApiResponse<Article>>(`${this.baseUrl}/${appNo}`);
  }

  createWithMain(data: ArticleRequest): Observable<ApiResponse<Article>> {
    return this.http.post<ApiResponse<Article>>(`${this.baseUrl}/with-main`, data);
  }

  update(appNo: string, data: ArticleRequest): Observable<ApiResponse<Article>> {
    return this.http.put<ApiResponse<Article>>(`${this.baseUrl}/${appNo}`, data);
  }

  delete(appNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}`);
  }

  getSubjects(appNo: string): Observable<ApiResponse<ArticleSubject[]>> {
    return this.http.get<ApiResponse<ArticleSubject[]>>(`${this.baseUrl}/${appNo}/subjects`);
  }

  getDescriptors(appNo: string): Observable<ApiResponse<ArticleDescriptor[]>> {
    return this.http.get<ApiResponse<ArticleDescriptor[]>>(`${this.baseUrl}/${appNo}/descriptors`);
  }
}
