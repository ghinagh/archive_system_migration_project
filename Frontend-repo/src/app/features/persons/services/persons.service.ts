import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { Person, PersonRequest, PostAssignment, PersonAssignment } from '../models/person.model';

@Injectable({ providedIn: 'root' })
export class PersonsService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/persons`;

  getAll(page: number, size: number, name?: string, entity?: string): Observable<ApiResponse<PageResponse<Person>>> {
    let params = new HttpParams()
      .set('page', page)
      .set('size', size);

    if (name) params = params.set('name', name);
    if (entity) params = params.set('entity', entity);

    return this.http.get<ApiResponse<PageResponse<Person>>>(this.baseUrl, { params });
  }

  getById(prsNo: string): Observable<ApiResponse<Person>> {
    return this.http.get<ApiResponse<Person>>(`${this.baseUrl}/${prsNo}`);
  }

  create(request: PersonRequest): Observable<ApiResponse<Person>> {
    return this.http.post<ApiResponse<Person>>(this.baseUrl, request);
  }

  update(prsNo: string, request: PersonRequest): Observable<ApiResponse<Person>> {
    return this.http.put<ApiResponse<Person>>(`${this.baseUrl}/${prsNo}`, request);
  }

  delete(prsNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${prsNo}`);
  }

  getAssignments(prsNo: string): Observable<ApiResponse<PersonAssignment[]>> {
    return this.http.get<ApiResponse<PersonAssignment[]>>(`${this.baseUrl}/${prsNo}/assignments`);
  }
}
