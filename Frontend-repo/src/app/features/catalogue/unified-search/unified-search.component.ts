import { Component, OnInit, OnDestroy, inject, signal, computed } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { Observable, of } from 'rxjs';
import { startWith, debounceTime, switchMap, catchError, map, tap } from 'rxjs/operators';
import { ArchiveSearchService } from '../../archive-search/services/archive-search.service';
import { ArchiveSearchResult } from '../../archive-search/models/archive-search.model';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { AutocompleteService } from '../../../core/services/autocomplete.service';

/**
 * Migrated equivalent of the legacy "شاشة البحث" (user_interface.frm) — a top-level menu item,
 * not nested under any submenu. Reuses the same query engine as /archive-search
 * (ArchiveSearchService), since both legacy screens share near-identical underlying SQL over
 * main/article/periodical/digit/author/thesaurus — extended here with the press-archive-only
 * filters (entry date, language, periodical, page count, digital asset/chart number) and the
 * F8/F9 search-mode toggle.
 *
 * Row shortcuts from the legacy grid map to: F2 (open the record) → "Open" button navigating to
 * the catalogue detail page (not gated by the legacy app-no prefix quirk); F6 (preview) →
 * "Preview" button loading the linked tape/stock into the shared video-preview component; F3
 * (export panel) → "Log Request" button, which registers a `result` row via
 * DigitizationService.logUsageRequest — the actual file-copy-to-folder side effect has no
 * meaningful web equivalent and is intentionally not reproduced, same as Command9/11's bulk
 * folder export. F9 (per-row export flag) has no equivalent since bulk file export was dropped.
 */
@Component({
  standalone: false,
  selector: 'app-unified-search',
  templateUrl: './unified-search.component.html',
  styleUrls: ['./unified-search.component.scss']
})
export class UnifiedSearchComponent implements OnInit, OnDestroy {

  private archiveSearchService = inject(ArchiveSearchService);
  private digitizationService = inject(DigitizationService);
  private autocompleteService = inject(AutocompleteService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private fb = inject(FormBuilder);

  displayedColumns = ['select', 'appNo', 'activeTitleAr', 'additionalTitle', 'docTypeDescription', 'articleDate', 'pageNo', 'periodicalName', 'responsiblePersonName', 'language', 'digitNo', 'actions'];

  results = signal<ArchiveSearchResult[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(10);
  isLoading = signal(false);
  hasSearched = signal(false);

  selected = signal<Set<string>>(new Set());
  hasSelection = computed(() => this.selected().size > 0);

  searchMode = signal<'STARTS_WITH' | 'CONTAINS'>('STARTS_WITH');

  filters = this.fb.group({
    word: [''],
    dateFrom: [''],
    dateTo: [''],
    entryDateFrom: [''],
    entryDateTo: [''],
    articleType: [''],
    documentType: [''],
    responsiblePersonNo: [''],
    generalIndexNo: [''],
    relatedFileNo: [''],
    geoLocation: [''],
    descriptorNo: [''],
    relatedDescriptorNo: [''],
    narrowerDescriptorNo: [''],
    fullText: [''],
    abstractWord: [''],
    language: [''],
    periodicalNo: [''],
    pageNo: [''],
    digitAssetNo: [''],
    chartNo: ['']
  });

  previewUrl = signal<string | null>(null);
  previewTitle = signal('');

  // Legacy DataCombo dropdown options
  articleTypeOptions = signal<{code: string; description: string}[]>([]);
  narrowerDescriptorOptions = signal<{code: string; description: string}[]>([]);

  // Responsible person autocomplete - Observable-based for mat-autocomplete integration
  filteredResponsiblePersons$!: Observable<{id: number; name: string}[]>;

  /** The rows currently being registered as one shared usage-request header — either a single
   *  row (per-row "Log Request" button) or every selected row (bulk "Log Request for Selected"),
   *  mirroring legacy's Command9/Command11 batch behavior. */
  logRequestRows = signal<ArchiveSearchResult[]>([]);
  logRequestForm = this.fb.group({
    person: ['', [Validators.required, Validators.maxLength(50)]],
    cote: ['', Validators.maxLength(3)],
    permit: ['', Validators.maxLength(2)],
    subject: ['', Validators.maxLength(50)]
  });

  ngOnInit(): void {
    this.loadDropdownOptions();
    this.loadResponsiblePersons();
  }

  ngOnDestroy(): void {
    this.releasePreview();
  }

  private loadResponsiblePersons(): void {
    // Set up autocomplete filtering based on input value changes
    // Mirrors legacy VB6 DataCombo behavior: displays AUT_NAM, stores AUT_NO
    const responsiblePersonControl = this.filters.get('responsiblePersonNo');
    if (!responsiblePersonControl) {
      console.log('[DEBUG] responsiblePersonControl not found');
      return;
    }
    console.log('[DEBUG] loadResponsiblePersons: control found, setting up Observable');

    type PersonOption = {id: number; name: string};

    this.filteredResponsiblePersons$ = responsiblePersonControl.valueChanges.pipe(
      tap((val) => console.log('[DEBUG] valueChanges emitted:', val, 'type:', typeof val)),
      startWith(''),
      tap((val) => console.log('[DEBUG] after startWith():', val, 'type:', typeof val)),
      debounceTime(300),
      tap((val) => console.log('[DEBUG] after debounceTime(300):', val)),
      switchMap((input: unknown) => {
        // If input is empty string or a number, search with wildcard to get all persons
        // If input is text, search for matching persons
        let searchTerm = '';
        if (typeof input === 'number') {
          // User selected a value from dropdown; don't re-query, just return cached data
          console.log('[DEBUG] input is number (person ID):', input, '— treating as empty search');
          searchTerm = '%';
        } else if (!input || input === '') {
          // Empty input or initial load: get all persons
          console.log('[DEBUG] empty input — loading all persons with wildcard');
          searchTerm = '%';
        } else {
          // User typed text: search for matching persons
          searchTerm = String(input);
          console.log('[DEBUG] user typed text:', searchTerm);
        }

        console.log('[DEBUG] calling searchAuthors with:', searchTerm);
        return this.autocompleteService.searchAuthors(searchTerm).pipe(
          tap((response) => console.log('[DEBUG] searchAuthors returned:', response?.data?.length ?? 0, 'items')),
          map((response) => {
            const data = response.data || [];
            console.log('[DEBUG] extracted data array:', data.length, 'items:', data.slice(0, 3));
            return data;
          }),
          catchError((error: unknown) => {
            console.error('[DEBUG] searchAuthors error:', error);
            return of([] as PersonOption[]);
          })
        );
      }),
      tap((data) => console.log('[DEBUG] final filtered data emitted:', data.length, 'items')),
    );
    console.log('[DEBUG] Observable chain created successfully');
  }

  displayResponsiblePerson(id: number): string {
    // Used by mat-autocomplete displayWith to show the person name after selection
    return id ? id.toString() : '';
  }

  private loadDropdownOptions(): void {
    // Load article type and narrower descriptor options from MACNZ table
    this.autocompleteService.getAllMacnz().subscribe({
      next: (response) => {
        const macnzList = response.data;
        // Filter for article types (level 01 in CODING)
        const articleTypes = macnzList
          .filter((item) => item.level === '01')
          .map((item) => ({ code: item.code, description: item.description }));
        this.articleTypeOptions.set(articleTypes);

        // Filter for narrower descriptors (level > 2)
        const narrowerDescriptors = macnzList
          .filter((item) => parseInt(item.level) > 2)
          .map((item) => ({ code: item.code, description: item.description }));
        this.narrowerDescriptorOptions.set(narrowerDescriptors);
      },
      error: () => {
        this.articleTypeOptions.set([]);
        this.narrowerDescriptorOptions.set([]);
      }
    });
  }

  search(): void {
    const v = this.filters.value;
    // Legacy allows empty search (returns all records) — removed no-criteria validation

    this.isLoading.set(true);
    this.hasSearched.set(true);
    this.archiveSearchService.search({
      word: v.word || undefined,
      dateFrom: v.dateFrom ? new Date(v.dateFrom).toISOString() : undefined,
      dateTo: v.dateTo ? new Date(v.dateTo).toISOString() : undefined,
      entryDateFrom: v.entryDateFrom ? new Date(v.entryDateFrom).toISOString() : undefined,
      entryDateTo: v.entryDateTo ? new Date(v.entryDateTo).toISOString() : undefined,
      articleType: v.articleType || undefined,
      documentType: v.documentType || undefined,
      responsiblePersonNo: v.responsiblePersonNo ? Number(v.responsiblePersonNo) : undefined,
      generalIndexNo: v.generalIndexNo || undefined,
      // relatedFileNo: v.relatedFileNo || undefined,  // TODO: backend support needed
      geoLocation: v.geoLocation || undefined,
      descriptorNo: v.descriptorNo || undefined,
      relatedDescriptorNo: v.relatedDescriptorNo || undefined,
      narrowerDescriptorNo: v.narrowerDescriptorNo || undefined,
      fullText: v.fullText || undefined,
      abstractWord: v.abstractWord || undefined,
      language: v.language || undefined,
      periodicalNo: v.periodicalNo ? Number(v.periodicalNo) : undefined,
      pageNo: v.pageNo || undefined,
      digitAssetNo: v.digitAssetNo || undefined,
      chartNo: v.chartNo || undefined,
      searchMode: this.searchMode()
    }, this.pageIndex(), this.pageSize()).subscribe({
      next: r => {
        this.results.set(r.data.content);
        this.totalElements.set(r.data.totalElements);
        this.isLoading.set(false);
        this.selected.set(new Set());
      },
      error: () => this.isLoading.set(false)
    });
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.search(); }

  clearFilters(): void {
    this.filters.reset();
    this.pageIndex.set(0);
    this.results.set([]);
    this.hasSearched.set(false);
  }

  openRecord(row: ArchiveSearchResult): void {
    this.router.navigate(['/catalogue', row.appNo]);
  }

  preview(row: ArchiveSearchResult): void {
    if (!row.machineStock) return;
    this.releasePreview();
    this.previewTitle.set(row.activeTitleAr);
    this.archiveSearchService.downloadMedia(row.machineStock).subscribe({
      next: blob => this.previewUrl.set(URL.createObjectURL(blob)),
      error: () => this.snackBar.open(this.translate.instant('SEARCH_SCREEN.MEDIA_UNAVAILABLE'), '', { duration: 3000 })
    });
  }

  closePreview(): void { this.releasePreview(); }

  isSelected(appNo: string): boolean { return this.selected().has(appNo); }

  toggleSelected(appNo: string): void {
    const next = new Set(this.selected());
    if (next.has(appNo)) next.delete(appNo); else next.add(appNo);
    this.selected.set(next);
  }

  toggleSelectAll(): void {
    this.selected.set(this.selected().size === this.results().length ? new Set() : new Set(this.results().map(r => r.appNo)));
  }

  /** Command9 "نسخ الاختيار" (as a single row) or the entry point for the bulk variant below. */
  openLogRequest(row: ArchiveSearchResult): void {
    this.startLogRequest([row]);
  }

  /** Command11 "نسخ الجدول" — registers every selected row under one shared request header. */
  openLogRequestForSelected(): void {
    const rows = this.results().filter(r => this.selected().has(r.appNo));
    if (rows.length === 0) return;
    this.startLogRequest(rows);
  }

  private startLogRequest(rows: ArchiveSearchResult[]): void {
    this.logRequestRows.set(rows);
    this.logRequestForm.reset({ person: '', cote: '', permit: '', subject: rows.length === 1 ? rows[0].activeTitleAr : '' });
  }

  cancelLogRequest(): void { this.logRequestRows.set([]); }

  submitLogRequest(): void {
    if (this.logRequestForm.invalid) { this.logRequestForm.markAllAsTouched(); return; }
    const rows = this.logRequestRows();
    if (rows.length === 0) return;
    const v = this.logRequestForm.getRawValue();
    this.digitizationService.logUsageRequest({
      items: rows.map(row => ({
        catalogueAppNo: row.appNo,
        digitNo: row.digitNo ?? undefined,
        type: row.documentType ?? undefined,
        type1: row.documentType1 ?? undefined
      })),
      person: v.person!,
      cote: v.cote || undefined,
      permit: v.permit || undefined,
      subject: v.subject || undefined
    }).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('SEARCH_SCREEN.REQUEST_LOGGED', { count: rows.length }), '', { duration: 3000 });
        this.logRequestRows.set([]);
        this.selected.set(new Set());
      }
    });
  }

  /** Command8 "طباعة الملف" — exports the current page of results; a full-list print job needs
   *  a proper background report, out of scope here (same simplification as the video-orders
   *  queue's "طباعة الجدول"). */
  exportCsv(): void {
    const rows = this.results();
    const header = ['appNo', 'activeTitleAr', 'additionalTitle', 'docTypeDescription', 'articleDate', 'pageNo', 'periodicalName', 'responsiblePersonName', 'language', 'digitNo'];
    const lines = [header.join(',')];
    for (const r of rows) {
      lines.push(header.map(h => `"${String((r as unknown as Record<string, unknown>)[h] ?? '').replace(/"/g, '""')}"`).join(','));
    }
    const blob = new Blob([lines.join('\n')], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'search-results.csv';
    a.click();
    URL.revokeObjectURL(url);
  }

  private releasePreview(): void {
    const current = this.previewUrl();
    if (current) URL.revokeObjectURL(current);
    this.previewUrl.set(null);
  }
}
