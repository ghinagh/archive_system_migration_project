import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { DigitRecord, DigitRecordRequest, DigitDemand, DigitDemandRequest, DigitResult, DigitResultRequest, AddSceneRequest, DemandFulfilMechanism, DemandTestResult, DemandStats, LogUsageRequestBatch, DeliveryJobStatus } from '../models/digitization.model';

@Injectable({ providedIn: 'root' })
export class DigitizationService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getRecords(page: number, size: number, docNo?: string, type?: string): Observable<ApiResponse<PageResponse<DigitRecord>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (docNo) p = p.set('docNo', docNo);
    if (type) p = p.set('type', type);
    return this.http.get<ApiResponse<PageResponse<DigitRecord>>>(`${this.api}/api/digitization/records`, { params: p });
  }

  getRecordById(docNo: string, serial: number): Observable<ApiResponse<DigitRecord>> {
    const p = new HttpParams().set('docNo', docNo).set('serial', serial);
    return this.http.get<ApiResponse<DigitRecord>>(`${this.api}/api/digitization/records/lookup`, { params: p });
  }

  createRecord(req: DigitRecordRequest): Observable<ApiResponse<DigitRecord>> {
    return this.http.post<ApiResponse<DigitRecord>>(`${this.api}/api/digitization/records`, req);
  }

  /**
   * Legacy Form6.frm DataGrid1 Column04 space-bar → CommonDialog1.ShowOpen (:3568-3624).
   * DIG_DIG_NO and the file extension are generated server-side; this only sends the
   * classification fields and the file itself as multipart/form-data. Do not set a
   * Content-Type header here — the browser must set its own multipart boundary.
   */
  uploadRecord(docNo: string, serial: number, type1: string, file: File, extra?: Partial<DigitRecordRequest>): Observable<ApiResponse<DigitRecord>> {
    const form = new FormData();
    form.set('docNo', docNo);
    form.set('serial', String(serial));
    form.set('type1', type1);
    form.set('file', file, file.name);
    if (extra) {
      Object.entries(extra).forEach(([key, value]) => {
        if (value !== undefined && value !== null && value !== '') {
          form.set(key, String(value));
        }
      });
    }
    return this.http.post<ApiResponse<DigitRecord>>(`${this.api}/api/digitization/records/upload`, form);
  }

  updateRecord(docNo: string, serial: number, req: DigitRecordRequest): Observable<ApiResponse<DigitRecord>> {
    const p = new HttpParams().set('docNo', docNo).set('serial', serial);
    return this.http.put<ApiResponse<DigitRecord>>(`${this.api}/api/digitization/records`, req, { params: p });
  }

  deleteRecord(docNo: string, serial: number): Observable<ApiResponse<void>> {
    const p = new HttpParams().set('docNo', docNo).set('serial', serial);
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/digitization/records`, { params: p });
  }

  getDemands(page: number, size: number, filters?: {
    userNo?: string; machineNo?: string; demandNo?: string; machineStock?: string;
    fulfilled?: boolean; dateFrom?: string; dateTo?: string; search?: string;
  }): Observable<ApiResponse<PageResponse<DigitDemand>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (filters?.userNo) p = p.set('userNo', filters.userNo);
    if (filters?.machineNo) p = p.set('machineNo', filters.machineNo);
    if (filters?.demandNo) p = p.set('demandNo', filters.demandNo);
    if (filters?.machineStock) p = p.set('machineStock', filters.machineStock);
    if (filters?.fulfilled !== undefined && filters.fulfilled !== null) p = p.set('fulfilled', filters.fulfilled);
    if (filters?.dateFrom) p = p.set('dateFrom', filters.dateFrom);
    if (filters?.dateTo) p = p.set('dateTo', filters.dateTo);
    if (filters?.search) p = p.set('search', filters.search);
    return this.http.get<ApiResponse<PageResponse<DigitDemand>>>(`${this.api}/api/digitization/demands`, { params: p });
  }

  reassignDemandPath(id: number, path: string): Observable<ApiResponse<DigitDemand>> {
    return this.http.patch<ApiResponse<DigitDemand>>(`${this.api}/api/digitization/demands/${id}/path`, { path });
  }

  bulkSetDemandsFulfilled(ids: number[], fulfilled: boolean): Observable<ApiResponse<void>> {
    return this.http.patch<ApiResponse<void>>(`${this.api}/api/digitization/demands/bulk-status`, { ids, fulfilled });
  }

  /**
   * Writes the raw legacy dmd_chek value: 1 = queued/selected, 2 = fulfilled, 0 = skipped.
   * The archive-search cockpit's "الاختيار" column needs the de-selected state, which the
   * boolean form above cannot express.
   */
  setDemandsChecked(ids: number[], checked: number): Observable<ApiResponse<void>> {
    return this.http.patch<ApiResponse<void>>(`${this.api}/api/digitization/demands/bulk-status`, { ids, checked });
  }

  fulfilDemand(id: number, mechanism: DemandFulfilMechanism = 'COPY'): Observable<ApiResponse<DigitDemand>> {
    return this.http.post<ApiResponse<DigitDemand>>(`${this.api}/api/digitization/demands/${id}/fulfil`, { mechanism });
  }

  bulkFulfilDemands(ids: number[], mechanism: DemandFulfilMechanism, mergeClip: boolean): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.api}/api/digitization/demands/bulk-fulfil`, { ids, mechanism, mergeClip });
  }

  /** Legacy Command5 "ارسل الى EDLC" — starts the DV PAL delivery batch, returns a job handle. */
  sendDemandsToEdlc(ids: number[]): Observable<ApiResponse<DeliveryJobStatus>> {
    return this.http.post<ApiResponse<DeliveryJobStatus>>(
      `${this.api}/api/digitization/demands/send-to-edlc`, { ids });
  }

  /** Legacy Command14 "تنفيد" — starts the stream-copy clip batch, returns a job handle. */
  extractDemandClips(ids: number[]): Observable<ApiResponse<DeliveryJobStatus>> {
    return this.http.post<ApiResponse<DeliveryJobStatus>>(
      `${this.api}/api/digitization/demands/extract-clips`, { ids });
  }

  getDeliveryJob(jobId: string): Observable<ApiResponse<DeliveryJobStatus>> {
    return this.http.get<ApiResponse<DeliveryJobStatus>>(
      `${this.api}/api/digitization/demands/jobs/${encodeURIComponent(jobId)}`);
  }

  testDemands(ids: number[]): Observable<ApiResponse<DemandTestResult[]>> {
    return this.http.post<ApiResponse<DemandTestResult[]>>(`${this.api}/api/digitization/demands/test`, { ids });
  }

  getDemandStats(filters?: {
    userNo?: string; machineNo?: string; demandNo?: string; machineStock?: string;
    fulfilled?: boolean; dateFrom?: string; dateTo?: string; search?: string;
  }): Observable<ApiResponse<DemandStats>> {
    let p = new HttpParams();
    if (filters?.userNo) p = p.set('userNo', filters.userNo);
    if (filters?.machineNo) p = p.set('machineNo', filters.machineNo);
    if (filters?.demandNo) p = p.set('demandNo', filters.demandNo);
    if (filters?.machineStock) p = p.set('machineStock', filters.machineStock);
    if (filters?.fulfilled !== undefined && filters.fulfilled !== null) p = p.set('fulfilled', filters.fulfilled);
    if (filters?.dateFrom) p = p.set('dateFrom', filters.dateFrom);
    if (filters?.dateTo) p = p.set('dateTo', filters.dateTo);
    if (filters?.search) p = p.set('search', filters.search);
    return this.http.get<ApiResponse<DemandStats>>(`${this.api}/api/digitization/demands/stats`, { params: p });
  }

  downloadMedia(stockNo: string): Observable<Blob> {
    return this.http.get(`${this.api}/api/media/file/${encodeURIComponent(stockNo)}`, { responseType: 'blob' });
  }

  addScene(req: AddSceneRequest): Observable<ApiResponse<DigitDemand>> {
    return this.http.post<ApiResponse<DigitDemand>>(`${this.api}/api/digitization/demands/scenes`, req);
  }

  getDemandById(id: number): Observable<ApiResponse<DigitDemand>> {
    return this.http.get<ApiResponse<DigitDemand>>(`${this.api}/api/digitization/demands/${id}`);
  }

  createDemand(req: DigitDemandRequest): Observable<ApiResponse<DigitDemand>> {
    return this.http.post<ApiResponse<DigitDemand>>(`${this.api}/api/digitization/demands`, req);
  }

  deleteDemand(id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/digitization/demands/${id}`);
  }

  getResults(page: number, size: number, filters?: {
    digitNo?: string; type?: string; type1?: string; resultNo?: string; person?: string; cote?: string;
    permit?: string; subject?: string; title?: string; dateFrom?: string; dateTo?: string;
  }): Observable<ApiResponse<PageResponse<DigitResult>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (filters?.digitNo) p = p.set('digitNo', filters.digitNo);
    if (filters?.type) p = p.set('type', filters.type);
    if (filters?.type1) p = p.set('type1', filters.type1);
    if (filters?.resultNo) p = p.set('resultNo', filters.resultNo);
    if (filters?.person) p = p.set('person', filters.person);
    if (filters?.cote) p = p.set('cote', filters.cote);
    if (filters?.permit) p = p.set('permit', filters.permit);
    if (filters?.subject) p = p.set('subject', filters.subject);
    if (filters?.title) p = p.set('title', filters.title);
    if (filters?.dateFrom) p = p.set('dateFrom', filters.dateFrom);
    if (filters?.dateTo) p = p.set('dateTo', filters.dateTo);
    return this.http.get<ApiResponse<PageResponse<DigitResult>>>(`${this.api}/api/digitization/results`, { params: p });
  }

  getResultById(id: number): Observable<ApiResponse<DigitResult>> {
    return this.http.get<ApiResponse<DigitResult>>(`${this.api}/api/digitization/results/${id}`);
  }

  createResult(req: DigitResultRequest): Observable<ApiResponse<DigitResult>> {
    return this.http.post<ApiResponse<DigitResult>>(`${this.api}/api/digitization/results`, req);
  }

  updateResult(id: number, req: DigitResultRequest): Observable<ApiResponse<DigitResult>> {
    return this.http.put<ApiResponse<DigitResult>>(`${this.api}/api/digitization/results/${id}`, req);
  }

  logUsageRequest(req: LogUsageRequestBatch): Observable<ApiResponse<DigitResult[]>> {
    return this.http.post<ApiResponse<DigitResult[]>>(`${this.api}/api/digitization/results/log-usage`, req);
  }

  deleteResult(id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/digitization/results/${id}`);
  }

  /** "معالجة طلبات معينة" Frame2 تعديل (Command9) — legacy upd_result1 keys on رقم الطلب,
   *  updating every row sharing that request number at once. */
  updateResultByResultNo(resultNo: string, req: { person: string; cote: string; permit: string; subject: string }):
      Observable<ApiResponse<DigitResult[]>> {
    return this.http.put<ApiResponse<DigitResult[]>>(`${this.api}/api/digitization/results/by-number/${resultNo}`, req);
  }

  /** "معالجة طلبات معينة" Frame2 الغاء الطلب (Command6) — legacy del_result keys on رقم
   *  الطلب, deleting every row sharing it. */
  deleteResultByResultNo(resultNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/digitization/results/by-number/${resultNo}`);
  }
}
