import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { ChartItem, ChartRequest, ChartOperation, OperationRequest } from '../models/archive.model';

@Injectable({ providedIn: 'root' })
export class ArchiveService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/archive/charts`;

  getAll(page: number, size: number, title?: string, type?: number,
         dateFrom?: string, dateTo?: string): Observable<ApiResponse<PageResponse<ChartItem>>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (title) params = params.set('title', title);
    if (type != null) params = params.set('type', type);
    return this.http.get<ApiResponse<PageResponse<ChartItem>>>(this.baseUrl, { params });
  }

  getById(id: number): Observable<ApiResponse<ChartItem>> {
    return this.http.get<ApiResponse<ChartItem>>(`${this.baseUrl}/${id}`);
  }

  create(request: ChartRequest): Observable<ApiResponse<ChartItem>> {
    return this.http.post<ApiResponse<ChartItem>>(this.baseUrl, request);
  }

  update(id: number, request: ChartRequest): Observable<ApiResponse<ChartItem>> {
    return this.http.put<ApiResponse<ChartItem>>(`${this.baseUrl}/${id}`, request);
  }

  delete(id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${id}`);
  }

  getOperations(chartId: number, page: number = 0, size: number = 50): Observable<ApiResponse<PageResponse<ChartOperation>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.get<ApiResponse<PageResponse<ChartOperation>>>(`${this.baseUrl}/${chartId}/operations`, { params });
  }

  createOperation(chartId: number, request: OperationRequest): Observable<ApiResponse<ChartOperation>> {
    return this.http.post<ApiResponse<ChartOperation>>(`${this.baseUrl}/${chartId}/operations`, request);
  }

  updateOperation(chartId: number, operationId: number, request: OperationRequest): Observable<ApiResponse<ChartOperation>> {
    return this.http.put<ApiResponse<ChartOperation>>(`${this.baseUrl}/${chartId}/operations/${operationId}`, request);
  }
}
