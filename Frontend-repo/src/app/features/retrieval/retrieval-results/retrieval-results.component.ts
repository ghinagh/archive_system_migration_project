import { Component, OnInit, inject, signal, computed } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { RetrievalService } from '../services/retrieval.service';
import { RETRIEVAL_SCOPE_SCREENS, RetrievalColumn, RetrievalResultRow, RetrievalScope, RetrievalSearchRequest } from '../models/retrieval.model';

/**
 * Migrated equivalent of frm_result's DataGrid1: a dynamic-column results grid built
 * from whichever fields the builder screen marked for display. The legacy screen's
 * double-click (open digital file), F2 (edit main record), F9 (mark choice), print/
 * report buttons, and bulk file-export panel were scoped out of this pass — opening
 * a row here navigates straight to the catalogue record, the one action every field
 * combination has in common. That action exists only for the bank scope: additional-files rows
 * are FORM records (tmp_result1) and newspapers & magazines rows are PERIOD/TRANS records
 * (tmp_result2) — not catalogue documents — so there is nothing to open there.
 */
@Component({
  standalone: false,
  selector: 'app-retrieval-results',
  templateUrl: './retrieval-results.component.html',
  styleUrls: ['./retrieval-results.component.scss']
})
export class RetrievalResultsComponent implements OnInit {

  private retrievalService = inject(RetrievalService);
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  readonly scope: RetrievalScope = this.route.snapshot.data['scope'] ?? 'BANK';
  readonly canOpenRecord = this.scope === 'BANK';

  columns = signal<RetrievalColumn[]>([]);
  rows = signal<RetrievalResultRow[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(25);
  isLoading = signal(false);
  hasQuery = signal(false);

  displayedColumns = computed(() => {
    const cols = this.columns().map(c => c.fieldKey);
    return this.canOpenRecord ? [...cols, 'actions'] : cols;
  });

  private request: RetrievalSearchRequest | null = null;

  ngOnInit(): void {
    const pending = this.retrievalService.pendingSearch();
    if (!pending || pending.scope !== this.scope) {
      this.hasQuery.set(false);
      return;
    }
    this.hasQuery.set(true);
    this.request = pending.request;
    this.pageIndex.set(pending.request.page);
    this.pageSize.set(pending.request.size);
    this.runSearch();
  }

  onPage(e: PageEvent): void {
    this.pageIndex.set(e.pageIndex);
    this.pageSize.set(e.pageSize);
    this.runSearch();
  }

  cellValue(row: RetrievalResultRow, fieldKey: string): unknown {
    return row.values[fieldKey];
  }

  openRecord(row: RetrievalResultRow): void {
    if (!this.canOpenRecord) {
      return;
    }
    this.router.navigate(['/catalogue', row.appNo]);
  }

  backToBuilder(): void {
    this.router.navigate([RETRIEVAL_SCOPE_SCREENS[this.scope].path]);
  }

  private runSearch(): void {
    if (!this.request) {
      return;
    }
    this.isLoading.set(true);
    const req: RetrievalSearchRequest = { ...this.request, page: this.pageIndex(), size: this.pageSize() };
    this.retrievalService.search(this.scope, req).subscribe({
      next: r => {
        this.columns.set(r.data.columns);
        this.rows.set(r.data.rows);
        this.totalElements.set(r.data.totalElements);
        this.isLoading.set(false);
      },
      error: () => this.isLoading.set(false)
    });
  }
}
