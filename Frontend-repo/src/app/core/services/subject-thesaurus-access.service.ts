import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { environment } from '../../../environments/environment';
import { ApiResponse } from '../models/api-response.model';

export interface SubjectThesaurusGrant {
  token: string;
  expiresAt: string;
}

/**
 * Holds the grant issued when the ARCHIVE.frm Frame3 key ("كلمة السر") was accepted for
 * "المكنز الموضوعي". Kept in memory only: like legacy, every opening of the screen asks again.
 */
@Injectable({ providedIn: 'root' })
export class SubjectThesaurusAccessService {

  static readonly HEADER = 'X-Subject-Thesaurus-Access';

  private http = inject(HttpClient);
  private api = `${environment.apiUrl}/api/subject-thesaurus/access`;
  private token: string | null = null;

  /** Command20 "تنفيذ" / Enter in m_user_password — the key is checked by the server. */
  requestAccess(key: string): Observable<ApiResponse<SubjectThesaurusGrant>> {
    this.token = null;
    return this.http.post<ApiResponse<SubjectThesaurusGrant>>(this.api, { key })
      .pipe(tap(res => this.token = res.data?.token ?? null));
  }

  hasAccess(): boolean {
    return this.token !== null;
  }

  headers(): HttpHeaders {
    return new HttpHeaders(this.token ? { [SubjectThesaurusAccessService.HEADER]: this.token } : {});
  }

  /** Unload Form5 — the grant dies with the screen. */
  release(): void {
    const token = this.token;
    this.token = null;
    if (token) {
      this.http.delete(this.api, { headers: { [SubjectThesaurusAccessService.HEADER]: token } })
        .subscribe({ error: () => {} });
    }
  }
}
