import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { DocumentationFormRequest, DocumentationFormResponse } from '../models/documentation-form.model';

@Injectable({ providedIn: 'root' })
export class DocumentationFormService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/articles`;

  getById(appNo: string): Observable<ApiResponse<DocumentationFormResponse>> {
    return this.http.get<ApiResponse<DocumentationFormResponse>>(`${this.baseUrl}/${appNo}`);
  }

  create(data: DocumentationFormRequest): Observable<ApiResponse<DocumentationFormResponse>> {
    return this.http.post<ApiResponse<DocumentationFormResponse>>(this.baseUrl, data);
  }

  update(appNo: string, data: DocumentationFormRequest): Observable<ApiResponse<DocumentationFormResponse>> {
    return this.http.put<ApiResponse<DocumentationFormResponse>>(`${this.baseUrl}/${appNo}`, data);
  }

  delete(appNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}`);
  }

  /** Best-effort sequential browse used by the legacy "سابق/لاحق/الاخير" toolbar buttons. */
  findAppNosSorted(sort: 'asc' | 'desc' = 'asc'): Observable<ApiResponse<PageResponse<DocumentationFormResponse>>> {
    const params = new HttpParams().set('page', 0).set('size', 200).set('sort', `appNo,${sort}`);
    return this.http.get<ApiResponse<PageResponse<DocumentationFormResponse>>>(this.baseUrl, { params });
  }

  /** Backs the legacy "البحث بالعنوان" toolbar button. */
  searchByTitle(title: string): Observable<ApiResponse<PageResponse<DocumentationFormResponse>>> {
    const params = new HttpParams().set('page', 0).set('size', 10).set('title', title);
    return this.http.get<ApiResponse<PageResponse<DocumentationFormResponse>>>(this.baseUrl, { params });
  }
}
