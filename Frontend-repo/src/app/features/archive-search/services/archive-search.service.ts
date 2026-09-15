import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { ArchiveSearchRequest, ArchiveSearchResult, MediaResolveInfo, StockTier } from '../models/archive-search.model';

@Injectable({ providedIn: 'root' })
export class ArchiveSearchService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  search(request: ArchiveSearchRequest, page: number, size: number): Observable<ApiResponse<PageResponse<ArchiveSearchResult>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.post<ApiResponse<PageResponse<ArchiveSearchResult>>>(
      `${this.api}/api/archive-search`, request, { params });
  }

  /**
   * @param tier LOW is the legacy player's proxy (low_stock_path, rjp_typ = 2); HIGH is the
   *             broadcast master (high_stock_path, rjp_typ = 1) that delivery cuts from.
   * @param ext  the record's own extension — DIG_TYP for LOW, DIG_TYP_HIGH for HIGH
   */
  resolveMedia(stockNo: string, tier: StockTier = 'LOW', ext?: string | null): Observable<ApiResponse<MediaResolveInfo>> {
    return this.http.get<ApiResponse<MediaResolveInfo>>(
      `${this.api}/api/media/resolve/${encodeURIComponent(stockNo)}`,
      { params: this.tierParams(tier, ext) });
  }

  downloadMedia(stockNo: string, tier: StockTier = 'LOW', ext?: string | null): Observable<Blob> {
    return this.http.get(
      `${this.api}/api/media/file/${encodeURIComponent(stockNo)}`,
      { params: this.tierParams(tier, ext), responseType: 'blob' });
  }

  /**
   * Fetches a non-video asset (scan / photo / private document / audio wave) by its DIGIT
   * asset number, routed server-side on DIG_TYP1 — the migrated form of legacy
   * datagrid1_DblClick's branch for those four classes.
   */
  downloadAsset(digitNo: string, type1: string, ext?: string | null): Observable<Blob> {
    let params = new HttpParams().set('type1', type1);
    const trimmed = ext?.trim();
    if (trimmed) params = params.set('ext', trimmed);
    return this.http.get(
      `${this.api}/api/media/asset/${encodeURIComponent(digitNo)}`,
      { params, responseType: 'blob' });
  }

  private tierParams(tier: StockTier, ext?: string | null): HttpParams {
    let params = new HttpParams().set('tier', tier);
    const trimmed = ext?.trim();
    if (trimmed) params = params.set('ext', trimmed);
    return params;
  }

  saveRemark(appNo: string, remark: string): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(
      `${this.api}/api/archive-search/${encodeURIComponent(appNo)}/remark`, { remark });
  }

  /** Fetch responsible persons for dropdown (legacy m_res_no DataCombo) */
  getResponsiblePersons(): Observable<ApiResponse<any[]>> {
    return this.http.get<ApiResponse<any[]>>(
      `${this.api}/api/archive-search/responsible-persons`);
  }

  /** Fetch article types for dropdown (legacy m_mch_typ DataCombo) */
  getArticleTypes(): Observable<ApiResponse<any[]>> {
    return this.http.get<ApiResponse<any[]>>(
      `${this.api}/api/archive-search/article-types`);
  }

  /** Fetch document types for dropdown (legacy m_dig_typ1 DataCombo) */
  getDocumentTypes(): Observable<ApiResponse<any[]>> {
    return this.http.get<ApiResponse<any[]>>(
      `${this.api}/api/archive-search/document-types`);
  }
}
