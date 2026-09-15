import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { Staff, StaffRequest } from '../models/person.model';

@Injectable({ providedIn: 'root' })
export class StaffService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/staff`;

  getAll(page: number, size: number, name?: string, entity?: string): Observable<ApiResponse<PageResponse<Staff>>> {
    let params = new HttpParams()
      .set('page', page)
      .set('size', size);
    if (name)   params = params.set('name', name);
    if (entity) params = params.set('entity', entity);
    return this.http.get<ApiResponse<PageResponse<Staff>>>(this.baseUrl, { params });
  }

  getById(prsNo: string): Observable<ApiResponse<Staff>> {
    return this.http.get<ApiResponse<Staff>>(`${this.baseUrl}/${prsNo}`);
  }

  create(request: StaffRequest): Observable<ApiResponse<Staff>> {
    return this.http.post<ApiResponse<Staff>>(this.baseUrl, request);
  }

  update(prsNo: string, request: StaffRequest): Observable<ApiResponse<Staff>> {
    return this.http.put<ApiResponse<Staff>>(`${this.baseUrl}/${prsNo}`, request);
  }

  delete(prsNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${prsNo}`);
  }
}
