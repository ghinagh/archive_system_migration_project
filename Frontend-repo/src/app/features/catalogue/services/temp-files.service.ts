import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { TempFile, TempFileRequest } from '../models/catalogue.models';

@Injectable({ providedIn: 'root' })
export class TempFilesService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/temp-files`;

  getTempFiles(fadNo: string, finalStatus?: number): Observable<ApiResponse<TempFile[]>> {
    let params = new HttpParams().set('fadNo', fadNo);
    if (finalStatus != null) params = params.set('finalStatus', finalStatus);
    return this.http.get<ApiResponse<TempFile[]>>(this.baseUrl, { params });
  }

  searchTempFiles(fadNo?: string, userNo?: string, finalStatus?: number): Observable<ApiResponse<TempFile[]>> {
    let params = new HttpParams();
    if (fadNo) params = params.set('fadNo', fadNo);
    if (userNo) params = params.set('userNo', userNo);
    if (finalStatus != null) params = params.set('finalStatus', finalStatus);
    return this.http.get<ApiResponse<TempFile[]>>(this.baseUrl, { params });
  }

  createTempFile(req: TempFileRequest): Observable<ApiResponse<TempFile>> {
    return this.http.post<ApiResponse<TempFile>>(this.baseUrl, req);
  }

  finalizeTempFile(no: string, ser: number): Observable<ApiResponse<TempFile>> {
    return this.http.patch<ApiResponse<TempFile>>(`${this.baseUrl}/${no}/${ser}/finalize`, {});
  }

  deleteTempFile(no: string, ser: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${no}/${ser}`);
  }
}
