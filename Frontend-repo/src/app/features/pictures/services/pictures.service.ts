import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { MediaResolveInfo, Picture, PictureRequest } from '../models/picture.model';

@Injectable({ providedIn: 'root' })
export class PicturesService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/pictures`;

  getAll(page: number, size: number, type?: number, entity?: string,
         dateFrom?: string, dateTo?: string, person?: string): Observable<ApiResponse<PageResponse<Picture>>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (type != null) params = params.set('type', type);
    if (entity) params = params.set('entity', entity);
    if (dateFrom) params = params.set('dateFrom', dateFrom);
    if (dateTo) params = params.set('dateTo', dateTo);
    if (person) params = params.set('person', person);
    return this.http.get<ApiResponse<PageResponse<Picture>>>(this.baseUrl, { params });
  }

  getById(picNo: string): Observable<ApiResponse<Picture>> {
    return this.http.get<ApiResponse<Picture>>(`${this.baseUrl}/${picNo}`);
  }

  create(data: PictureRequest): Observable<ApiResponse<Picture>> {
    return this.http.post<ApiResponse<Picture>>(this.baseUrl, data);
  }

  update(picNo: string, data: PictureRequest): Observable<ApiResponse<Picture>> {
    return this.http.put<ApiResponse<Picture>>(`${this.baseUrl}/${picNo}`, data);
  }

  delete(picNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${picNo}`);
  }

  resolveMedia(stockNo: string): Observable<ApiResponse<MediaResolveInfo>> {
    return this.http.get<ApiResponse<MediaResolveInfo>>(
      `${environment.apiUrl}/api/media/resolve/${encodeURIComponent(stockNo)}`
    );
  }

  downloadMedia(stockNo: string): Observable<Blob> {
    return this.http.get(
      `${environment.apiUrl}/api/media/file/${encodeURIComponent(stockNo)}`,
      { responseType: 'blob' }
    );
  }
}
