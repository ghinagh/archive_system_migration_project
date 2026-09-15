import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { CatalogueItem, CatalogueFormData, NarowerTerm, NarowerRequest, RelatedTerm, RelatedRequest, CatalogueLinkedAuthor, LinkedAuthorRequest, CorrectionLog, DateSubject, DateSubjectRequest, Text1Item, Text1Request, Main2Item, Main2Request, SubjectDescriptor, SubjectDescriptorRequest, GeoDescriptor, GeoDescriptorRequest, FileAddItem, FileAddRequest, TimeDescriptor, TimeDescriptorRequest } from '../models/catalogue.models';
import { SearchCondition } from '../../../shared/models/search-condition.model';

@Injectable({ providedIn: 'root' })
export class CatalogueService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/catalogue`;

  getAll(page: number, size: number, type?: string, dateFrom?: string, dateTo?: string, sort?: string): Observable<ApiResponse<PageResponse<CatalogueItem>>> {
    let params = new HttpParams()
      .set('page', page)
      .set('size', size);

    if (type) params = params.set('type', type);
    if (dateFrom) params = params.set('dateFrom', dateFrom);
    if (dateTo) params = params.set('dateTo', dateTo);
    if (sort) params = params.set('sort', sort);

    return this.http.get<ApiResponse<PageResponse<CatalogueItem>>>(this.baseUrl, { params });
  }

  advancedSearch(conditions: SearchCondition[], page: number, size: number): Observable<ApiResponse<PageResponse<CatalogueItem>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.post<ApiResponse<PageResponse<CatalogueItem>>>(`${this.baseUrl}/search`, { conditions }, { params });
  }

  getById(appNo: string): Observable<ApiResponse<CatalogueItem>> {
    return this.http.get<ApiResponse<CatalogueItem>>(`${this.baseUrl}/${appNo}`);
  }

  create(data: CatalogueFormData): Observable<ApiResponse<CatalogueItem>> {
    return this.http.post<ApiResponse<CatalogueItem>>(this.baseUrl, data);
  }

  update(appNo: string, data: CatalogueFormData): Observable<ApiResponse<CatalogueItem>> {
    return this.http.put<ApiResponse<CatalogueItem>>(`${this.baseUrl}/${appNo}`, data);
  }

  delete(appNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}`);
  }

  unlock(appNo: string): Observable<ApiResponse<CatalogueItem>> {
    return this.http.patch<ApiResponse<CatalogueItem>>(`${this.baseUrl}/${appNo}/unlock`, {});
  }

  getNarrowerTerms(appNo: string): Observable<ApiResponse<NarowerTerm[]>> {
    return this.http.get<ApiResponse<NarowerTerm[]>>(`${this.baseUrl}/${appNo}/narrower`);
  }

  addNarrowerTerm(appNo: string, req: NarowerRequest): Observable<ApiResponse<NarowerTerm>> {
    return this.http.post<ApiResponse<NarowerTerm>>(`${this.baseUrl}/${appNo}/narrower`, req);
  }

  deleteNarrowerTerm(appNo: string, id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/narrower/${id}`);
  }

  getRelatedTerms(appNo: string): Observable<ApiResponse<RelatedTerm[]>> {
    return this.http.get<ApiResponse<RelatedTerm[]>>(`${this.baseUrl}/${appNo}/related`);
  }

  addRelatedTerm(appNo: string, req: RelatedRequest): Observable<ApiResponse<RelatedTerm>> {
    return this.http.post<ApiResponse<RelatedTerm>>(`${this.baseUrl}/${appNo}/related`, req);
  }

  deleteRelatedTerm(appNo: string, id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/related/${id}`);
  }

  getSubjects(appNo: string): Observable<ApiResponse<SubjectDescriptor[]>> {
    return this.http.get<ApiResponse<SubjectDescriptor[]>>(`${this.baseUrl}/${appNo}/subjects`);
  }

  addSubject(appNo: string, req: SubjectDescriptorRequest): Observable<ApiResponse<SubjectDescriptor>> {
    return this.http.post<ApiResponse<SubjectDescriptor>>(`${this.baseUrl}/${appNo}/subjects`, req);
  }

  deleteSubject(appNo: string, id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/subjects/${id}`);
  }

  getGeoDescriptors(appNo: string): Observable<ApiResponse<GeoDescriptor[]>> {
    return this.http.get<ApiResponse<GeoDescriptor[]>>(`${this.baseUrl}/${appNo}/geo`);
  }

  addGeoDescriptor(appNo: string, req: GeoDescriptorRequest): Observable<ApiResponse<GeoDescriptor>> {
    return this.http.post<ApiResponse<GeoDescriptor>>(`${this.baseUrl}/${appNo}/geo`, req);
  }

  deleteGeoDescriptor(appNo: string, id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/geo/${id}`);
  }

  getFiles(appNo: string): Observable<ApiResponse<FileAddItem[]>> {
    return this.http.get<ApiResponse<FileAddItem[]>>(`${this.baseUrl}/${appNo}/files`);
  }

  addFile(appNo: string, req: FileAddRequest): Observable<ApiResponse<FileAddItem>> {
    return this.http.post<ApiResponse<FileAddItem>>(`${this.baseUrl}/${appNo}/files`, req);
  }

  deleteFile(appNo: string, id: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/files/${id}`);
  }

  getTimeDescriptors(appNo: string): Observable<ApiResponse<TimeDescriptor[]>> {
    return this.http.get<ApiResponse<TimeDescriptor[]>>(`${this.baseUrl}/${appNo}/time-descriptors`);
  }

  addTimeDescriptor(appNo: string, req: TimeDescriptorRequest): Observable<ApiResponse<TimeDescriptor>> {
    return this.http.post<ApiResponse<TimeDescriptor>>(`${this.baseUrl}/${appNo}/time-descriptors`, req);
  }

  deleteTimeDescriptor(appNo: string, serNo: string, rltvNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/time-descriptors/${serNo}/${rltvNo}`);
  }

  getLinkedAuthors(appNo: string): Observable<ApiResponse<CatalogueLinkedAuthor[]>> {
    return this.http.get<ApiResponse<CatalogueLinkedAuthor[]>>(`${this.baseUrl}/${appNo}/authors`);
  }

  addLinkedAuthor(appNo: string, req: LinkedAuthorRequest): Observable<ApiResponse<CatalogueLinkedAuthor>> {
    return this.http.post<ApiResponse<CatalogueLinkedAuthor>>(`${this.baseUrl}/${appNo}/authors`, req);
  }

  updateLinkedAuthor(appNo: string, id: number, req: LinkedAuthorRequest): Observable<ApiResponse<CatalogueLinkedAuthor>> {
    return this.http.put<ApiResponse<CatalogueLinkedAuthor>>(`${this.baseUrl}/${appNo}/authors/${id}`, req);
  }

  removeLinkedAuthor(appNo: string, id: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/authors/${id}`);
  }

  getDateSubjects(appNo: string): Observable<ApiResponse<DateSubject[]>> {
    return this.http.get<ApiResponse<DateSubject[]>>(`${this.baseUrl}/${appNo}/date-subjects`);
  }

  addDateSubject(appNo: string, req: DateSubjectRequest): Observable<ApiResponse<DateSubject>> {
    return this.http.post<ApiResponse<DateSubject>>(`${this.baseUrl}/${appNo}/date-subjects`, req);
  }

  deleteDateSubject(appNo: string, serNo: string, relNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/date-subjects/${serNo}/${relNo}`);
  }

  getText1(appNo: string): Observable<ApiResponse<Text1Item[]>> {
    return this.http.get<ApiResponse<Text1Item[]>>(`${this.baseUrl}/${appNo}/text1`);
  }

  createText1(appNo: string, req: Text1Request): Observable<ApiResponse<Text1Item>> {
    return this.http.post<ApiResponse<Text1Item>>(`${this.baseUrl}/${appNo}/text1`, req);
  }

  updateText1(appNo: string, serNo: string, req: Text1Request): Observable<ApiResponse<Text1Item>> {
    return this.http.put<ApiResponse<Text1Item>>(`${this.baseUrl}/${appNo}/text1/${serNo}`, req);
  }

  deleteText1(appNo: string, serNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}/text1/${serNo}`);
  }

  getCorrections(appNo: string): Observable<ApiResponse<CorrectionLog[]>> {
    return this.http.get<ApiResponse<CorrectionLog[]>>(`${this.baseUrl}/${appNo}/corrections`);
  }

  getExtendedInfo(appNo: string): Observable<ApiResponse<Main2Item>> {
    return this.http.get<ApiResponse<Main2Item>>(`${this.baseUrl}/${appNo}/extended`);
  }

  createExtendedInfo(appNo: string, req: Main2Request): Observable<ApiResponse<Main2Item>> {
    return this.http.post<ApiResponse<Main2Item>>(`${this.baseUrl}/${appNo}/extended`, req);
  }

  updateExtendedInfo(appNo: string, req: Main2Request): Observable<ApiResponse<Main2Item>> {
    return this.http.put<ApiResponse<Main2Item>>(`${this.baseUrl}/${appNo}/extended`, req);
  }
}
