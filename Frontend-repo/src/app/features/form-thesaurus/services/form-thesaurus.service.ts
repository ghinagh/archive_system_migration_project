import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse } from '../../../core/models/api-response.model';
import { FormThesaurusAccessService } from '../../../core/services/form-thesaurus-access.service';
import {
  AdditionalFileCriterion, AdditionalFileRow, CodingRow, FormQuery, FormRelationRow, FormRow, MacnzQuery, MacnzRow, PositionRow, SaveResult, SubjectRelationRow
} from '../models/form-thesaurus.model';

/** The statements legacy coding.frm sends; every call carries the key grant. */
@Injectable({ providedIn: 'root' })
export class FormThesaurusService {

  private http = inject(HttpClient);
  private access = inject(FormThesaurusAccessService);
  private api = `${environment.apiUrl}/api/form-thesaurus`;

  private opts(params?: object) {
    let p = new HttpParams();
    for (const [k, v] of Object.entries(params ?? {})) {
      if (v !== undefined && v !== null) p = p.set(k, String(v));
    }
    return { params: p, headers: this.access.headers() };
  }

  context(): Observable<ApiResponse<{ boxCompany: number | null }>> {
    return this.http.get<ApiResponse<{ boxCompany: number | null }>>(`${this.api}/context`, this.opts());
  }

  // ─── CODING ───
  codingLevelOne(): Observable<ApiResponse<CodingRow[]>> {
    return this.http.get<ApiResponse<CodingRow[]>>(`${this.api}/coding`, this.opts());
  }
  codingChildren(prefix: string): Observable<ApiResponse<CodingRow[]>> {
    return this.http.get<ApiResponse<CodingRow[]>>(`${this.api}/coding`, this.opts({ prefix }));
  }
  findCoding(code: string): Observable<ApiResponse<CodingRow[]>> {
    return this.http.get<ApiResponse<CodingRow[]>>(`${this.api}/coding/find`, this.opts({ code }));
  }
  insertCoding(code: string, description: string, level: string): Observable<ApiResponse<SaveResult>> {
    return this.http.post<ApiResponse<SaveResult>>(`${this.api}/coding`, { code, description, level }, this.opts());
  }
  updateCoding(code: string, description: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/coding`, { code, description }, this.opts());
  }
  deleteCoding(code: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/coding`, this.opts({ code }));
  }

  // ─── form ───
  forms(q: FormQuery): Observable<ApiResponse<FormRow[]>> {
    return this.http.get<ApiResponse<FormRow[]>>(`${this.api}/forms`, this.opts(q));
  }
  findForm(number: string, type: string): Observable<ApiResponse<FormRow[]>> {
    return this.http.get<ApiResponse<FormRow[]>>(`${this.api}/forms/find`, this.opts({ number, type }));
  }
  insertForm(description: string, number: string, type: string): Observable<ApiResponse<SaveResult>> {
    return this.http.post<ApiResponse<SaveResult>>(`${this.api}/forms`, { description, number, type }, this.opts());
  }
  updateForm(description: string, number: string, type: string): Observable<ApiResponse<SaveResult>> {
    return this.http.put<ApiResponse<SaveResult>>(`${this.api}/forms`, { description, number, type }, this.opts());
  }
  deleteForm(number: string, type: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/forms`, this.opts({ number, type }));
  }
  nextNumber(sub: string): Observable<ApiResponse<{ code: string }>> {
    return this.http.post<ApiResponse<{ code: string }>>(`${this.api}/forms/next-number`, { sub }, this.opts());
  }
  replaceWords(code: string, description: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/words`, { code, description }, this.opts());
  }
  addWords(code: string, description: string): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/words`, { code, description }, this.opts());
  }

  // ─── POSITION ───
  positions(number: string): Observable<ApiResponse<PositionRow[]>> {
    return this.http.get<ApiResponse<PositionRow[]>>(`${this.api}/positions`, this.opts({ number }));
  }
  insertPosition(description: string, number: string): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/positions`, { description, number }, this.opts());
  }
  updatePosition(description: string, number: string, oldDescription: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/positions`, { description, number, oldDescription }, this.opts());
  }
  deletePosition(number: string, name: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/positions`, this.opts({ number, name }));
  }

  // ─── relations ───
  formRelations(form: string, relation: string): Observable<ApiResponse<FormRelationRow[]>> {
    return this.http.get<ApiResponse<FormRelationRow[]>>(`${this.api}/relations/forms`, this.opts({ form, relation }));
  }
  subjectRelations(form: string, relation: string): Observable<ApiResponse<SubjectRelationRow[]>> {
    return this.http.get<ApiResponse<SubjectRelationRow[]>>(`${this.api}/relations/subjects`, this.opts({ form, relation }));
  }
  insertRelation(kind: 'forms' | 'subjects', first: string, second: string, relation: string): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/relations/${kind}`, { first, second, relation }, this.opts());
  }
  updateRelationDates(kind: 'forms' | 'subjects', first: string, second: string, relation: string,
                      start: string | null, end: string | null): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/relations/${kind}/dates`,
      { first, second, relation, start, end }, this.opts());
  }
  deleteRelation(kind: 'forms' | 'subjects', first: string, second: string, relation: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/relations/${kind}`, this.opts({ first, second, relation }));
  }

  // ─── "ملفات اضافية للادخال" (tmp_file.frm) ───
  searchAdditionalFiles(criteria: AdditionalFileCriterion[]): Observable<ApiResponse<AdditionalFileRow[]>> {
    return this.http.post<ApiResponse<AdditionalFileRow[]>>(`${this.api}/additional-files/search`, { criteria }, this.opts());
  }
  opTmp(fileNo: string): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/additional-files/op-tmp`, { fileNo }, this.opts());
  }
  updateAdditionalFile(original: AdditionalFileRow, column: string, value: string): Observable<ApiResponse<void>> {
    return this.http.put<ApiResponse<void>>(`${this.api}/additional-files`, { original, column, value }, this.opts());
  }
  insertAdditionalFile(values: Record<string, string>): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/additional-files`, { values }, this.opts());
  }
  deleteAdditionalFile(original: AdditionalFileRow): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/additional-files/delete`, { original }, this.opts());
  }

  // ─── MACNZ picker ───
  macnz(q: MacnzQuery): Observable<ApiResponse<MacnzRow[]>> {
    return this.http.get<ApiResponse<MacnzRow[]>>(`${this.api}/macnz`, this.opts(q));
  }
}
