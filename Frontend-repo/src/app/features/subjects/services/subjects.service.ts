import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { MacnzSubject, MacnzRequest, SubjectAnalysis, SubjectAnalysisRequest, CodingEntry, CodingRequest, ChartItem } from '../models/subject.model';

@Injectable({ providedIn: 'root' })
export class SubjectsService {

  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl;

  getAllSubjects(): Observable<ApiResponse<MacnzSubject[]>> {
    return this.http.get<ApiResponse<MacnzSubject[]>>(`${this.apiUrl}/api/lookups/subjects`);
  }

  createSubject(req: MacnzRequest): Observable<ApiResponse<MacnzSubject>> {
    return this.http.post<ApiResponse<MacnzSubject>>(`${this.apiUrl}/api/lookups/subjects`, req);
  }

  updateSubject(code: string, req: MacnzRequest): Observable<ApiResponse<MacnzSubject>> {
    return this.http.put<ApiResponse<MacnzSubject>>(`${this.apiUrl}/api/lookups/subjects/${code}`, req);
  }

  deleteSubject(code: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.apiUrl}/api/lookups/subjects/${code}`);
  }

  getDocumentSubjects(appNo: string): Observable<ApiResponse<SubjectAnalysis[]>> {
    return this.http.get<ApiResponse<SubjectAnalysis[]>>(`${this.apiUrl}/api/catalogue/${appNo}/subjects`);
  }

  addDocumentSubject(appNo: string, request: SubjectAnalysisRequest): Observable<ApiResponse<SubjectAnalysis>> {
    return this.http.post<ApiResponse<SubjectAnalysis>>(`${this.apiUrl}/api/catalogue/${appNo}/subjects`, request);
  }

  removeDocumentSubject(appNo: string, id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.apiUrl}/api/catalogue/${appNo}/subjects/${id}`);
  }

  getAllCoding(): Observable<ApiResponse<CodingEntry[]>> {
    return this.http.get<ApiResponse<CodingEntry[]>>(`${this.apiUrl}/api/lookups/coding`);
  }

  createCoding(req: CodingRequest): Observable<ApiResponse<CodingEntry>> {
    return this.http.post<ApiResponse<CodingEntry>>(`${this.apiUrl}/api/lookups/coding`, req);
  }

  updateCoding(level: string, code: string, req: CodingRequest): Observable<ApiResponse<CodingEntry>> {
    return this.http.put<ApiResponse<CodingEntry>>(`${this.apiUrl}/api/lookups/coding/${level}/${code}`, req);
  }

  deleteCoding(level: string, code: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.apiUrl}/api/lookups/coding/${level}/${code}`);
  }

  getRelatedCharts(subCode: string): Observable<ApiResponse<PageResponse<ChartItem>>> {
    return this.http.get<ApiResponse<PageResponse<ChartItem>>>(
      `${this.apiUrl}/api/archive/charts`,
      { params: { subjectCode: subCode, size: '50' } }
    );
  }
}
