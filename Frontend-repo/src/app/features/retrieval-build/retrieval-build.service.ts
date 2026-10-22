import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { environment } from '../../../environments/environment';
import { ApiResponse } from '../../core/models/api-response.model';

export type RetrievalBuildGate = 'FORM4' | 'CAT_OUT';
export type Row = Record<string, unknown>;

/**
 * ARCHIVE.frm m9 "ملف بناء الاسترجاعات" (Form4, key a5g5 / ش5ل5), M32 "معالجة حقول الاسترجاع"
 * (CAT_OUTFRM, key 261015) and m33 "نسخ قاعدة البيانات". The key is checked by the server; the
 * grant lives in memory only, so each opening asks again, as the legacy InputBox / Frame3 did.
 */
@Injectable({ providedIn: 'root' })
export class RetrievalBuildService {

  static readonly HEADER = 'X-Retrieval-Build-Access';

  private http = inject(HttpClient);
  private api = `${environment.apiUrl}/api/retrieval-build`;
  private tokens: Partial<Record<RetrievalBuildGate, string>> = {};

  requestAccess(gate: RetrievalBuildGate, key: string): Observable<ApiResponse<{ token: string }>> {
    delete this.tokens[gate];
    return this.http.post<ApiResponse<{ token: string }>>(`${this.api}/access`, { gate, key })
      .pipe(tap(r => { if (r.data?.token) this.tokens[gate] = r.data.token; }));
  }

  release(gate: RetrievalBuildGate): void {
    const token = this.tokens[gate];
    delete this.tokens[gate];
    if (token) {
      this.http.delete(`${this.api}/access`, { headers: { [RetrievalBuildService.HEADER]: token } }).subscribe({ error: () => {} });
    }
  }

  private h(gate: RetrievalBuildGate): HttpHeaders {
    const t = this.tokens[gate];
    return new HttpHeaders(t ? { [RetrievalBuildService.HEADER]: t } : {});
  }

  // ---- Form4 ----
  form4(table: 'pout' | 'bnkout'): Observable<ApiResponse<{ columns: string[]; rows: Row[] }>> {
    return this.http.get<ApiResponse<{ columns: string[]; rows: Row[] }>>(`${this.api}/form4/${table}`, { headers: this.h('FORM4') });
  }

  form4Cell(table: 'pout' | 'bnkout', auto: number, column: string, text: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/form4/cell`, { table, auto, column, text }, { headers: this.h('FORM4') });
  }

  // ---- CAT_OUTFRM ----
  fields(filter: 'ALL' | 'DISPLAY' | 'QUESTIONS'): Observable<ApiResponse<Row[]>> {
    return this.http.get<ApiResponse<Row[]>>(`${this.api}/cat-out/fields`, { headers: this.h('CAT_OUT'), params: { filter } });
  }

  updateField(outNum: number, column: string, text: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/cat-out/fields/${outNum}`, { column, text }, { headers: this.h('CAT_OUT') });
  }

  insertField(values: Record<string, string>): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/cat-out/fields`, values, { headers: this.h('CAT_OUT') });
  }

  deleteField(outNum: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/cat-out/fields/${outNum}`, { headers: this.h('CAT_OUT') });
  }

  setFieldCategory(outNum: number, category: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/cat-out/fields/${outNum}/category`, { category }, { headers: this.h('CAT_OUT') });
  }

  categories(): Observable<ApiResponse<{ sub_code: string; sub_desc: string }[]>> {
    return this.http.get<ApiResponse<{ sub_code: string; sub_desc: string }[]>>(`${this.api}/cat-out/categories`, { headers: this.h('CAT_OUT') });
  }

  categoryFields(catNo: string): Observable<ApiResponse<Row[]>> {
    return this.http.get<ApiResponse<Row[]>>(`${this.api}/cat-out/categories/${encodeURIComponent(catNo)}/fields`, { headers: this.h('CAT_OUT') });
  }

  insertCategoryField(catNo: string): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/cat-out/categories/${encodeURIComponent(catNo)}/fields`, {}, { headers: this.h('CAT_OUT') });
  }

  insertCategoryRow(catNo: string, values: Record<string, string>): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/cat-out/categories/${encodeURIComponent(catNo)}/rows`, values, { headers: this.h('CAT_OUT') });
  }

  updateCategoryField(auto: number, column: string, text: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/cat-out/category-fields/${auto}`, { column, text }, { headers: this.h('CAT_OUT') });
  }

  deleteCategoryField(auto: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/cat-out/category-fields/${auto}`, { headers: this.h('CAT_OUT') });
  }

  // ---- m33 ----
  backup(): Observable<ApiResponse<unknown>> {
    return this.http.post<ApiResponse<unknown>>(`${this.api}/backup`, {});
  }
}
