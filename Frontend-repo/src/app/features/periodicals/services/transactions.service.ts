import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ApiResponse, PageResponse } from '../../../core/models/api-response.model';
import { Transaction, TransactionRequest } from '../models/periodical.model';

@Injectable({ providedIn: 'root' })
export class TransactionsService {

  private http = inject(HttpClient);
  private api = environment.apiUrl;

  getByPeriodical(periodicalId: number, page: number, size: number): Observable<ApiResponse<PageResponse<Transaction>>> {
    const params = new HttpParams().set('page', page).set('size', size);
    return this.http.get<ApiResponse<PageResponse<Transaction>>>(
      `${this.api}/api/periodicals/${periodicalId}/transactions`, { params });
  }

  create(data: TransactionRequest): Observable<ApiResponse<Transaction>> {
    return this.http.post<ApiResponse<Transaction>>(`${this.api}/api/transactions`, data);
  }

  delete(opno: number, no: number): Observable<ApiResponse<void>> {
    return this.http.delete<ApiResponse<void>>(`${this.api}/api/transactions/${opno}/${no}`);
  }
}
