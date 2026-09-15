import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import {
  BorrowingRecord, BorrowingRequest, ReturnRequest,
  BorrowingBook, BorrowingBookRequest,
  BorrowingOther, BorrowingOtherRequest,
  BookResult
} from '../models/borrowing.model';

@Injectable({ providedIn: 'root' })
export class BorrowingService {

  private http = inject(HttpClient);
  private baseUrl = `${environment.apiUrl}/api/borrowing`;

  getAll(page: number, size: number, personNo?: string, borrowingType?: number,
         dateFrom?: string, dateTo?: string): Observable<ApiResponse<PageResponse<BorrowingRecord>>> {
    let params = new HttpParams()
      .set('page', page)
      .set('size', size);

    if (personNo) params = params.set('personNo', personNo);
    if (borrowingType != null) params = params.set('borrowingType', borrowingType);
    if (dateFrom) params = params.set('dateFrom', dateFrom);
    if (dateTo) params = params.set('dateTo', dateTo);

    return this.http.get<ApiResponse<PageResponse<BorrowingRecord>>>(this.baseUrl, { params });
  }

  getById(iarNo: string, serial: number, borrowingType: number): Observable<ApiResponse<BorrowingRecord>> {
    const params = new HttpParams()
      .set('iarNo', iarNo)
      .set('serial', serial)
      .set('borrowingType', borrowingType);
    return this.http.get<ApiResponse<BorrowingRecord>>(`${this.baseUrl}/lookup`, { params });
  }

  create(request: BorrowingRequest): Observable<ApiResponse<BorrowingRecord>> {
    return this.http.post<ApiResponse<BorrowingRecord>>(this.baseUrl, request);
  }

  returnItem(iarNo: string, serial: number, borrowingType: number,
             request: ReturnRequest): Observable<ApiResponse<BorrowingRecord>> {
    const params = new HttpParams()
      .set('iarNo', iarNo)
      .set('serial', serial)
      .set('borrowingType', borrowingType);
    return this.http.patch<ApiResponse<BorrowingRecord>>(`${this.baseUrl}/return`, request, { params });
  }

  getBooks(iarNo: string): Observable<ApiResponse<BorrowingBook[]>> {
    return this.http.get<ApiResponse<BorrowingBook[]>>(`${this.baseUrl}/${iarNo}/books`);
  }

  addBook(iarNo: string, request: BorrowingBookRequest): Observable<ApiResponse<BorrowingBook>> {
    return this.http.post<ApiResponse<BorrowingBook>>(`${this.baseUrl}/${iarNo}/books`, request);
  }

  removeBook(iarNo: string, iabSer: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${iarNo}/books/${iabSer}`);
  }

  getOthers(iarNo: string): Observable<ApiResponse<BorrowingOther[]>> {
    return this.http.get<ApiResponse<BorrowingOther[]>>(`${this.baseUrl}/${iarNo}/others`);
  }

  addOther(iarNo: string, request: BorrowingOtherRequest): Observable<ApiResponse<BorrowingOther>> {
    return this.http.post<ApiResponse<BorrowingOther>>(`${this.baseUrl}/${iarNo}/others`, request);
  }

  removeOther(iarNo: string, iaoSer: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.baseUrl}/${iarNo}/others/${iaoSer}`);
  }

  searchBooks(term: string): Observable<BookResult[]> {
    const params = new HttpParams().set('title', term).set('page', '0').set('size', '10');
    return this.http.get<ApiResponse<PageResponse<BookResult>>>(`${environment.apiUrl}/api/books`, { params })
      .pipe(map(res => res.data.content));
  }
}
