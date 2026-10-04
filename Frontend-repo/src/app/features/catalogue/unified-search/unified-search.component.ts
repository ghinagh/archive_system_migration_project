import { Component, OnInit, OnDestroy, inject, signal, computed } from '@angular/core';
import { FormBuilder, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { Observable, of } from 'rxjs';
import { debounceTime, distinctUntilChanged, switchMap, catchError, map } from 'rxjs/operators';
import { toSignal } from '@angular/core/rxjs-interop';
import { SearchScreenService } from './search-screen.service';
import { SearchScreenRequest } from './search-screen.model';
import { ArchiveSearchResult } from '../../archive-search/models/archive-search.model';
import { VIDEO_ORDER_PRELOAD_STATE, VideoOrderPreload } from '../../digitization/models/digitization.model';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { AutocompleteService, AuthorOption, PeriodicalOption, CodingOption, MacnzOption, FormOption } from '../../../core/services/autocomplete.service';
import { ArchiveSearchService } from '../../archive-search/services/archive-search.service';

/** Legacy DIGIT.DIG_TYP1 classes datagrid1_DblClick (:2559-2568) resolves via OpenDoc — scan,
 *  waves(audio), photos, private. Anything else (video/04, blank) has no success path in that
 *  handler as literally written; it always fails to "هذا الملف غير موجود" for those classes. */
const OPENDOC_ASSET_CLASSES = new Set(['01', '02', '03', '05']);

/**
 * LEGACY MIGRATION: user_inetrface.frm, Section 1 (the top search panel, above
 * "جدول استرجاع المعلومات") — REBUILT FROM SCRATCH against the verified 22-control
 * inventory, not patched from the prior implementation.
 *
 * Deliberately separate query engine from /archive-search (USER_INTERFACE1.frm,
 * "شاشة البحث فيديو + صوتي", already finished) — see SearchScreenService (backend)
 * for why the two screens cannot share ArchiveSearchService.
 *
 * Legacy field-locking: every one of the 22 controls disables itself once its
 * criterion is committed (Enter for the 12 plain/date fields, selecting a dropdown
 * option, or picking a lookup-popup suggestion), and "بحث جديد" (Command4) is the
 * only thing that re-enables them (:2318-2419). Reproduced via Angular's native
 * FormControl.disable()/enable() — a disabled control's value is still read via
 * getRawValue() rather than .value, exactly as the already-migrated شاشة الطلبات
 * screen does for the same legacy pattern.
 *
 * The 6 lookup-popup fields (DBList1/DBList2 in legacy) each get their own
 * mat-autocomplete here instead of sharing one popup control — legacy's single
 * shared DBList1/DBList2 meant only one of its three fields could be "active" at a
 * time (a documented legacy quirk, :2661-2776), which has no faithful web
 * equivalent once each field owns its own suggestion list; a criterion is only
 * ever sent for a field once the user has actually picked one of its own
 * suggestions, never a stale pick from a different field.
 */
@Component({
  standalone: false,
  selector: 'app-unified-search',
  templateUrl: './unified-search.component.html',
  styleUrls: ['./unified-search.component.scss']
})
export class UnifiedSearchComponent implements OnInit, OnDestroy {

  private searchScreenService = inject(SearchScreenService);
  private digitizationService = inject(DigitizationService);
  private archiveSearchService = inject(ArchiveSearchService);
  private autocomplete = inject(AutocompleteService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private fb = inject(FormBuilder);

  // ===== Option1/Option2 "البحث ببداية الاسم" / "البحث بكلمة معينة" (:96-113) —
  // legacy default is Option1 (Form_Load :2899). Governs ONLY the 6 lookup-popup
  // fields' typeahead matching; every other field is unconditionally CONTAINS,
  // exactly as legacy's own per-field handlers hardcode it. =====
  searchMode = signal<'STARTS_WITH' | 'CONTAINS'>('STARTS_WITH');

  // ===== The 16 non-lookup controls: 6 plain text, 6 dropdowns, 4 dates =====
  form = this.fb.group({
    // plain text (6)
    titleWord: [''],           // m_word "كلمة من العناوين"
    digitAssetNo: [''],        // m_dig_dig_no "رقم digital"
    oldArchiveNo: [''],        // m_dig_nochrt "رقم الارشيف القديم"
    abstractWord: [''],        // m_mn_result "كلمة من المستخلص"
    fullText: [''],            // m_txt_text "كلمة من النص"
    pageNo: [''],              // m_art_pg_no "عدد الصفحات"
    // dropdowns (6)
    language: [''],            // m_art_lang "اللغة"
    articleType: [''],         // m_art_sub_ty "نوع الوثيقة" (right column)
    documentType: [''],        // m_dig_typ1 "نوع الوثيقة" (bottom-left)
    dataEntryOperator: [''],   // m_mn_data_en "مدخل البيانات"
    // dates (4)
    dateFrom: [''],            // M_art_dte "من تاريخ"
    dateTo: [''],              // M_art_dte1 "الى تاريخ"
    entryDateFrom: [''],       // m_ent_dte "من تاريخ الادخال"
    entryDateTo: ['']          // m_ent_dte1 "الى تاريخ الادخال"
  });

  // ===== 2 autocomplete dropdowns backed by server search (جهة الصدور / المسؤول البياني) =====
  periodicalControl = new FormControl<string | PeriodicalOption | null>('');
  responsiblePersonControl = new FormControl<string | AuthorOption | null>('');
  periodicalOptions = signal<PeriodicalOption[]>([]);
  responsiblePersonOptions = signal<AuthorOption[]>([]);

  // ===== 6 lookup-popup fields (legacy DBList1/DBList2), each its own control =====
  subjectDescriptorControl = new FormControl<string | MacnzOption | null>('');   // m_desc_no "الموضوع"
  relatedDescriptorControl = new FormControl<string | MacnzOption | null>('');   // m_rel_text "المترابط"
  narrowerDescriptorControl = new FormControl<string | MacnzOption | null>(''); // m_nar_text "الاضيق"
  additionalFileControl = new FormControl<string | FormOption | null>('');       // m_file_no "الملف الاضافي"
  geoLocationControl = new FormControl<string | FormOption | null>('');          // m_geo_text "المكان الجغرافي"
  photoPlaceControl = new FormControl<string | FormOption | null>('');           // m_geo_chrt "مكان التصوير/النشر"

  /** All 6 lookup controls in one place — used for uniform lock/reset (matches
   *  Command4's blanket re-enable of all 22 controls, :2318-2419). */
  private lookupControls = () => [
    this.subjectDescriptorControl, this.relatedDescriptorControl, this.narrowerDescriptorControl,
    this.additionalFileControl, this.geoLocationControl, this.photoPlaceControl,
    this.periodicalControl, this.responsiblePersonControl
  ];

  private macnzAll = signal<MacnzOption[]>([]);
  private subjectDescriptorValue = toSignal(this.subjectDescriptorControl.valueChanges, { initialValue: this.subjectDescriptorControl.value });
  private relatedDescriptorValue = toSignal(this.relatedDescriptorControl.valueChanges, { initialValue: this.relatedDescriptorControl.value });
  private narrowerDescriptorValue = toSignal(this.narrowerDescriptorControl.valueChanges, { initialValue: this.narrowerDescriptorControl.value });
  subjectDescriptorOptions = computed(() => this.filterMacnz(this.subjectDescriptorValue()));
  relatedDescriptorOptions = computed(() => this.filterMacnz(this.relatedDescriptorValue()));
  narrowerDescriptorOptions = computed(() => this.filterMacnz(this.narrowerDescriptorValue()));

  additionalFileOptions = signal<FormOption[]>([]);
  geoLocationOptions = signal<FormOption[]>([]);
  photoPlaceOptions = signal<FormOption[]>([]);

  languageOptions = signal<CodingOption[]>([]);
  articleTypeOptions = signal<CodingOption[]>([]);
  documentTypeOptions = signal<CodingOption[]>([]);
  dataEntryOperatorOptions = signal<CodingOption[]>([]);

  displayMacnz = (value: string | MacnzOption | null): string =>
    typeof value === 'string' ? value : (value?.description ?? '');
  displayForm = (value: string | FormOption | null): string =>
    typeof value === 'string' ? value : (value?.name ?? '');
  displayPeriodical = (value: string | PeriodicalOption | null): string =>
    typeof value === 'string' ? value : (value?.name ?? '');
  displayAuthor = (value: string | AuthorOption | null): string =>
    typeof value === 'string' ? value : (value?.name ?? '');

  private filterMacnz(value: string | MacnzOption | null): MacnzOption[] {
    const term = (typeof value === 'string' ? value : value?.description ?? '').trim().toLowerCase();
    if (!term) return [];
    return this.macnzAll().filter(o => this.matchesMode(o.description, term)).slice(0, 25);
  }

  /** Legacy serh_macnz/serh_allform (STARTS_WITH) vs serh_wrdmacnz/serh_wrdform (CONTAINS). */
  private matchesMode(candidate: string | null | undefined, term: string): boolean {
    if (!candidate) return false;
    const c = candidate.toLowerCase();
    return this.searchMode() === 'STARTS_WITH' ? c.startsWith(term) : c.includes(term);
  }

  results = signal<ArchiveSearchResult[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(10);
  isLoading = signal(false);
  hasSearched = signal(false);

  logRequestRows = signal<ArchiveSearchResult[]>([]);
  logRequestForm = this.fb.group({
    person: [''],
    cote: [''],
    permit: [''],
    subject: ['']
  });

  /**
   * SECTION 2 — "جدول استرجاع المعلومات" (DataGrid1, :1163-1503). Exactly the 9 visible legacy
   * columns, in legacy order (Column00/01/02/03/04/05/07/08/11 — Column06/09/10/12-17 are all
   * `Object.Visible = 0` in the .frm and stay off the grid). No "select"/"actions" columns —
   * those existed in the prior implementation but are not proven to exist in DataGrid1; the
   * REAL legacy selection mechanism is "الاختيار" (dig_choice) itself, toggled by F9 — see
   * toggleChoice() below.
   */
  displayedColumns = ['responsiblePersonName', 'appNo', 'activeTitleAr', 'additionalTitle', 'docTypeDescription', 'articleDate', 'periodicalName', 'digitNo', 'choice'];

  /** Legacy DataGrid1.Row — the row under the grid cursor, set by clicking a row (the web
   *  equivalent of moving the grid's cursor there) and read by F2/F9. */
  focusedAppNo = signal<string | null>(null);

  focusRow(row: ArchiveSearchResult): void {
    this.focusedAppNo.set(row.appNo);
  }

  isFocused(row: ArchiveSearchResult): boolean {
    return this.focusedAppNo() === row.appNo;
  }

  /**
   * Legacy DataGrid1_KeyDown (:2586-2622) — F9 toggles "الاختيار", F2 opens the record (only
   * when its app-no starts with "ق"), F3 opens Frame2 (the bulk "نسخ الاختيار"/"نسخ الجدول"
   * copy-to-folder panel — its actual file-copy side effect has no web equivalent, same
   * reasoning already applied to Command9/11 elsewhere in this app; what IS reproduced is its
   * one meaningful, reproducible effect: registering a usage-request row for every currently
   * "الاختيار"-flagged record, exactly what Command9 "نسخ الاختيار" iterates over, :2450-2545).
   */
  onGridKeydown(event: KeyboardEvent): void {
    const row = this.results().find(r => r.appNo === this.focusedAppNo());
    if (event.key === 'F9') {
      event.preventDefault();
      if (row) this.toggleChoice(row);
    } else if (event.key === 'F2') {
      event.preventDefault();
      if (row) this.openRecordIfEligible(row);
    } else if (event.key === 'F3') {
      event.preventDefault();
      this.logSelectedByChoice();
    } else if (event.key === 'F6') {
      event.preventDefault();
      if (row) this.openVideoOrders(row);
    }
  }

  /**
   * Legacy DataGrid1_KeyUp F6 (user_inetrface.frm:2624-2659): copies the focused row into the
   * v_mch_* globals and opens new_vdpreview ("طلبيات الفيديو") on that record. The row carries
   * the same columns legacy reads — its fixed tmp_result SELECT (:2403-2416) always includes them.
   */
  openVideoOrders(row: ArchiveSearchResult): void {
    const n = (v: number | null) => (v == null ? 0 : Number(v));
    const typ = row.documentType?.trim() || null;
    const preload: VideoOrderPreload = {
      machineNo: row.appNo,
      title: row.activeTitleAr,
      stock: row.digitNo?.trim() || null,
      inSeconds: n(row.durationSeconds) + n(row.durationMinutes) * 60 + n(row.durationHours) * 3600,
      outSeconds: n(row.durationSeconds1) + n(row.durationMinutes1) * 60 + n(row.durationHours1) * 3600,
      lowExtension: typ,
      highExtension: row.highType?.trim() || typ || 'avi'
    };
    this.router.navigate(['/video-orders'], { state: { [VIDEO_ORDER_PRELOAD_STATE]: preload } });
  }

  /** Legacy DataGrid1_KeyDown F9 (:2590-2605) — `execute upd_dig_choice(dig_dig_no, newValue,
   *  dig_typ1)`, then refreshes. Requires DIG_DIG_NO — rows without one (no digitized asset)
   *  have nothing for F9 to toggle, matching legacy (RESULT.Recordset![DIG_choice] would be
   *  on the same DIGIT-joined row). */
  toggleChoice(row: ArchiveSearchResult): void {
    if (!row.digitNo || !row.documentType1) return;
    const next = row.choice === 1 ? 0 : 1;
    this.searchScreenService.setChoice(row.digitNo, row.documentType1, next).subscribe({
      next: () => {
        this.results.update(list => list.map(r => r === row ? { ...r, choice: next } : r));
      }
    });
  }

  /**
   * Legacy Command9 "نسخ الاختيار" (:2481-2485) resets DIG_choice to 0 after a successful
   * FileCopy — the file-copy itself has no browser equivalent, but "the batch was
   * successfully processed" does: a successful logUsageRequest submission (this method is
   * only ever called from submitLogRequest's success branch, :514-518, never on cancel or on
   * a failed submission). Same DIG_DIG_NO + DIG_TYP1 identity as F9 (toggleChoice above);
   * persisted through the same endpoint so a later re-search reflects the cleared state too,
   * not just this page's local view.
   */
  private resetChoicesAfterLogging(rows: ArchiveSearchResult[]): void {
    for (const row of rows) {
      if (!row.digitNo || !row.documentType1) continue;
      this.searchScreenService.setChoice(row.digitNo, row.documentType1, 0).subscribe({
        next: () => {
          this.results.update(list => list.map(r => r === row ? { ...r, choice: 0 } : r));
        }
      });
    }
  }

  /** Legacy DataGrid1_KeyDown F2 (:2606-2616) — `If Mid(m_bk_no, 1, 1) = "ق" Then` gates
   *  whether Form6 (the documentation/entry form) opens at all; otherwise F2 does nothing. */
  private openRecordIfEligible(row: ArchiveSearchResult): void {
    if (row.appNo?.trim().startsWith('ق')) {
      this.openRecord(row);
    }
  }

  /** Command9 "نسخ الاختيار" (:2450-2545) — iterates every row with DIG_choice = 1. */
  private logSelectedByChoice(): void {
    const rows = this.results().filter(r => r.choice === 1);
    if (rows.length === 0) return;
    this.startLogRequest(rows);
  }

  /**
   * Legacy datagrid1_DblClick (:2549-2584) — resolves the asset path from DIG_TYP1 (01=scan,
   * 02=waves, 03=photos, 05=private) and opens it via OpenDoc; shows
   * "هذا الملف غير موجود في الارشيف...." when the file isn't on disk. Migrated as a download of
   * the same DIGIT-keyed asset via the already-existing media/asset endpoint, opened in a new
   * tab (the web analogue of OpenDoc launching the OS's associated viewer).
   */
  openAssetOnDblClick(row: ArchiveSearchResult): void {
    if (!row.digitNo || !row.documentType1 || !OPENDOC_ASSET_CLASSES.has(row.documentType1.trim())) {
      this.snackBar.open(this.translate.instant('SEARCH_SCREEN.FILE_NOT_FOUND'), '', { duration: 4000 });
      return;
    }
    this.archiveSearchService.downloadAsset(row.digitNo, row.documentType1, row.documentType).subscribe({
      next: blob => {
        const url = URL.createObjectURL(blob);
        window.open(url, '_blank');
      },
      error: () => this.snackBar.open(this.translate.instant('SEARCH_SCREEN.FILE_NOT_FOUND'), '', { duration: 4000 })
    });
  }

  ngOnInit(): void {
    this.autocomplete.getAllMacnz().pipe(catchError(() => of({ data: [] } as any)))
      .subscribe(r => this.macnzAll.set(r?.data ?? []));

    // م_dig_typ1 "نوع الوثيقة" (bottom-left) — PROVEN domain '24': user_inetrface.frm's own
    // Form_Load base query joins "'24'+ dbo.digit.dig_typ1 = dbo.CODING.SUB_CODE" (:2919).
    this.autocomplete.getCodingByCodePrefix('24').pipe(catchError(() => of({ data: [] } as any)))
      .subscribe(r => this.documentTypeOptions.set(r?.data ?? []));

    // م_art_lang "اللغة" — PROVEN domain '34': Form6.frm (the data-entry form for the same
    // field) sets `m_art_lang.BoundText = "34" + article.Resultset![art_lang1]` (:2724) and
    // defaults it to `"3401"` (:3137). Independently corroborated by user_inetrface.frm's own
    // adjacent `coding34` Adodc (RecordSource "...substring(sub_code,1,2)='34'", :1574-1619).
    this.autocomplete.getCodingByCodePrefix('34').pipe(catchError(() => of({ data: [] } as any)))
      .subscribe(r => this.languageOptions.set(r?.data ?? []));

    // م_art_sub_ty "نوع الوثيقة" (right column) — PROVEN domain '03': Form6.frm sets
    // `m_art_sub_ty.BoundText = "03" + article.Resultset![art_sub_ty]` (:2719).
    this.autocomplete.getCodingByCodePrefix('03').pipe(catchError(() => of({ data: [] } as any)))
      .subscribe(r => this.articleTypeOptions.set(r?.data ?? []));

    // م_mn_data_en "مدخل البيانات" — PROVEN domain '02': Form6.frm sets
    // `m_mn_data_en.BoundText = "02" + MSRDC1.Resultset![MN_data_en]` (:2654) and
    // `m_mn_data_en.BoundText = "02" + box_user_ent` as its default (:3121).
    this.autocomplete.getCodingByCodePrefix('02').pipe(catchError(() => of({ data: [] } as any)))
      .subscribe(r => this.dataEntryOperatorOptions.set(r?.data ?? []));

    this.wireFormLookup(this.additionalFileControl, this.additionalFileOptions);
    this.wireFormLookup(this.geoLocationControl, this.geoLocationOptions);
    this.wireFormLookup(this.photoPlaceControl, this.photoPlaceOptions);

    this.periodicalControl.valueChanges.pipe(
      debounceTime(300), distinctUntilChanged(),
      switchMap(v => {
        const q = typeof v === 'string' ? v.trim() : '';
        if (!q) return of<PeriodicalOption[]>([]);
        return this.autocomplete.searchPeriodicals(q).pipe(map(r => r.data ?? []), catchError(() => of([])));
      })
    ).subscribe(opts => this.periodicalOptions.set(opts));

    this.responsiblePersonControl.valueChanges.pipe(
      debounceTime(300), distinctUntilChanged(),
      switchMap(v => {
        const q = typeof v === 'string' ? v.trim() : '';
        if (!q) return of<AuthorOption[]>([]);
        return this.autocomplete.searchAuthors(q).pipe(map(r => r.data ?? []), catchError(() => of([])));
      })
    ).subscribe(opts => this.responsiblePersonOptions.set(opts));
  }

  ngOnDestroy(): void {}

  /** Legacy DBList1 popup (m_file_no/m_geo_text/m_geo_chrt), :3204-3346 — serh_allform
   *  (STARTS_WITH) / serh_wrdform (CONTAINS) over "view_form", migrated equivalent is the
   *  sites/forms lookup (AutocompleteService.searchForms) — already documented elsewhere in
   *  this codebase as the GEO/FILE_ADD ListField="sub_name" source. */
  private wireFormLookup(control: FormControl<string | FormOption | null>, options: ReturnType<typeof signal<FormOption[]>>): void {
    control.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(term => {
        const q = typeof term === 'string' ? term.trim() : '';
        if (q.length < 2) { options.set([]); return of(null); }
        return this.autocomplete.searchForms(q).pipe(catchError(() => of(null)), map(r => ({ rows: r?.data?.content ?? [], term: q.toLowerCase() })));
      })
    ).subscribe(payload => {
      if (!payload) { options.set([]); return; }
      options.set(this.searchMode() === 'STARTS_WITH'
        ? payload.rows.filter((o: FormOption) => o.name?.toLowerCase().startsWith(payload.term))
        : payload.rows);
    });
  }

  private codeOf<T extends object>(value: string | T | null | undefined, key: keyof T): string | undefined {
    if (value == null) return undefined;
    if (typeof value === 'string') return undefined; // typed but never picked — legacy requires an actual DBList selection
    const raw = (value as Record<keyof T, unknown>)[key];
    return raw == null ? undefined : String(raw);
  }

  // ===== Legacy per-field KeyPress(Enter): commits + locks that one field (:2932-3535).
  // Does not execute the search itself — only النتيجة (search()) does. =====
  commitField(name: keyof typeof this.form.controls): void {
    const ctrl = this.form.get(name as string);
    if (ctrl && ctrl.value) ctrl.disable();
  }

  /** Selecting a dropdown option or a lookup suggestion also locks the field, matching legacy
   *  (every DataCombo/DBList commit path sets Enabled=False immediately, not just Enter). */
  lockControl(ctrl: FormControl | null): void {
    if (ctrl && ctrl.value) ctrl.disable();
  }

  private hasAnyCriteria(): boolean {
    const v = this.form.getRawValue();
    return !!(v.titleWord || v.digitAssetNo || v.oldArchiveNo || v.abstractWord || v.fullText || v.pageNo
      || v.language || v.articleType || v.documentType || v.dataEntryOperator
      || v.dateFrom || v.dateTo || v.entryDateFrom || v.entryDateTo
      || this.codeOf(this.periodicalControl.value, 'perNo' as never) || this.periodicalControl.value
      || this.responsiblePersonControl.value
      || this.subjectDescriptorControl.value || this.relatedDescriptorControl.value || this.narrowerDescriptorControl.value
      || this.additionalFileControl.value || this.geoLocationControl.value || this.photoPlaceControl.value);
  }

  private lockFilledFields(): void {
    Object.values(this.form.controls).forEach(ctrl => { if (ctrl.value) ctrl.disable(); });
    this.lookupControls().forEach(ctrl => this.lockControl(ctrl));
  }

  /** Command1 "النتيجة" (:1885-2204) — refuses an empty query with
   *  "يجب طرح السؤال اولا....." and otherwise ANDs every non-empty criterion. */
  search(): void {
    if (!this.hasAnyCriteria()) {
      this.snackBar.open(this.translate.instant('SEARCH_SCREEN.NO_CRITERIA'), '', { duration: 4000 });
      return;
    }
    this.lockFilledFields();
    this.isLoading.set(true);
    this.hasSearched.set(true);
    const v = this.form.getRawValue();

    const request: SearchScreenRequest = {
      searchMode: this.searchMode(),
      titleWord: v.titleWord || undefined,
      digitAssetNo: v.digitAssetNo || undefined,
      oldArchiveNo: v.oldArchiveNo || undefined,
      abstractWord: v.abstractWord || undefined,
      fullText: v.fullText || undefined,
      pageNo: v.pageNo || undefined,
      language: v.language || undefined,
      articleType: v.articleType || undefined,
      documentType: v.documentType || undefined,
      dataEntryOperator: v.dataEntryOperator || undefined,
      dateFrom: v.dateFrom ? new Date(v.dateFrom).toISOString() : undefined,
      dateTo: v.dateTo ? new Date(v.dateTo).toISOString() : undefined,
      entryDateFrom: v.entryDateFrom ? new Date(v.entryDateFrom).toISOString() : undefined,
      entryDateTo: v.entryDateTo ? new Date(v.entryDateTo).toISOString() : undefined,
      periodicalNo: this.numOf(this.codeOf(this.periodicalControl.value, 'perNo')),
      responsiblePersonNo: this.numOf(this.codeOf(this.responsiblePersonControl.value, 'id')),
      subjectDescriptorCode: this.codeOf(this.subjectDescriptorControl.value, 'code'),
      relatedDescriptorCode: this.codeOf(this.relatedDescriptorControl.value, 'code'),
      narrowerDescriptorCode: this.codeOf(this.narrowerDescriptorControl.value, 'code'),
      additionalFileCode: this.codeOf(this.additionalFileControl.value, 'formNo'),
      geoLocationCode: this.codeOf(this.geoLocationControl.value, 'formNo'),
      photoPlaceCode: this.codeOf(this.photoPlaceControl.value, 'formNo')
    };

    this.searchScreenService.search(request, this.pageIndex(), this.pageSize()).subscribe({
      next: r => {
        this.results.set(r.data.content);
        this.totalElements.set(r.data.totalElements);
        this.isLoading.set(false);
        this.focusedAppNo.set(null);
      },
      error: err => {
        this.isLoading.set(false);
        const msg = err?.error?.message || this.translate.instant('SEARCH_SCREEN.NO_CRITERIA');
        this.snackBar.open(msg, '', { duration: 4000 });
      }
    });
  }

  private numOf(s: string | undefined): number | undefined {
    if (s == null || s === '') return undefined;
    const n = Number(s);
    return Number.isNaN(n) ? undefined : n;
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.search(); }

  /** Command4 "بحث جديد" (:2318-2419) — re-enables and clears all 22 fields; legacy resets
   *  the grid to an empty recordset rather than leaving the previous results on screen. */
  clearFilter(): void {
    this.form.enable();
    this.form.reset({
      titleWord: '', digitAssetNo: '', oldArchiveNo: '', abstractWord: '', fullText: '', pageNo: '',
      language: '', articleType: '', documentType: '', dataEntryOperator: '',
      dateFrom: '', dateTo: '', entryDateFrom: '', entryDateTo: ''
    });
    this.lookupControls().forEach(ctrl => { ctrl.enable(); ctrl.setValue(''); });
    this.pageIndex.set(0);
    this.results.set([]);
    this.totalElements.set(0);
    this.hasSearched.set(false);
    this.focusedAppNo.set(null);
  }

  /** Command3 "عدد المقالات" (:2302-2316) — MsgBox of the CURRENT result set's record
   *  count; does not re-query. "لايوجد مقالات لهذا السؤال" when nothing has matched. */
  countArticles(): void {
    const count = this.totalElements();
    if (!this.hasSearched() || count === 0) {
      this.snackBar.open(this.translate.instant('SEARCH_SCREEN.ARTICLE_COUNT_EMPTY'), '', { duration: 4000 });
    } else {
      this.snackBar.open(this.translate.instant('SEARCH_SCREEN.RESULT_COUNT', { count }), '', { duration: 4000 });
    }
  }

  /** Command2 "خروج" (:2298-2300) — legacy: Unload user_interface. Same destination
   *  convention already established for the other rebuilt legacy screens' exit button. */
  onExit(): void { this.router.navigate(['/catalogue']); }

  /**
   * Command8 "طباعة الملف" (:2425-2444) — legacy: `jad_print` is chosen from `box_company`
   * (:2427-2437), then `form_report.WindowState = 2; form_report.Show` opens a maximized
   * Crystal Reports viewer (CRViewer9) bound to one of Report1..Report13 (from_report.frm).
   *
   * The migrated app has a genuine equivalent of that viewer: a JasperReports PDF pipeline
   * at /api/reports/generate/{reportType} (ReportGeneratorService — its own header comment
   * calls it out as "the 15 legacy Crystal Reports equivalents"), fed by report templates
   * stored in the migrated `bnkout` table (ReportTemplateEntity), with a full browsing/viewing
   * UI already built at /reports (ReportsShellComponent: template list + viewer + execution).
   *
   * What is NOT reproducible: legacy's box_company → jad_print mapping (:2427-2437) selects
   * ONE specific report number automatically. box_company is a runtime/session config value
   * set elsewhere in the legacy deployment (no .bas constant, no config table migrated it —
   * confirmed absent from the backend by search) — there is no way to derive which of the 13
   * report numbers this screen would have shown without guessing. So this button opens the
   * real report viewer (the architectural equivalent of form_report opening) rather than
   * auto-launching a specific, unprovable report number, and rather than the CSV-export
   * placeholder this used to fall back to (that was not behavior parity and has been removed).
   */
  openReports(): void {
    window.open('/reports', '_blank');
  }

  openRecord(row: ArchiveSearchResult): void {
    this.router.navigate(['/catalogue', row.appNo]);
  }

  private startLogRequest(rows: ArchiveSearchResult[]): void {
    this.logRequestRows.set(rows);
    this.logRequestForm.reset({ person: '', cote: '', permit: '', subject: rows.length === 1 ? rows[0].activeTitleAr : '' });
  }

  cancelLogRequest(): void { this.logRequestRows.set([]); }

  submitLogRequest(): void {
    const rows = this.logRequestRows();
    if (rows.length === 0) return;
    const v = this.logRequestForm.getRawValue();
    if (!v.person) { this.logRequestForm.markAllAsTouched(); return; }
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
        this.resetChoicesAfterLogging(rows);
      }
      // No error handler: on failure the panel stays open with what the user entered, and
      // dig_choice is left untouched — matching "do not reset if submission fails" (:498-527).
    });
  }
}
