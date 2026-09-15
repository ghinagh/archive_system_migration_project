import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { Book, BookRequest, BookAuthor, BookSubject, BookDescriptor, BookSeries } from '../models/book.model';

@Injectable({ providedIn: 'root' })
export class BooksService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/books`;

  getAll(page: number, size: number, title?: string, lang?: string, year?: number, publisher?: string): Observable<ApiResponse<PageResponse<Book>>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (title) params = params.set('title', title);
    if (lang) params = params.set('lang', lang);
    if (year) params = params.set('year', year);
    if (publisher) params = params.set('publisher', publisher);
    return this.http.get<ApiResponse<PageResponse<Book>>>(this.baseUrl, { params });
  }

  getById(appNo: string): Observable<ApiResponse<Book>> {
    return this.http.get<ApiResponse<Book>>(`${this.baseUrl}/${appNo}`);
  }

  create(data: BookRequest): Observable<ApiResponse<Book>> {
    return this.http.post<ApiResponse<Book>>(this.baseUrl, data);
  }

  createWithMain(data: BookRequest): Observable<ApiResponse<Book>> {
    return this.http.post<ApiResponse<Book>>(`${this.baseUrl}/with-main`, data);
  }

  update(appNo: string, data: BookRequest): Observable<ApiResponse<Book>> {
    return this.http.put<ApiResponse<Book>>(`${this.baseUrl}/${appNo}`, data);
  }

  delete(appNo: string): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${appNo}`);
  }

  getSubjects(appNo: string): Observable<ApiResponse<BookSubject[]>> {
    return this.http.get<ApiResponse<BookSubject[]>>(`${this.baseUrl}/${appNo}/subjects`);
  }

  getDescriptors(appNo: string): Observable<ApiResponse<BookDescriptor[]>> {
    return this.http.get<ApiResponse<BookDescriptor[]>>(`${this.baseUrl}/${appNo}/descriptors`);
  }

  getSeries(appNo: string): Observable<ApiResponse<BookSeries>> {
    return this.http.get<ApiResponse<BookSeries>>(`${this.baseUrl}/${appNo}/series`);
  }
}
