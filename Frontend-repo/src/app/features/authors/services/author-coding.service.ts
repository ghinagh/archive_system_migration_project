import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { AuthorCodingListState, AuthorCodingRow } from '../models/author-coding.model';

@Injectable({ providedIn: 'root' })
export class AuthorCodingService {

  private http = inject(HttpClient);
  private api = `${environment.apiUrl}/api/authors/coding`;

  list(state: AuthorCodingListState): Observable<ApiResponse<AuthorCodingRow[]>> {
    let params = new HttpParams().set('query', state.query);
    if (state.text != null) params = params.set('text', state.text);
    return this.http.get<ApiResponse<AuthorCodingRow[]>>(this.api, { params });
  }

  /** insr_auther — the number is sent as typed in the الرقم box. */
  insert(number: string, name: string): Observable<ApiResponse<AuthorCodingRow>> {
    return this.http.post<ApiResponse<AuthorCodingRow>>(this.api, { number, name });
  }

  /** upd_auther */
  updateName(number: number, name: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/${number}`, { name });
  }

  /** del_auther */
  delete(number: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/${number}`);
  }
}
