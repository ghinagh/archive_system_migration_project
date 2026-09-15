import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { OutputTemplate, OutputTemplateRequest, UserOutput, UserOutputRequest, ReportExecutionResult } from '../models/reports.model';

@Injectable({ providedIn: 'root' })
export class ReportsService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getTemplates(page: number, size: number, name?: string, type?: string, category?: string): Observable<ApiResponse<PageResponse<OutputTemplate>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (name) p = p.set('name', name);
    if (type) p = p.set('type', type);
    if (category) p = p.set('category', category);
    return this.http.get<ApiResponse<PageResponse<OutputTemplate>>>(`${this.api}/api/reports/templates`, { params: p });
  }

  getTemplateById(id: number): Observable<ApiResponse<OutputTemplate>> {
    return this.http.get<ApiResponse<OutputTemplate>>(`${this.api}/api/reports/templates/${id}`);
  }

  createTemplate(req: OutputTemplateRequest): Observable<ApiResponse<OutputTemplate>> {
    return this.http.post<ApiResponse<OutputTemplate>>(`${this.api}/api/reports/templates`, req);
  }

  updateTemplate(id: number, req: OutputTemplateRequest): Observable<ApiResponse<OutputTemplate>> {
    return this.http.put<ApiResponse<OutputTemplate>>(`${this.api}/api/reports/templates/${id}`, req);
  }

  deleteTemplate(id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/reports/templates/${id}`);
  }

  getUserOutputs(page: number, size: number, userNo?: string, institutionNo?: string): Observable<ApiResponse<PageResponse<UserOutput>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (userNo) p = p.set('userNo', userNo);
    if (institutionNo) p = p.set('institutionNo', institutionNo);
    return this.http.get<ApiResponse<PageResponse<UserOutput>>>(`${this.api}/api/reports/user-outputs`, { params: p });
  }

  createUserOutput(req: UserOutputRequest): Observable<ApiResponse<UserOutput>> {
    return this.http.post<ApiResponse<UserOutput>>(`${this.api}/api/reports/user-outputs`, req);
  }

  deleteUserOutput(institutionNo: string, userNo: string, outputNum: number): Observable<ApiResponse<void>> {
    const p = new HttpParams().set('institutionNo', institutionNo).set('userNo', userNo).set('outputNum', outputNum);
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/reports/user-outputs`, { params: p });
  }

  generateReport(reportType: string, params: Record<string, string>): Observable<Blob> {
    let p = new HttpParams();
    Object.entries(params).forEach(([k, v]) => { p = p.set(k, v); });
    return this.http.get(`${this.api}/api/reports/generate/${reportType}`, { params: p, responseType: 'blob' });
  }

  executeTemplate(templateNum: number, params: Record<string, string>): Observable<ApiResponse<ReportExecutionResult>> {
    let p = new HttpParams();
    Object.entries(params).forEach(([k, v]) => { if (v) p = p.set(k, v); });
    return this.http.get<ApiResponse<ReportExecutionResult>>(
      `${this.api}/api/reports/execute/${Math.round(templateNum)}`, { params: p });
  }
}
