import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { VideoOrder, VideoOrderRequest } from '../models/video-order.model';

@Injectable({ providedIn: 'root' })
export class VideoOrderService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getAll(page: number, size: number, status?: string, stockNo?: string): Observable<ApiResponse<PageResponse<VideoOrder>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (status) p = p.set('status', status);
    if (stockNo) p = p.set('stockNo', stockNo);
    return this.http.get<ApiResponse<PageResponse<VideoOrder>>>(`${this.api}/api/video-orders`, { params: p });
  }

  getById(id: string): Observable<ApiResponse<VideoOrder>> {
    return this.http.get<ApiResponse<VideoOrder>>(`${this.api}/api/video-orders/${id}`);
  }

  create(req: VideoOrderRequest): Observable<ApiResponse<VideoOrder>> {
    return this.http.post<ApiResponse<VideoOrder>>(`${this.api}/api/video-orders`, req);
  }

  update(id: string, req: VideoOrderRequest): Observable<ApiResponse<VideoOrder>> {
    return this.http.put<ApiResponse<VideoOrder>>(`${this.api}/api/video-orders/${id}`, req);
  }

  delete(id: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/video-orders/${id}`);
  }

  updateStatus(id: string, status: string): Observable<ApiResponse<VideoOrder>> {
    return this.http.patch<ApiResponse<VideoOrder>>(`${this.api}/api/video-orders/${id}/status`, { status });
  }
}
