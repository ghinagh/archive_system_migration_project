import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { CatalogueItem } from '../../catalogue/models/catalogue.models';
import {
  RenumberRequest,
  CopyToArchiveRequest,
  CopyToArchiveResult,
  FileLink,
  FileLinkRequest,
  BackupInfo,
  RetrievalField,
  RetrievalFieldRequest
} from '../models/maintenance.model';

@Injectable({ providedIn: 'root' })
export class MaintenanceService {

  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/maintenance';
  private adminUrl = environment.apiUrl + '/api/admin';
  private catalogueUrl = environment.apiUrl + '/api/catalogue';
  private retrievalFieldsUrl = environment.apiUrl + '/api/retrieval-fields';

  renumber(request: RenumberRequest): Observable<ApiResponse<void>> {
    return this.http.post<ApiResponse<void>>(`${this.baseUrl}/renumber`, request);
  }

  copyToArchive(request: CopyToArchiveRequest): Observable<ApiResponse<CopyToArchiveResult>> {
    return this.http.post<ApiResponse<CopyToArchiveResult>>(`${this.baseUrl}/copy-to-archive`, request);
  }

  linkFile(request: FileLinkRequest): Observable<ApiResponse<FileLink>> {
    return this.http.post<ApiResponse<FileLink>>(`${this.baseUrl}/file-links`, request);
  }

  getFileLinks(appNo: string): Observable<ApiResponse<FileLink[]>> {
    return this.http.get<ApiResponse<FileLink[]>>(`${this.baseUrl}/file-links/${appNo}`);
  }

  deleteFileLink(id: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/file-links/${id}`);
  }

  // --- Database backup ---

  createBackup(): Observable<ApiResponse<BackupInfo>> {
    return this.http.post<ApiResponse<BackupInfo>>(`${this.adminUrl}/backup`, {});
  }

  listBackups(): Observable<ApiResponse<BackupInfo[]>> {
    return this.http.get<ApiResponse<BackupInfo[]>>(`${this.adminUrl}/backup`);
  }

  // --- Unlock documents ---

  getLockedDocuments(page: number, size: number): Observable<ApiResponse<PageResponse<CatalogueItem>>> {
    return this.http.get<ApiResponse<PageResponse<CatalogueItem>>>(`${this.catalogueUrl}/locked`, {
      params: { page, size }
    });
  }

  unlockDocument(appNo: string): Observable<ApiResponse<CatalogueItem>> {
    return this.http.patch<ApiResponse<CatalogueItem>>(`${this.catalogueUrl}/${appNo}/unlock`, {});
  }

  // --- Retrieval fields ---

  getRetrievalFields(module?: string): Observable<ApiResponse<RetrievalField[]>> {
    return this.http.get<ApiResponse<RetrievalField[]>>(this.retrievalFieldsUrl, {
      params: module ? { module } : {}
    });
  }

  createRetrievalField(request: RetrievalFieldRequest): Observable<ApiResponse<RetrievalField>> {
    return this.http.post<ApiResponse<RetrievalField>>(this.retrievalFieldsUrl, request);
  }

  updateRetrievalField(id: string, request: RetrievalFieldRequest): Observable<ApiResponse<RetrievalField>> {
    return this.http.put<ApiResponse<RetrievalField>>(`${this.retrievalFieldsUrl}/${id}`, request);
  }

  deleteRetrievalField(id: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.retrievalFieldsUrl}/${id}`);
  }
}
