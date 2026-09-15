import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { Author, AuthorRequest } from '../models/author.model';

@Injectable({ providedIn: 'root' })
export class AuthorsService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getAll(page: number, size: number, name?: string, type?: string): Observable<ApiResponse<PageResponse<Author>>> {
    let p = new HttpParams().set('page', page).set('size', size);
    if (name) p = p.set('name', name);
    if (type) p = p.set('type', type);
    return this.http.get<ApiResponse<PageResponse<Author>>>(`${this.api}/api/authors`, { params: p });
  }

  create(req: AuthorRequest): Observable<ApiResponse<Author>> {
    return this.http.post<ApiResponse<Author>>(`${this.api}/api/authors`, req);
  }

  update(autNo: number, req: AuthorRequest): Observable<ApiResponse<Author>> {
    return this.http.put<ApiResponse<Author>>(`${this.api}/api/authors/${autNo}`, req);
  }

  delete(autNo: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/authors/${autNo}`);
  }
}
