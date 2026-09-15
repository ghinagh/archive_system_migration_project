import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitResult } from '../../digitization/models/digitization.model';
import { TokenService } from '../../../core/services/token.service';

/**
 * Migrated equivalent of the legacy f_result.frm ("أرشيف طلبات الاستفادة" — Archive of
 * Beneficiary Usage Requests): search/filter/edit/cancel rows in the `result` table. New
 * requests can only be created from شاشة البحث's export-and-register workflow, matching the
 * legacy screen's own dead "اضافة" button — this list has no create action.
 */
@Component({
  standalone: false,
  selector: 'app-usage-request-list',
  templateUrl: './usage-request-list.component.html',
  styleUrls: ['./usage-request-list.component.scss']
})
export class UsageRequestListComponent implements OnInit {

  private digitizationService = inject(DigitizationService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private fb = inject(FormBuilder);
  private tokenService = inject(TokenService);

  readonly isAdmin = this.tokenService.getUser()?.level === 'A';

  displayedColumns = ['resultNo', 'catalogueTitle', 'person', 'coteDescription', 'permitDescription', 'subject', 'type1Description', 'date', 'userNo', 'actions'];

  items = signal<DigitResult[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(10);
  isLoading = signal(false);

  filters = this.fb.group({
    dateFrom: [''],
    dateTo: [''],
    title: [''],
    person: [''],
    cote: [''],
    permit: [''],
    resultNo: [''],
    digitNo: [''],
    type: [''],
    type1: ['']
  });

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.isLoading.set(true);
    const v = this.filters.value;
    this.digitizationService.getResults(this.pageIndex(), this.pageSize(), {
      dateFrom: v.dateFrom ? new Date(v.dateFrom).toISOString() : undefined,
      dateTo: v.dateTo ? new Date(v.dateTo).toISOString() : undefined,
      title: v.title || undefined,
      person: v.person || undefined,
      cote: v.cote || undefined,
      permit: v.permit || undefined,
      resultNo: v.resultNo || undefined,
      digitNo: v.digitNo || undefined,
      type: v.type || undefined,
      type1: v.type1 || undefined
    }).subscribe({
      next: r => { this.items.set(r.data.content); this.totalElements.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  applyFilter(): void { this.pageIndex.set(0); this.load(); }

  clearFilter(): void {
    this.filters.reset({ dateFrom: '', dateTo: '', title: '', person: '', cote: '', permit: '', resultNo: '', digitNo: '', type: '', type1: '' });
    this.pageIndex.set(0);
    this.load();
  }

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }

  onEdit(id: number): void { this.router.navigate(['/requests', id, 'edit']); }

  onDelete(id: number): void {
    if (!confirm(this.translate.instant('USAGE_REQUESTS.CONFIRM_CANCEL'))) return;
    this.digitizationService.deleteResult(id).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); },
      error: () => this.snackBar.open(this.translate.instant('USAGE_REQUESTS.CANCEL_DENIED'), '', { duration: 4000 })
    });
  }

  /** Command8 "طباعة الملف" — exports the current page; a full-list print job needs a proper
   *  background report, out of scope here (same simplification used on the other screens). */
  exportCsv(): void {
    const rows = this.items();
    const header = ['resultNo', 'catalogueAppNo', 'catalogueTitle', 'person', 'cote', 'coteDescription', 'permit', 'permitDescription', 'subject', 'type1', 'type1Description', 'date', 'userNo'];
    const lines = [header.join(',')];
    for (const r of rows) {
      lines.push(header.map(h => `"${String((r as unknown as Record<string, unknown>)[h] ?? '').replace(/"/g, '""')}"`).join(','));
    }
    const blob = new Blob([lines.join('\n')], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'usage-requests.csv';
    a.click();
    URL.revokeObjectURL(url);
  }
}
