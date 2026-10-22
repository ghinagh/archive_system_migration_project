import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { ConfigUsersAccessService } from '../../../core/services/config-users-access.service';
import { ConfigRow, FieldRow, FormType, RangeRow } from '../models/config-users.model';

/** /api/config-users — every call carries the ARCHIVE.frm Frame3 grant (key 261015). */
@Injectable({ providedIn: 'root' })
export class ConfigUsersService {

  private http = inject(HttpClient);
  private access = inject(ConfigUsersAccessService);
  private api = `${environment.apiUrl}/api/config-users`;

  private get headers() { return this.access.headers(); }

  formTypes(): Observable<ApiResponse<FormType[]>> {
    return this.http.get<ApiResponse<FormType[]>>(`${this.api}/form-types`, { headers: this.headers });
  }

  users(): Observable<ApiResponse<ConfigRow[]>> {
    return this.http.get<ApiResponse<ConfigRow[]>>(`${this.api}/users`, { headers: this.headers });
  }

  updateUser(original: ConfigRow, column: string, text: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/users`, { original, column, text }, { headers: this.headers });
  }

  insertUser(values: Record<string, string>): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/users`, values, { headers: this.headers });
  }

  deleteUser(original: ConfigRow): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/users/delete`, original, { headers: this.headers });
  }

  allFields(): Observable<ApiResponse<FieldRow[]>> {
    return this.http.get<ApiResponse<FieldRow[]>>(`${this.api}/fields`, { headers: this.headers, params: { all: true } });
  }

  userFields(userNo: string, formType: string): Observable<ApiResponse<FieldRow[]>> {
    const params = new HttpParams().set('userNo', userNo).set('formType', formType);
    return this.http.get<ApiResponse<FieldRow[]>>(`${this.api}/fields`, { headers: this.headers, params });
  }

  createFields(userNo: string, formType: string): Observable<ApiResponse<number>> {
    return this.http.post<ApiResponse<number>>(`${this.api}/fields/create`, { userNo, formType }, { headers: this.headers });
  }

  deleteFields(userNo: string, formType: string): Observable<ApiResponse<number>> {
    return this.http.post<ApiResponse<number>>(`${this.api}/fields/delete`, { userNo, formType }, { headers: this.headers });
  }

  updateField(row: FieldRow, column: string, text: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/fields`, { row, column, text }, { headers: this.headers });
  }

  ranges(): Observable<ApiResponse<RangeRow[]>> {
    return this.http.get<ApiResponse<RangeRow[]>>(`${this.api}/ranges`, { headers: this.headers });
  }

  updateRange(rjpNo: number, column: string, text: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/ranges`, { rjpNo, column, text }, { headers: this.headers });
  }

  insertRange(values: Record<string, string>): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/ranges`, values, { headers: this.headers });
  }

  deleteRange(rjpNo: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/ranges/${rjpNo}`, { headers: this.headers });
  }
}
