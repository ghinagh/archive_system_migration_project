import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { FormDefinition, FormRequest, Site, SiteRequest, Post, PostRequest, SubjectLink, SubjectLinkRequest, RelForm, RelFormRequest, Position, PositionRequest } from '../models/sites.model';

@Injectable({ providedIn: 'root' })
export class SitesService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getForms(page: number, size: number, name?: string, type?: string): Observable<ApiResponse<PageResponse<FormDefinition>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (name) p = p.set('name', name);
    if (type) p = p.set('type', type);
    return this.http.get<ApiResponse<PageResponse<FormDefinition>>>(`${this.api}/api/forms`, { params: p });
  }

  getInstitutions(page: number, size: number): Observable<ApiResponse<PageResponse<FormDefinition>>> {
    const p = new HttpParams().set('page', page).set('size', size);
    return this.http.get<ApiResponse<PageResponse<FormDefinition>>>(`${this.api}/api/forms/institutions`, { params: p });
  }

  createForm(req: FormRequest): Observable<ApiResponse<FormDefinition>> {
    return this.http.post<ApiResponse<FormDefinition>>(`${this.api}/api/forms`, req);
  }

  updateForm(formNo: string, req: FormRequest): Observable<ApiResponse<FormDefinition>> {
    return this.http.put<ApiResponse<FormDefinition>>(`${this.api}/api/forms/${formNo}`, req);
  }

  deleteForm(formNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/forms/${formNo}`);
  }

  getSites(page: number, size: number, level?: string, status?: string, wilyaNo?: number): Observable<ApiResponse<PageResponse<Site>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (level) p = p.set('level', level);
    if (status) p = p.set('status', status);
    if (wilyaNo != null) p = p.set('wilyaNo', wilyaNo);
    return this.http.get<ApiResponse<PageResponse<Site>>>(`${this.api}/api/sites`, { params: p });
  }

  getSiteById(siteNo: string): Observable<ApiResponse<Site>> {
    return this.http.get<ApiResponse<Site>>(`${this.api}/api/sites/${siteNo}`);
  }

  createSite(req: SiteRequest): Observable<ApiResponse<Site>> {
    return this.http.post<ApiResponse<Site>>(`${this.api}/api/sites`, req);
  }

  updateSite(siteNo: string, req: SiteRequest): Observable<ApiResponse<Site>> {
    return this.http.put<ApiResponse<Site>>(`${this.api}/api/sites/${siteNo}`, req);
  }

  deleteSite(siteNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/sites/${siteNo}`);
  }

  getPosts(page: number, size: number, formNo?: string, wilyaNo?: number): Observable<ApiResponse<PageResponse<Post>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (formNo) p = p.set('formNo', formNo);
    if (wilyaNo != null) p = p.set('wilyaNo', wilyaNo);
    return this.http.get<ApiResponse<PageResponse<Post>>>(`${this.api}/api/posts`, { params: p });
  }

  getPostById(serial: string): Observable<ApiResponse<Post>> {
    return this.http.get<ApiResponse<Post>>(`${this.api}/api/posts/${serial}`);
  }

  createPost(req: PostRequest): Observable<ApiResponse<Post>> {
    return this.http.post<ApiResponse<Post>>(`${this.api}/api/posts`, req);
  }

  updatePost(serial: string, req: PostRequest): Observable<ApiResponse<Post>> {
    return this.http.put<ApiResponse<Post>>(`${this.api}/api/posts/${serial}`, req);
  }

  deletePost(serial: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/posts/${serial}`);
  }

  getSubjects(formNo: string): Observable<ApiResponse<SubjectLink[]>> {
    return this.http.get<ApiResponse<SubjectLink[]>>(`${this.api}/api/forms/${formNo}/subjects`);
  }

  addSubject(formNo: string, req: SubjectLinkRequest): Observable<ApiResponse<SubjectLink>> {
    return this.http.post<ApiResponse<SubjectLink>>(`${this.api}/api/forms/${formNo}/subjects`, req);
  }

  updateSubject(formNo: string, mcnzCode: string, req: SubjectLinkRequest): Observable<ApiResponse<SubjectLink>> {
    return this.http.put<ApiResponse<SubjectLink>>(`${this.api}/api/forms/${formNo}/subjects/${mcnzCode}`, req);
  }

  deleteSubject(formNo: string, mcnzCode: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/forms/${formNo}/subjects/${mcnzCode}`);
  }

  getRelatedForms(formNo: string): Observable<ApiResponse<RelForm[]>> {
    return this.http.get<ApiResponse<RelForm[]>>(`${this.api}/api/forms/${formNo}/related-forms`);
  }

  addRelatedForm(formNo: string, req: RelFormRequest): Observable<ApiResponse<RelForm>> {
    return this.http.post<ApiResponse<RelForm>>(`${this.api}/api/forms/${formNo}/related-forms`, req);
  }

  updateRelatedForm(formNo: string, form2No: string, req: RelFormRequest): Observable<ApiResponse<RelForm>> {
    return this.http.put<ApiResponse<RelForm>>(`${this.api}/api/forms/${formNo}/related-forms/${form2No}`, req);
  }

  deleteRelatedForm(formNo: string, form2No: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/forms/${formNo}/related-forms/${form2No}`);
  }

  getPositions(page: number, size: number, name?: string): Observable<ApiResponse<PageResponse<Position>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (name) p = p.set('name', name);
    return this.http.get<ApiResponse<PageResponse<Position>>>(`${this.api}/api/positions`, { params: p });
  }

  /**
   * Positions attached to a form entry, keyed by SUB_TYP || SUB_NO — the migrated form of
   * legacy proc_pos, reached by F2 over the form lookup on the archive search screen.
   */
  getPositionsByFormCode(formCode: string): Observable<ApiResponse<Position[]>> {
    return this.http.get<ApiResponse<Position[]>>(
      `${this.api}/api/positions/by-form/${encodeURIComponent(formCode)}`);
  }

  createPosition(req: PositionRequest): Observable<ApiResponse<Position>> {
    return this.http.post<ApiResponse<Position>>(`${this.api}/api/positions`, req);
  }

  updatePosition(posNo: string, req: PositionRequest): Observable<ApiResponse<Position>> {
    return this.http.put<ApiResponse<Position>>(`${this.api}/api/positions/${posNo}`, req);
  }

  deletePosition(posNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/positions/${posNo}`);
  }
}
