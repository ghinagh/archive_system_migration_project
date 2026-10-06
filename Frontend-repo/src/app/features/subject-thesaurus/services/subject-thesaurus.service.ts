import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { SubjectThesaurusAccessService } from '../../../core/services/subject-thesaurus-access.service';
import { SubjectThesaurusContext, ThesaurusQuery, ThesaurusTerm } from '../models/subject-thesaurus.model';

/** The statements legacy Form5 sends; every call carries the key grant. */
@Injectable({ providedIn: 'root' })
export class SubjectThesaurusService {

  private http = inject(HttpClient);
  private access = inject(SubjectThesaurusAccessService);
  private api = `${environment.apiUrl}/api/subject-thesaurus`;

  context(): Observable<ApiResponse<SubjectThesaurusContext>> {
    return this.http.get<ApiResponse<SubjectThesaurusContext>>(`${this.api}/context`, { headers: this.access.headers() });
  }

  list(q: ThesaurusQuery): Observable<ApiResponse<ThesaurusTerm[]>> {
    let params = new HttpParams().set('query', q.query);
    if (q.query === 'CHILDREN') params = params.set('level', q.level).set('parentCode', q.parentCode);
    if (q.query === 'PREFIX' || q.query === 'WORD') params = params.set('text', q.text);
    return this.http.get<ApiResponse<ThesaurusTerm[]>>(`${this.api}/terms`, { params, headers: this.access.headers() });
  }

  /** insr_macnz + div_word */
  insert(code: string, description: string, level: string, wordCode: string): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/terms`, { code, description, level, wordCode },
      { headers: this.access.headers() });
  }

  /** upd_macnz */
  update(code: string, description: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/terms`, { code, description }, { headers: this.access.headers() });
  }

  /** del_macnz */
  delete(code: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/terms`,
      { params: new HttpParams().set('code', code), headers: this.access.headers() });
  }

  /** op_macnz + max_macnz */
  openLevelThree(parentCode: string): Observable<ApiResponse<{ code: string }>> {
    return this.http.post<ApiResponse<{ code: string }>>(`${this.api}/terms/level3-code`, { parentCode },
      { headers: this.access.headers() });
  }
}
