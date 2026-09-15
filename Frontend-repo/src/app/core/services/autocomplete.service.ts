import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { ApiResponse, PageResponse } from '../models/api-response.model';

export interface AuthorOption {
  id: number;
  name: string;
}

export interface PeriodicalOption {
  perNo: number;
  name: string;
}

export interface CodingOption {
  level: string;
  code: string;
  description: string;
}

export interface MacnzOption {
  code: string;
  level: string;
  description: string;
}

export interface FormOption {
  formNo: string;
  formType: string;
  name: string;
}

@Injectable({ providedIn: 'root' })
export class AutocompleteService {

  private http = inject(HttpClient);

  searchAuthors(query: string): Observable<ApiResponse<AuthorOption[]>> {
    const params = new HttpParams().set('q', query).set('size', '10');
    return this.http.get<ApiResponse<AuthorOption[]>>(
      `${environment.apiUrl}/api/authors/search`, { params }
    );
  }

  searchPeriodicals(query: string): Observable<ApiResponse<PeriodicalOption[]>> {
    const params = new HttpParams().set('q', query);
    return this.http.get<ApiResponse<PeriodicalOption[]>>(
      `${environment.apiUrl}/api/periodicals/search`, { params }
    );
  }

  getAllPeriodicals(): Observable<ApiResponse<PeriodicalOption[]>> {
    return this.http.get<ApiResponse<PeriodicalOption[]>>(
      `${environment.apiUrl}/api/periodicals/all`
    );
  }

  getCoding(): Observable<ApiResponse<CodingOption[]>> {
    return this.http.get<ApiResponse<CodingOption[]>>(`${environment.apiUrl}/api/lookups/coding`);
  }

  getCodingByLevel(level: string): Observable<ApiResponse<CodingOption[]>> {
    const params = new HttpParams().set('level', level);
    return this.http.get<ApiResponse<CodingOption[]>>(
      `${environment.apiUrl}/api/lookups/coding`, { params }
    );
  }

  /**
   * appDoc/dataEntry (documenter / data-entry location) are bound to a compound
   * SUB_CODE of "01"+code / "02"+code (legacy Form6 BoundText), not the single-char
   * SUB_LEVE column that getCodingByLevel() filters on.
   */
  getCodingByCodePrefix(codePrefix: string): Observable<ApiResponse<CodingOption[]>> {
    const params = new HttpParams().set('codePrefix', codePrefix);
    return this.http.get<ApiResponse<CodingOption[]>>(
      `${environment.apiUrl}/api/lookups/coding`, { params }
    );
  }

  /**
   * MACNZ has no server-side search endpoint (only a full-list admin CRUD one) —
   * cached client-side and filtered locally, same pattern as getAllPeriodicals().
   * Form2.frm's DBList11 picker only accepted leaf-level codes (sub_level > 2);
   * callers should apply that same filter to the cached list.
   */
  getAllMacnz(): Observable<ApiResponse<MacnzOption[]>> {
    return this.http.get<ApiResponse<MacnzOption[]>>(`${environment.apiUrl}/api/lookups/subjects`);
  }

  searchForms(query: string): Observable<ApiResponse<PageResponse<FormOption>>> {
    const params = new HttpParams().set('name', query).set('page', '0').set('size', '20');
    return this.http.get<ApiResponse<PageResponse<FormOption>>>(
      `${environment.apiUrl}/api/forms`, { params }
    );
  }

  /**
   * Legacy's GEO/FILE_ADD lists always bind ListField="sub_name" — a stored code
   * is never shown to the user by itself. Used to resolve a code picked from
   * searchForms() back into a display name once it's saved as a plain string.
   */
  getFormByCode(formNo: string): Observable<ApiResponse<FormOption>> {
    return this.http.get<ApiResponse<FormOption>>(`${environment.apiUrl}/api/forms/${formNo}`);
  }
}
