import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { SystemUser, UserRequest } from '../models/user.model';

@Injectable({ providedIn: 'root' })
export class UsersService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getAll(page: number, size: number, level?: string, entity?: string): Observable<ApiResponse<PageResponse<SystemUser>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (level) p = p.set('level', level);
    if (entity) p = p.set('entity', entity);
    return this.http.get<ApiResponse<PageResponse<SystemUser>>>(`${this.api}/api/users`, { params: p });
  }

  getById(userNo: string): Observable<ApiResponse<SystemUser>> {
    return this.http.get<ApiResponse<SystemUser>>(`${this.api}/api/users/${userNo}`);
  }

  create(req: UserRequest): Observable<ApiResponse<SystemUser>> {
    return this.http.post<ApiResponse<SystemUser>>(`${this.api}/api/users`, req);
  }

  update(userNo: string, req: UserRequest): Observable<ApiResponse<SystemUser>> {
    return this.http.put<ApiResponse<SystemUser>>(`${this.api}/api/users/${userNo}`, req);
  }

  delete(userNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/users/${userNo}`);
  }

  migratePasswords(): Observable<ApiResponse<{ migratedCount: number }>> {
    return this.http.post<ApiResponse<{ migratedCount: number }>>(`${this.api}/api/admin/migrate-passwords`, {});
  }
}
