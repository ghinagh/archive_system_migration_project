import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { UsageRequest, UsageRequestRequest } from '../models/usage-request.model';

@Injectable({ providedIn: 'root' })
export class UsageRequestService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getAll(page: number, size: number, status?: string, requester?: string): Observable<ApiResponse<PageResponse<UsageRequest>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (status) p = p.set('status', status);
    if (requester) p = p.set('requester', requester);
    return this.http.get<ApiResponse<PageResponse<UsageRequest>>>(`${this.api}/api/usage-requests`, { params: p });
  }

  getById(id: string): Observable<ApiResponse<UsageRequest>> {
    return this.http.get<ApiResponse<UsageRequest>>(`${this.api}/api/usage-requests/${id}`);
  }

  create(req: UsageRequestRequest): Observable<ApiResponse<UsageRequest>> {
    return this.http.post<ApiResponse<UsageRequest>>(`${this.api}/api/usage-requests`, req);
  }

  update(id: string, req: UsageRequestRequest): Observable<ApiResponse<UsageRequest>> {
    return this.http.put<ApiResponse<UsageRequest>>(`${this.api}/api/usage-requests/${id}`, req);
  }

  delete(id: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/usage-requests/${id}`);
  }

  updateStatus(id: string, status: string): Observable<ApiResponse<UsageRequest>> {
    return this.http.patch<ApiResponse<UsageRequest>>(`${this.api}/api/usage-requests/${id}/status`, { status });
  }
}
