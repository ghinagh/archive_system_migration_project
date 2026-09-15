import { Component, ElementRef, ViewChild, ViewChildren, QueryList, signal, inject, computed, effect, OnInit, DestroyRef } from '@angular/core';
import { FormBuilder, FormControl } from '@angular/forms';
import { takeUntilDestroyed, toSignal } from '@angular/core/rxjs-interop';
import { debounceTime, distinctUntilChanged, switchMap, of, catchError, map, timer, takeWhile, Observable, tap } from 'rxjs';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatAutocompleteTrigger } from '@angular/material/autocomplete';
import { PageEvent } from '@angular/material/paginator';
import { TranslateService } from '@ngx-translate/core';
import { ArchiveSearchService } from '../services/archive-search.service';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { ArchiveSearchRequest, ArchiveSearchResult } from '../models/archive-search.model';
import { DigitDemand, DeliveryJobStatus } from '../../digitization/models/digitization.model';
import { SearchService } from '../../../core/services/search.service';
import { SearchResult } from '../../../core/models/search.models';
import { AutocompleteService, AuthorOption } from '../../../core/services/autocomplete.service';
import { SubjectsService } from '../../subjects/services/subjects.service';
import { MacnzSubject, CodingEntry } from '../../subjects/models/subject.model';
import { SitesService } from '../../sites/services/sites.service';
import { Position } from '../../sites/models/sites.model';

/** Legacy CODING.SUB_CODE domain prefix confirmed by ArchiveSearchService's join
 *  (CONCAT('24', d.type1)) for m_dig_typ1 "نوع الوثيقة". No such join exists for
 *  m_mch_typ "نوع المقالة" (articleType), so that field's suggestions aren't domain-filtered. */
const DOCUMENT_TYPE_CODING_PREFIX = '24';

/** DIGIT.DIG_TYP1 values that live under the picture root instead of the tape volumes —
 *  legacy datagrid1_DblClick's routing table (:4858-4880). 04 and anything else is video. */
const NON_VIDEO_ASSET_CLASSES = new Set(['01', '02', '03', '05']);
/** The one non-video class legacy plays rather than opening externally. */
const AUDIO_ASSET_CLASS = '02';

/**
 * Legacy Command15_Click:3520 / :3612 test `m_len_mch < 400`. Note the MsgBox beside that test
 * says 500 — an inconsistency in the original source. 400 is authoritative here because it is
 * the value the code actually enforced.
 */
const MAX_SCENE_SECONDS = 400;

/** How often the running batch is polled for progress. */
const BATCH_POLL_INTERVAL_MS = 1000;

function codeOf<T extends object>(value: string | T | null | undefined, key: keyof T): string | undefined {
  if (value == null) return undefined;
  if (typeof value === 'string') return value.trim() || undefined;
  const raw = (value as Record<keyof T, unknown>)[key];
  return raw == null ? undefined : String(raw);
}

/**
 * Legacy Command15_Click:3488-3505 replaces each of these with a space before storing the
 * scene description, because that description later becomes an output filename in the
 * delivery pipelines. The list is legacy's verbatim, including the Arabic question mark.
 */
const FILENAME_UNSAFE = /[:\n\r"/?<>*\\|؟]/g;

export function sanitiseSceneDescription(value: string): string {
  return value.replace(FILENAME_UNSAFE, ' ');
}

/** Local calendar date as yyyy-MM-dd, for the two <input type="date"> demand filters. */
function todayIso(): string {
  const d = new Date();
  return [d.getFullYear(), d.getMonth() + 1, d.getDate()]
    .map((n, i) => (i === 0 ? String(n) : String(n).padStart(2, '0')))
    .join('-');
}

/** Widens a yyyy-MM-dd box to the instant bounding its local day, so dmd_dte comparisons
 *  cover the whole date the way legacy's date-only dd/mm/yyyy masks did. */
function dayStartIso(date: string): string | undefined {
  return date ? new Date(`${date}T00:00:00`).toISOString() : undefined;
}

function dayEndIso(date: string): string | undefined {
  return date ? new Date(`${date}T23:59:59.999`).toISOString() : undefined;
}

/**
 * Legacy `Mid(m_mch_typ.BoundText, 3, 3)` (USER_INTERFACE1.frm:2848) and
 * `Mid(m_dig_typ1.BoundText, 3, 2)` (:2876). Both DataCombos bind CODING.SUB_CODE, whose
 * value carries a 2-character domain prefix that must never reach ARTICLE.ART_SUB_TY /
 * DIGIT.DIG_TYP1 — those columns store the bare tail. `Mid` is 1-based, so position 3 is
 * index 2 here. Codes that are already short (a hand-typed bare tail) pass through
 * untouched, matching legacy's tolerance for an empty/short BoundText.
 */
function stripCodingPrefix(code: string | undefined, keep: number): string | undefined {
  if (!code) return undefined;
  const trimmed = code.trim();
  if (!trimmed) return undefined;
  return trimmed.length > 2 ? trimmed.substring(2, 2 + keep) : trimmed;
}

/**
 * Migrated equivalent of the legacy USER_INTERFACE1.frm ("برنامج الارشيف") broadcast
 * archive search cockpit: multi-criteria search (Frame1) with search-mode toggle and the
 * two independent FILE_ADD lookups (m_file_no / m_file_no1), in/out scene selection with
 * re-seek and jog controls against the playing clip (Frame12), an F6-equivalent
 * abstract/remark viewer (Frame3), and a persisted material-request queue (DataGrid2 /
 * view_demand) with an unfulfilled-only filter (Check2).
 *
 * Both delivery actions are live: Command5 "ارسل الى EDLC" (DV PAL transcode + poster frame +
 * EDLC hand-off) and Command14 "تنفيد" (stream-copy clips). Each starts a server-side job and
 * polls it, because legacy blocked its whole window on the transcode and an HTTP request
 * cannot. The legacy "save EDL"/"save EDL & Vegas" exports (Command9/Command24) were confirmed
 * dead code — both carry `Visible = 0` in the form design and are unreachable — and are
 * intentionally not reproduced.
 */
@Component({
  standalone: false,
  selector: 'app-archive-search-cockpit',
  templateUrl: './archive-search-cockpit.component.html',
  styleUrls: ['./archive-search-cockpit.component.scss']
})
export class ArchiveSearchCockpitComponent implements OnInit {

  private fb = inject(FormBuilder);
  private archiveSearchService = inject(ArchiveSearchService);
  private digitizationService = inject(DigitizationService);
  private searchService = inject(SearchService);
  private autocompleteService = inject(AutocompleteService);
  private subjectsService = inject(SubjectsService);
  private sitesService = inject(SitesService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private destroyRef = inject(DestroyRef);

  @ViewChild('videoEl') videoRef?: ElementRef<HTMLVideoElement>;
  @ViewChild('audioEl') audioRef?: ElementRef<HTMLAudioElement>;
  @ViewChild('articleTypeAuto', { read: MatAutocompleteTrigger }) articleTypeTrigger?: MatAutocompleteTrigger;
  @ViewChild('documentTypeAuto', { read: MatAutocompleteTrigger }) documentTypeTrigger?: MatAutocompleteTrigger;
  @ViewChild('responsiblePersonAuto', { read: MatAutocompleteTrigger }) responsiblePersonTrigger?: MatAutocompleteTrigger;

  /** In/out marking and jog act on whichever element is live: legacy marks scenes on audio
   *  (DIG_TYP1 = 02) through the very same player controls it uses for video. */
  private get mediaEl(): HTMLMediaElement | undefined {
    return this.videoRef?.nativeElement ?? this.audioRef?.nativeElement;
  }

  /** True once something is loaded in either player — gates the mark/jog controls. */
  hasPlayableMedia = computed(() =>
    this.videoBlobUrl() != null && this.mediaMode() !== 'document');

  searchExpanded = signal(true);
  form = this.fb.group({
    word: [''],
    /** Legacy Option1/Option2 "البحث بداية الاسم" / "البحث كلمة معينة". */
    searchMode: ['CONTAINS' as 'STARTS_WITH' | 'CONTAINS'],
    dateFrom: [''],
    dateTo: [''],
    fullText: ['']
  });

  /** Scenes selection form (اختیار المشاهد section) */
  scenesForm = this.fb.group({
    scenesDateFrom: [''],
    scenesDateTo: [''],
    sceneNewTitle: [''],
    incompleteRequestsOnly: [false]
  });

  /** Track selected scene from results for scenes section */
  selectedSceneForScenes = signal<ArchiveSearchResult | null>(null);

  hasSelectedScene = computed(() => this.selectedSceneForScenes() != null);
  canAddScene = computed(() => this.selectedSceneForScenes() != null && this.scenesForm.get('sceneNewTitle')?.value?.trim());

  // --- Lookup-assisted fields (legacy DBList1/DBList2 live-narrowing popups for
  // m_file_no/m_file_no1/m_file_geo/m_desc_no/m_nar_desc, and the native bound DataCombo
  // dropdowns for m_res_no/m_mch_typ/m_dig_typ1). Each control's value is either the raw
  // typed text (before a suggestion is picked) or the selected option object — codeOf()
  // extracts the actual filter value either way, so pasting a known code still works
  // without requiring a dropdown pick, same as legacy. ---

  generalIndexNoControl = new FormControl<string | SearchResult | null>('');
  generalIndexNo2Control = new FormControl<string | SearchResult | null>('');
  geoLocationControl = new FormControl<string | SearchResult | null>('');
  responsiblePersonControl = new FormControl<string | AuthorOption | null>('');
  private responsiblePersonValue = toSignal(this.responsiblePersonControl.valueChanges.pipe(
    tap(v => console.log('[DEBUG] responsiblePersonControl value changed:', v))
  ), { initialValue: this.responsiblePersonControl.value });
  descriptorControl = new FormControl<string | MacnzSubject | null>('');
  narrowerDescriptorControl = new FormControl<string | MacnzSubject | null>('');
  articleTypeControl = new FormControl<string | CodingEntry | null>('');
  documentTypeControl = new FormControl<string | CodingEntry | null>('');
  descriptorNumberControl = new FormControl<string | SearchResult | null>('');
  narrativeDescriptorControl = new FormControl<string | SearchResult | null>('');
  textSearchControl = new FormControl<string>('');
  demandDescriptionControl = new FormControl<string>('');

  generalIndexNoOptions = signal<SearchResult[]>([]);
  generalIndexNo2Options = signal<SearchResult[]>([]);
  geoLocationOptions = signal<SearchResult[]>([]);
  descriptorNumberOptions = signal<SearchResult[]>([]);
  narrativeDescriptorOptions = signal<SearchResult[]>([]);
  private responsiblePersonAll = signal<AuthorOption[]>([]);
  responsiblePersonOptions = computed(() =>
    this.filterResponsiblePersonOptions(this.responsiblePersonValue())
  );

  private macnzOptions = signal<MacnzSubject[]>([]);
  private codingOptions = signal<CodingEntry[]>([]);

  /** Legacy m_typ_serh (Option1/Option2, USER_INTERFACE1.frm:6434-6447). Its ONLY legacy
   *  consumers are the lookup popups — serh_allform (prefix) vs serh_wrdform2 (contains) for
   *  DBList1 (:5911-5921), and serh_macnz vs serh_wrdmacnz3 for DBList2 (:6026-6042). The main
   *  title/abstract match at :3033 is unconditionally LIKE '%token%'. */
  private searchModeValue = toSignal(this.form.controls.searchMode.valueChanges,
    { initialValue: this.form.controls.searchMode.value });

  private descriptorValue = toSignal(this.descriptorControl.valueChanges, { initialValue: this.descriptorControl.value });
  private narrowerDescriptorValue = toSignal(this.narrowerDescriptorControl.valueChanges, { initialValue: this.narrowerDescriptorControl.value });
  private articleTypeValue = toSignal(this.articleTypeControl.valueChanges.pipe(
    tap(v => console.log('[DEBUG] articleTypeControl value changed:', v))
  ), { initialValue: this.articleTypeControl.value });
  private documentTypeValue = toSignal(this.documentTypeControl.valueChanges.pipe(
    tap(v => console.log('[DEBUG] documentTypeControl value changed:', v))
  ), { initialValue: this.documentTypeControl.value });

  descriptorOptions = computed(() => this.filterMacnz(this.descriptorValue()));
  narrowerDescriptorOptions = computed(() => this.filterMacnz(this.narrowerDescriptorValue()));
  // Legacy DataCombo dropdowns: show ALL initially, filter as user types
  articleTypeOptions = computed(() => this.filterArticleTypeOptions(this.articleTypeValue()));
  documentTypeOptions = computed(() => this.filterDocumentTypeOptions(this.documentTypeValue()));

  displaySearchResult = (value: string | SearchResult | null): string =>
    typeof value === 'string' ? value : (value?.title ?? '');

  displayAuthor = (value: string | AuthorOption | null): string =>
    typeof value === 'string' ? value : (value?.name ?? '');

  displayMacnz = (value: string | MacnzSubject | null): string =>
    typeof value === 'string' ? value : (value?.description ?? '');

  displayCoding = (value: string | CodingEntry | null): string =>
    typeof value === 'string' ? value : (value?.description ?? '');

  /** Filter options: show ALL when empty (legacy DataCombo behavior) */
  filterArticleTypeOptions = (value: string | CodingEntry | null): CodingEntry[] => {
    const term = typeof value === 'string' ? value.toLowerCase().trim() : '';
    const allOptions = this.codingOptions();
    console.log('[DEBUG] filterArticleTypeOptions:', { value, term, totalOptions: allOptions.length, firstFew: allOptions.slice(0, 3) });
    if (!term) return allOptions.slice(0, 100);
    const filtered = allOptions
      .filter(o => o.description?.toLowerCase().includes(term) || o.code?.toLowerCase().includes(term))
      .slice(0, 25);
    console.log('[DEBUG] filterArticleTypeOptions filtered:', filtered.length);
    return filtered;
  };

  filterDocumentTypeOptions = (value: string | CodingEntry | null): CodingEntry[] => {
    const term = typeof value === 'string' ? value.toLowerCase().trim() : '';
    const filtered = this.codingOptions().filter(o => o.code?.startsWith('24'));
    if (!term) return filtered.slice(0, 100);
    return filtered
      .filter(o => o.description?.toLowerCase().includes(term) || o.code?.toLowerCase().includes(term))
      .slice(0, 25);
  };

  filterResponsiblePersonOptions = (value: string | AuthorOption | null): AuthorOption[] => {
    const term = typeof value === 'string' ? value.toLowerCase().trim() : '';
    if (!term) return this.responsiblePersonAll().slice(0, 100);
    return this.responsiblePersonAll()
      .filter(o => o.name?.toLowerCase().includes(term))
      .slice(0, 25);
  };

  ngOnInit(): void {
    // Legacy Form_Load populates DataGrid2 before any user interaction — see loadScenes().
    this.loadScenes();

    this.subjectsService.getAllSubjects().pipe(
      catchError(err => {
        console.error('Error loading subjects:', err);
        return of({ data: [] } as any);
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(r => this.macnzOptions.set(r?.data ?? []));

    // Load article/document type coding from new dedicated endpoints
    this.archiveSearchService.getArticleTypes().pipe(
      catchError(err => {
        console.error('[ERROR] Error loading article types:', err);
        return of({ data: [] } as any);
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(r => {
      const codingEntries = (r?.data ?? []).map((d: any) => ({
        code: d.code,
        description: d.description,
        level: ''
      }));
      this.codingOptions.set(codingEntries);
    });

    // Load document types from dedicated endpoint
    this.archiveSearchService.getDocumentTypes().pipe(
      catchError(err => {
        console.error('[ERROR] Error loading document types:', err);
        return of({ data: [] } as any);
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(r => {
      const codingEntries = (r?.data ?? []).map((d: any) => ({
        code: d.code,
        description: d.description,
        level: ''
      }));
      // Merge with existing coding options (article types loaded above)
      const merged = [...this.codingOptions(), ...codingEntries];
      this.codingOptions.set(merged);
    });

    // Load responsible persons using the working searchAuthors endpoint
    // (legacy screen uses this same endpoint successfully)
    console.log('[DEBUG] ngOnInit: calling searchAuthors with wildcard to load all authors');
    this.autocompleteService.searchAuthors('%').pipe(
      catchError(err => {
        console.error('[ERROR] Error loading responsible persons:', err);
        return of({ data: [] } as any);
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(r => {
      console.log('[DEBUG] searchAuthors response:', r);
      const authors = (r?.data ?? []) as AuthorOption[];
      console.log('[DEBUG] loaded authors:', authors.length, 'items');
      this.responsiblePersonAll.set(authors);
      console.log('[DEBUG] responsiblePersonAll signal set to:', this.responsiblePersonAll());
    });

    this.wireCatalogueLookup(this.generalIndexNoControl, this.generalIndexNoOptions);
    this.wireCatalogueLookup(this.generalIndexNo2Control, this.generalIndexNo2Options);
    this.wireCatalogueLookup(this.geoLocationControl, this.geoLocationOptions);
    this.wireCatalogueLookup(this.descriptorNumberControl, this.descriptorNumberOptions);
    this.wireCatalogueLookup(this.narrativeDescriptorControl, this.narrativeDescriptorOptions);
  }


  /** Legacy DBList1 popup. m_typ_serh selects serh_allform (prefix) or serh_wrdform2
   *  (contains); the shared catalogue endpoint always does a contains match, so prefix mode
   *  is applied as a narrowing pass over what comes back — same visible result set without
   *  changing an endpoint other screens depend on. */
  private wireCatalogueLookup(control: FormControl<string | SearchResult | null>, options: ReturnType<typeof signal<SearchResult[]>>): void {
    control.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(term => {
        const q = typeof term === 'string' ? term.trim() : '';
        if (q.length < 2) { options.set([]); return of(null); }
        return this.searchService.search(q).pipe(
          catchError(() => of(null)),
          map(r => ({ response: r, term: q.toLowerCase() }))
        );
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(payload => {
      if (!payload) { options.set([]); return; }
      const rows = payload.response?.data ?? [];
      options.set(this.searchModeValue() === 'STARTS_WITH'
        ? rows.filter(o => this.matchesMode(o.title, payload.term))
        : rows);
    });
  }

  /** Legacy serh_allform / serh_macnz (prefix) vs serh_wrdform2 / serh_wrdmacnz3 (contains). */
  private matchesMode(candidate: string | null | undefined, term: string): boolean {
    if (!candidate) return false;
    const c = candidate.toLowerCase();
    return this.searchModeValue() === 'STARTS_WITH' ? c.startsWith(term) : c.includes(term);
  }

  private filterMacnz(value: string | MacnzSubject | null | undefined): MacnzSubject[] {
    const term = (typeof value === 'string' ? value : value?.description ?? '').trim().toLowerCase();
    if (term.length < 1) return [];
    return this.macnzOptions().filter(o => this.matchesMode(o.description, term)).slice(0, 25);
  }

  private filterCoding(value: string | CodingEntry | null | undefined, domainPrefix: string | null): CodingEntry[] {
    const term = (typeof value === 'string' ? value : value?.description ?? '').trim().toLowerCase();
    if (term.length < 1) return [];
    return this.codingOptions()
      .filter(o => (!domainPrefix || o.code?.startsWith(domainPrefix)) && this.matchesMode(o.description, term))
      .slice(0, 25);
  }

  /** Get ALL coding entries filtered by domain prefix (legacy DataCombo dropdown behavior) */
  private getAllCodingByDomain(domainPrefix: string | null): CodingEntry[] {
    return this.codingOptions()
      .filter(o => !domainPrefix || o.code?.startsWith(domainPrefix))
      .slice(0, 100); // Show up to 100 options in dropdown
  }

  /** Handle focus on article type field - ensure dropdown opens with all options */
  onArticleTypeFocus(): void {
    this.articleTypeTrigger?.openPanel();
  }

  /** Handle focus on document type field - ensure dropdown opens with all options */
  onDocumentTypeFocus(): void {
    this.documentTypeTrigger?.openPanel();
  }

  /** Handle focus on responsible person field - mat-autocomplete opens automatically on focus/input */
  onResponsiblePersonFocus(): void {
    console.log('[DEBUG] Responsible person field focused — autocomplete will open automatically');
  }

  /**
   * Legacy DataGrid1 (:1689-1917) carries six separate timecode columns — dig_o/dig_m/dig_s
   * "من س/د/ث" and their dig_*1 "الى" counterparts — plus dig_typ "نوع الملف". The two triples
   * are rendered here as one composite column each, which preserves every value without
   * adding six narrow numeric columns to an already wide responsive table. The remaining two
   * legacy columns (dig_typ1, dig_choice) were captioned with their raw column names and are
   * internal, so they stay off the grid.
   */
  resultColumns = ['responsiblePersonName', 'appNo', 'activeTitleAr', 'additionalTitle', 'docTypeDescription', 'articleDate', 'pageNo', 'periodicalName', 'digitNo', 'fileType', 'durationHours', 'durationMinutes', 'durationSeconds', 'durationHours1', 'durationMinutes1', 'durationSeconds1', 'actions'];

  /** Composite of a dig_o/dig_m/dig_s triple, as HH:MM:SS. */
  formatTimecode(hours: number | null, minutes: number | null, seconds: number | null): string {
    return this.formatDuration(this.toSeconds(hours, minutes, seconds));
  }
  results = signal<ArchiveSearchResult[]>([]);
  totalResults = signal(0);
  resultsPageIndex = signal(0);
  resultsPageSize = signal(10);
  isSearching = signal(false);
  hasSearched = signal(false);

  selectedResult = signal<ArchiveSearchResult | null>(null);
  videoBlobUrl = signal<string | null>(null);
  isLoadingVideo = signal(false);
  videoUnavailable = signal(false);

  /** Which of legacy's asset presentations the current record needs — see selectResult(). */
  mediaMode = signal<'video' | 'audio' | 'document'>('video');
  /** Documents that are images render in place; anything else gets an "open" button. */
  assetIsImage = signal(false);

  markedIn = signal<number | null>(null);
  markedOut = signal<number | null>(null);
  sceneDescription = signal('');
  /** Legacy m_step — jog/step size in seconds for Command10/Command11. */
  jogStep = signal(1);

  /** Legacy WindowsMediaPlayer1 control state */
  mediaStatusText = signal('Ready');
  playerMuted = signal(false);
  playerVolume = signal(100);
  // Connect playerVolume signal (0-100) to mediaEl.volume (0-1) — must be field initializer, not ngOnInit
  private volumeEffect = effect(() => {
    const el = this.mediaEl;
    if (el) el.volume = this.playerVolume() / 100;
  });

  currentPageNo = signal(1);
  playerCollapsed = signal(false);

  currentDemandNo = signal<string | null>(null);
  sceneColumns = ['userName', 'checked', 'demandNo', 'serial', 'description', 'machineStock', 'programName', 'outputSize', 'time1', 'catalogueTitle', 'path', 'date'];

  /** DataGrid2 columns (legacy VB6) mapped to Angular mat-table displayedColumns */
  displayedColumns = ['checked', 'demandNo', 'serial', 'description', 'machineStock', 'time1', 'catalogueTitle', 'date'];

  scenes = signal<DigitDemand[]>([]);
  isLoadingScenes = signal(false);

  /** Legacy DataGrid2_DblClick selection — stores the selected scene row for playback context */
  selectedSceneRow = signal<DigitDemand | null>(null);

  /** Legacy Check2 "الطلبات الغير منجزة". Form_Load:5602 sets Check2.value = 1, so the queue
   *  opens showing only unfulfilled requests. Applied server-side inside tmp_demand<user_no>,
   *  not over an already-fetched page. */
  unfulfilledOnly = signal(true);

  /** Legacy M_dmd_dte / M_dmd_dte1 (:944, :968), both defaulted to today in Form_Load
   *  (:5537-5538) and fed straight into dmd_dte >= / <= (:5563-5588). */
  demandDateFrom = signal<string>(todayIso());
  demandDateTo = signal<string>(todayIso());

  /** Legacy DataGrid2's "الاختيار" column (:2043-2044) is bound to dmd_chek, a persisted
   *  column — not a transient UI selection. 1 = queued/selected, 2 = fulfilled, 0 = skipped.
   *  Every batch action gates on dmd_chek = 1. */
  selectedSceneIds = computed(() => this.scenes().filter(s => s.checked === 1).map(s => s.id));
  hasSceneSelection = computed(() => this.selectedSceneIds().length > 0);
  /** Fulfilled rows are frozen — consistent with the delete guard and the batch gates. */
  private selectableScenes = computed(() => this.scenes().filter(s => s.checked !== 2));
  allScenesSelected = computed(() => {
    const selectable = this.selectableScenes();
    return selectable.length > 0 && selectable.every(s => s.checked === 1);
  });

  isSceneSelected(row: DigitDemand): boolean {
    return row.checked === 1;
  }

  isSceneFulfilled(row: DigitDemand): boolean {
    return row.checked === 2;
  }

  toggleSceneSelected(row: DigitDemand): void {
    if (this.isSceneFulfilled(row)) return;
    this.writeChecked([row.id], row.checked === 1 ? 0 : 1);
  }

  toggleSelectAllScenes(): void {
    const ids = this.selectableScenes().map(r => r.id);
    if (ids.length === 0) return;
    this.writeChecked(ids, this.allScenesSelected() ? 0 : 1);
  }

  /** Persists dmd_chek so the selection survives a reload, unlike a client-side Set. */
  private writeChecked(ids: number[], checked: number): void {
    this.digitizationService.setDemandsChecked(ids, checked).subscribe({
      next: () => this.loadScenes()
    });
  }

  /** Legacy m_tit / m_tit1 — the running batch's per-item status line (W13). */
  batchJob = signal<DeliveryJobStatus | null>(null);
  batchRunning = signal(false);
  batchProgress = computed(() => {
    const job = this.batchJob();
    if (!job || job.total === 0) return 0;
    return Math.round((job.processed / job.total) * 100);
  });

  totalSceneDuration = computed(() => {
    const seconds = this.scenes().reduce((sum, s) => sum + (s.outputSize ?? 0), 0);
    return this.formatDuration(seconds);
  });

  /** Legacy F6 — abstract/title viewer popup (Frame3), with a beneficiary remark field. */
  abstractViewerOpen = signal(false);
  abstractRemark = signal('');
  isSavingRemark = signal(false);

  search(): void {
    this.isSearching.set(true);
    this.hasSearched.set(true);
    const v = this.form.value;
    const generalIndexNo = codeOf<SearchResult>(this.generalIndexNoControl.value, 'appNo');
    const generalIndexNo2 = codeOf<SearchResult>(this.generalIndexNo2Control.value, 'appNo');
    const geoLocation = codeOf<SearchResult>(this.geoLocationControl.value, 'appNo');
    const descriptorNumber = codeOf<SearchResult>(this.descriptorNumberControl.value, 'appNo');
    const narrativeDescriptor = codeOf<SearchResult>(this.narrativeDescriptorControl.value, 'appNo');
    const responsiblePerson = codeOf<AuthorOption>(this.responsiblePersonControl.value, 'id');
    const request: ArchiveSearchRequest = {
      word: v.word || undefined,
      searchMode: v.searchMode || undefined,
      dateFrom: v.dateFrom ? new Date(v.dateFrom).toISOString() : undefined,
      dateTo: v.dateTo ? new Date(v.dateTo).toISOString() : undefined,
      // Legacy strips the CODING domain prefix before comparing — see stripCodingPrefix().
      articleType: stripCodingPrefix(codeOf<CodingEntry>(this.articleTypeControl.value, 'code'), 3),
      documentType: stripCodingPrefix(codeOf<CodingEntry>(this.documentTypeControl.value, 'code'), 2),
      responsiblePersonNo: responsiblePerson ? Number(responsiblePerson) : undefined,
      generalIndexNo,
      generalIndexNo2,
      geoLocation,
      descriptorNumber,
      narrativeDescriptor,
      textSearch: this.textSearchControl.value || undefined,
      descriptorNo: codeOf<MacnzSubject>(this.descriptorControl.value, 'code'),
      narrowerDescriptorNo: codeOf<MacnzSubject>(this.narrowerDescriptorControl.value, 'code'),
      fullText: v.fullText || undefined
    };

    this.archiveSearchService.search(request, this.resultsPageIndex(), this.resultsPageSize()).subscribe({
      next: r => {
        this.results.set(r.data.content);
        this.totalResults.set(r.data.totalElements);
        this.isSearching.set(false);
      },
      error: () => this.isSearching.set(false)
    });
  }

  onResultsPage(e: PageEvent): void {
    this.resultsPageIndex.set(e.pageIndex);
    this.resultsPageSize.set(e.pageSize);
    this.search();
  }

  clearSearch(): void {
    this.form.reset({ word: '', searchMode: 'CONTAINS', dateFrom: '', dateTo: '', fullText: '' });
    this.generalIndexNoControl.setValue('');
    this.generalIndexNo2Control.setValue('');
    this.geoLocationControl.setValue('');
    this.responsiblePersonControl.setValue('');
    this.descriptorControl.setValue('');
    this.narrowerDescriptorControl.setValue('');
    this.articleTypeControl.setValue('');
    this.documentTypeControl.setValue('');
    this.descriptorNumberControl.setValue('');
    this.narrativeDescriptorControl.setValue('');
    this.textSearchControl.setValue('');
    this.results.set([]);
    this.totalResults.set(0);
    this.hasSearched.set(false);
  }

  newSearch(): void {
    this.clearSearch();
  }

  exportResults(): void {
    if (this.results().length === 0) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.NO_RESULTS_TO_EXPORT'), '', { duration: 3000 });
      return;
    }
    const csv = this.generateCsv(this.results());
    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    link.setAttribute('href', url);
    link.setAttribute('download', `archive-search-${new Date().toISOString().split('T')[0]}.csv`);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  private generateCsv(results: ArchiveSearchResult[]): string {
    const headers = ['رقم التسجيل', 'العنوان', 'العنوان الإضافي', 'التاريخ', 'الصفحة', 'نوع الوثيقة', 'الدورية', 'الرقم الرقمي', 'المسؤول', 'الملف', 'المدة من', 'المدة إلى', 'نوع الملف'];
    const rows = results.map(r => [
      r.appNo, r.activeTitleAr, r.additionalTitle, r.articleDate, r.pageNo,
      r.docTypeDescription, r.periodicalName, r.digitNo, r.responsiblePersonName,
      r.machineStock, this.formatTimecode(r.durationHours, r.durationMinutes, r.durationSeconds),
      this.formatTimecode(r.durationHours1, r.durationMinutes1, r.durationSeconds1), r.documentType
    ]);
    const all = [headers, ...rows];
    return all.map(row => row.map(cell => `"${(cell ?? '').toString().replace(/"/g, '""')}"`).join(',')).join('\n');
  }

  showStatistics(): void {
    const total = this.totalResults();
    const displayed = this.results().length;
    const message = this.translate.instant('ARCHIVE_SEARCH.STATISTICS', { total, displayed });
    this.snackBar.open(message, '', { duration: 5000 });
  }

  /**
   * Legacy datagrid1_DblClick (:4858-4900) branches on DIG_TYP1 before it touches the player:
   * 01/03/05 (scan / photos / private) resolve under the picture root and hand off to OpenDoc,
   * 02 (waves) plays through the same player as audio, and 04 or anything else is video from
   * low_stock_path(). The previous implementation always fetched video, leaving four of the
   * five asset classes — including the صوتي half of this screen's name — unreachable.
   */
  selectResult(result: ArchiveSearchResult): void {
    this.selectedResult.set(result);
    this.selectedSceneForScenes.set(result);
    this.sceneDescription.set(this.defaultSceneDescription(result));
    this.videoUnavailable.set(false);
    this.abstractViewerOpen.set(false);
    this.abstractRemark.set('');
    this.releaseVideo();
    this.assetIsImage.set(false);
    // Legacy seeds deb_tm/fin_tm from the record's stored range at load time, so the
    // from/to jumps are live before any manual marking (W8).
    this.markedIn.set(this.toSeconds(result.durationHours, result.durationMinutes, result.durationSeconds));
    this.markedOut.set(this.toSeconds(result.durationHours1, result.durationMinutes1, result.durationSeconds1));

    const type1 = result.documentType1?.trim() ?? '';
    if (NON_VIDEO_ASSET_CLASSES.has(type1)) {
      this.loadNonVideoAsset(result, type1);
      return;
    }

    this.mediaMode.set('video');
    if (!result.machineStock) {
      this.videoUnavailable.set(true);
      return;
    }

    // Preview always streams the LOW-res proxy with the record's own extension — legacy
    // datagrid1_DblClick:4897 calls low_stock_path(), never high_stock_path().
    this.isLoadingVideo.set(true);
    this.archiveSearchService.downloadMedia(result.machineStock, 'LOW', result.documentType).subscribe({
      next: blob => {
        this.videoBlobUrl.set(URL.createObjectURL(blob));
        this.isLoadingVideo.set(false);
      },
      error: () => {
        this.videoUnavailable.set(true);
        this.isLoadingVideo.set(false);
      }
    });
  }

  /** 02 becomes an audio player; 01/03/05 render inline when they are images, else open in a tab. */
  private loadNonVideoAsset(result: ArchiveSearchResult, type1: string): void {
    this.mediaMode.set(type1 === AUDIO_ASSET_CLASS ? 'audio' : 'document');
    if (!result.digitNo) {
      this.videoUnavailable.set(true);
      return;
    }

    this.isLoadingVideo.set(true);
    this.archiveSearchService.downloadAsset(result.digitNo, type1, result.documentType).subscribe({
      next: blob => {
        this.assetIsImage.set(blob.type.startsWith('image/'));
        this.videoBlobUrl.set(URL.createObjectURL(blob));
        this.isLoadingVideo.set(false);
      },
      error: () => {
        this.videoUnavailable.set(true);
        this.isLoadingVideo.set(false);
      }
    });
  }

  /** The web analogue of legacy's OpenDoc — hands a non-renderable document to the browser. */
  openAssetInNewTab(): void {
    const url = this.videoBlobUrl();
    if (url) window.open(url, '_blank');
  }

  markIn(): void {
    const t = this.mediaEl?.currentTime;
    if (t == null) return;
    this.markedIn.set(t);
  }

  markOut(): void {
    const t = this.mediaEl?.currentTime;
    if (t == null) return;
    if (this.markedIn() == null) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.IN_NOT_MARKED'), '', { duration: 3000 });
      return;
    }
    if (t <= this.markedIn()!) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.OUT_BEFORE_IN'), '', { duration: 3000 });
      return;
    }
    this.markedOut.set(t);
  }

  clearMarks(): void {
    this.markedIn.set(null);
    this.markedOut.set(null);
  }

  /** Legacy Command27 "from" — re-seek playback to the marked in point for preview. */
  seekToIn(): void {
    if (this.markedIn() != null) this.setCurrentTime(this.markedIn()!);
  }

  /** Legacy Command28 "to" — re-seek playback to the marked out point for preview. */
  seekToOut(): void {
    if (this.markedOut() != null) this.setCurrentTime(this.markedOut()!);
  }

  /** Legacy Command10 — step playback forward by jogStep() seconds. */
  jogForward(): void {
    const t = this.mediaEl?.currentTime;
    if (t == null) return;
    this.setCurrentTime(t + this.jogStep());
  }

  /** Legacy Command11 — step playback backward by jogStep() seconds. */
  jogBackward(): void {
    const t = this.mediaEl?.currentTime;
    if (t == null) return;
    this.setCurrentTime(Math.max(0, t - this.jogStep()));
  }

  private setCurrentTime(seconds: number): void {
    const el = this.mediaEl;
    if (el) el.currentTime = seconds;
  }

  /**
   * Legacy datagrid1_DblClick:4890-4928 pauses, sets currentPosition to the record's stored
   * in-point, then plays — so selecting a row lands you at the marked scene, not at 0.
   */
  onMediaLoaded(): void {
    const start = this.markedIn();
    if (start != null && start > 0) this.setCurrentTime(start);
    // Legacy immediately plays after setting position (line 4913: WindowsMediaPlayer1.Controls.Play)
    this.playMedia();
  }

  /** Adds the manually marked in/out range, or falls back to the whole clip's stored duration if no marks were made. */
  addScene(): void {
    const result = this.selectedResult();
    if (!result) return;

    // markedIn/markedOut are seeded from the record's stored range on selection (W8), so this
    // covers both legacy paths: a manual mark and the :3600-3620 fallback to the stored
    // duration. An empty stored range with no manual mark still has nothing to add.
    const inSeconds = this.markedIn() ?? 0;
    const outSeconds = this.markedOut() ?? 0;
    if (outSeconds <= inSeconds) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.NO_MARKS_OR_DURATION'), '', { duration: 4000 });
      return;
    }

    // Legacy :3520 caps a scene at MAX_SCENE_SECONDS unless the operator is privileged.
    // The authoritative check is server-side (DigitizationService exempts privileged users);
    // client-side validation removed to allow privileged users to bypass the cap.

    this.digitizationService.addScene({
      demandNo: this.currentDemandNo() ?? undefined,
      machineNo: result.appNo,
      machineStock: result.machineStock ?? undefined,
      description: sanitiseSceneDescription(this.sceneDescription() || this.defaultSceneDescription(result)),
      inSeconds,
      outSeconds,
      // Lets the backend resolve dmd_path against the HIGH tier with this record's own
      // extension, matching legacy Command12_Click's high_stock_path + dig_typ_high.
      highExtension: result.highType ?? undefined
    }).subscribe({
      next: r => {
        this.currentDemandNo.set(r.data.demandNo);
        this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.SCENE_ADDED'), '', { duration: 3000 });
        this.clearMarks();
        this.loadScenes();
      }
    });
  }

  /**
   * Legacy :3506-3516 — when the description box is left empty the stored value is
   * {@code Str(stock) & " _ " & Mid(title, 1, 80)}, sanitised. The previous default was the
   * full untruncated title with no stock prefix.
   */
  private defaultSceneDescription(result: ArchiveSearchResult): string {
    const title = sanitiseSceneDescription(result.activeTitleAr ?? '').substring(0, 80);
    const stock = result.machineStock?.trim();
    return stock ? `${stock} _ ${title}` : title;
  }

  /** Add scene from the اختیار المشاهد section (same as the player's add scene) */
  addSceneToList(): void {
    const result = this.selectedSceneForScenes();
    const sceneTitle = this.scenesForm.get('sceneNewTitle')?.value?.trim();

    if (!result || !sceneTitle) return;

    // Use the custom title from the scenes section if provided
    const inSeconds = this.markedIn() ?? 0;
    const outSeconds = this.markedOut() ?? 0;
    if (outSeconds <= inSeconds) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.NO_MARKS_OR_DURATION'), '', { duration: 4000 });
      return;
    }

    this.digitizationService.addScene({
      demandNo: this.currentDemandNo() ?? undefined,
      machineNo: result.appNo,
      machineStock: result.machineStock ?? undefined,
      description: sanitiseSceneDescription(sceneTitle),
      inSeconds,
      outSeconds,
      highExtension: result.highType ?? undefined
    }).subscribe({
      next: r => {
        this.currentDemandNo.set(r.data.demandNo);
        this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.SCENE_ADDED'), '', { duration: 3000 });
        this.scenesForm.get('sceneNewTitle')?.reset();
        this.selectedSceneForScenes.set(null);
        this.clearMarks();
        this.loadScenes();
      }
    });
  }

  /** Send queued scenes to EDLC — Legacy Command5 (:4095-4404) re-encodes each dmd_chek=1
   * to DV PAL, extracts poster frame, updates dmd_chek=2, registers with EDLC.
   * Operates on ALL pre-queued items (DataGrid2), matching legacy mass operation. */
  sendSceneToEdlc(): void {
    this.sendToEdlc();
  }

  /** Legacy Command16_Click — show total duration of ALL scenes in the list (مدة المشاهد) */
  showSceneDuration(): void {
    const allScenes = this.scenes();
    if (allScenes.length === 0) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.NO_SCENES'), '', { duration: 4000 });
      return;
    }

    // Sum all scene durations (legacy: som_out = som_out + view_demand.Recordset![dmd_out])
    const totalDurationSeconds = allScenes.reduce((sum, scene) => sum + (scene.time ?? 0), 0);
    const formatted = this.formatDuration(totalDurationSeconds);

    this.snackBar.open(
      `عدد المشاهد = ${allScenes.length} — المدة الإجمالية: ${formatted}`,
      '',
      { duration: 4000 }
    );
  }

  /** Legacy Command14_Click — execute/extract all checked scenes in the list (تنفيذ) */
  executeScene(): void {
    // Legacy iterates view_demand.Recordset where dmd_chek = 1.
    // Angular gets selectedSceneIds() (all scenes where checked === 1).
    // Do NOT require valid markedIn/markedOut — those are only for adding NEW scenes,
    // not for extracting already-stored scenes from the list.
    // startDeliveryJob() validates that there are scenes to extract.
    this.extractClips();
  }

  /**
   * Legacy DBList1_KeyDown F2 (:5156-5168) — runs proc_pos over the highlighted form-lookup
   * entry's SUB_TYP || SUB_NO and shows the resulting pos_nam values in DBList3.
   *
   * F2-over-a-dropdown has no web idiom, so the drill-down is an icon button on each
   * suggestion row, opening a panel beneath the field. The autocomplete markup is unchanged.
   */
  positionsFormCode = signal<string | null>(null);
  positionsPanelOpen = signal(false);
  positions = signal<Position[]>([]);
  isLoadingPositions = signal(false);

  showPositionsFor(option: SearchResult, event: Event): void {
    // The option row is inside a mat-option; without this the click also selects the entry.
    event.stopPropagation();
    const formCode = option.appNo?.trim();
    if (!formCode) return;

    this.positionsFormCode.set(formCode);
    this.positionsPanelOpen.set(true);
    this.isLoadingPositions.set(true);
    this.positions.set([]);
    this.sitesService.getPositionsByFormCode(formCode).subscribe({
      next: r => {
        this.positions.set(r.data ?? []);
        this.isLoadingPositions.set(false);
      },
      error: () => {
        this.positions.set([]);
        this.isLoadingPositions.set(false);
      }
    });
  }

  closePositionsPanel(): void {
    this.positionsPanelOpen.set(false);
    this.positionsFormCode.set(null);
    this.positions.set([]);
  }

  /** Legacy F6 on the results grid — opens Frame3, the full title + abstract viewer. */
  toggleAbstractViewer(): void {
    this.abstractViewerOpen.update(v => !v);
  }

  /** Legacy Command22 "تسجيل" inside Frame3 — logs the beneficiary's remark about missing info. */
  saveRemark(): void {
    const result = this.selectedResult();
    const remark = this.abstractRemark().trim();
    if (!result || !remark) return;
    this.isSavingRemark.set(true);
    this.archiveSearchService.saveRemark(result.appNo, remark).subscribe({
      next: () => {
        this.isSavingRemark.set(false);
        this.abstractRemark.set('');
        this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.REMARK_SAVED'), '', { duration: 3000 });
      },
      error: () => this.isSavingRemark.set(false)
    });
  }

  /**
   * Legacy Form_Load (:5590-5620) builds and immediately executes tmp_demand<user_no> —
   * demand LEFT JOIN main LEFT JOIN config, filtered by the date window and the logged-in
   * user, ordered dmd_no, dmd_ser DESC — so pending requests from earlier sessions are on
   * screen before the user does anything. The previous implementation short-circuited on a
   * null currentDemandNo, leaving the queue permanently empty until a scene was added in
   * this session.
   *
   * The user scope is deliberately NOT sent from here: the backend already forces non-admins
   * onto their own demands (DigitizationService#buildDemandSpec fails closed), which is the
   * safer half of legacy's box_user_no scoping and cannot be spoofed by the client.
   */
  loadScenes(): void {
    this.isLoadingScenes.set(true);
    this.digitizationService.getDemands(0, 200, {
      dateFrom: dayStartIso(this.demandDateFrom()),
      dateTo: dayEndIso(this.demandDateTo()),
      // Legacy Check2 checked → (dmd_chek <> 2 OR dmd_chek IS NULL); unchecked → no narrowing.
      fulfilled: this.unfulfilledOnly() ? false : undefined
    }).subscribe({
      next: r => {
        // Legacy "order by dmd_no, dmd_ser desc".
        const rows = [...r.data.content].sort((a, b) =>
          b.demandNo.localeCompare(a.demandNo) || b.serial - a.serial);
        this.scenes.set(rows);
        // Legacy :5637-5645 seeds m_dmd_ser from the first row of the refreshed set, so a
        // cold open appends to the newest existing request instead of opening a fresh one.
        if (!this.currentDemandNo() && rows.length) {
          this.currentDemandNo.set(rows[0].demandNo);
        }
        this.isLoadingScenes.set(false);
      },
      error: () => this.isLoadingScenes.set(false)
    });
  }

  onDemandDateFromChange(value: string): void {
    this.demandDateFrom.set(value);
    this.loadScenes();
  }

  onDemandDateToChange(value: string): void {
    this.demandDateTo.set(value);
    this.loadScenes();
  }

  onUnfulfilledOnlyChange(checked: boolean): void {
    this.unfulfilledOnly.set(checked);
    this.loadScenes();
  }

  /** Legacy DataGrid2_DblClick — check if scene row is currently selected */
  isSelectedScene(scene: DigitDemand): boolean {
    return this.selectedSceneRow()?.id === scene.id;
  }

  /** Legacy DataGrid2 click — single-click selects the row for context */
  selectSceneRow(scene: DigitDemand): void {
    this.selectedSceneRow.set(scene);
  }

  /** Legacy DataGrid2_DblClick (:4964-4999) — loads scene media and auto-plays from in point */
  selectAndLoadSceneRow(scene: DigitDemand): void {
    this.selectedSceneRow.set(scene);
    // Load the media file using the machine stock and path, similar to legacy playback
    if (!scene.machineStock) return;
    this.isLoadingVideo.set(true);
    this.archiveSearchService.downloadMedia(scene.machineStock, 'LOW', scene.cote).subscribe({
      next: blob => {
        this.videoBlobUrl.set(URL.createObjectURL(blob));
        this.isLoadingVideo.set(false);
        // Auto-play from the in point (time1 field)
        if (this.mediaEl) {
          this.mediaEl.currentTime = scene.time1 ? parseFloat(scene.time1) : 0;
          setTimeout(() => {
            if (this.mediaEl) this.mediaEl.play();
          }, 100);
        }
      },
      error: () => {
        this.videoUnavailable.set(true);
        this.isLoadingVideo.set(false);
      }
    });
  }

  /** Legacy Command20_Click (:3843-3853) skips del_demand entirely when dmd_chek = 2. */
  removeScene(scene: DigitDemand): void {
    if (this.isSceneFulfilled(scene)) return;
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.digitizationService.deleteDemand(scene.id).subscribe({
      next: () => this.loadScenes()
    });
  }

  newRequest(): void {
    this.currentDemandNo.set(null);
    this.loadScenes();
  }

  /**
   * Legacy Command5 "ارسل الى EDLC" (:4095-4405) — re-encodes each queued scene to DV PAL,
   * grabs a poster frame, flips dmd_chek to 2, records the executing user, and registers the
   * file with the external EDLC system. This replaces the placeholder CSV export, which
   * delivered nothing.
   */
  sendToEdlc(): void {
    this.startDeliveryJob(ids => this.digitizationService.sendDemandsToEdlc(ids));
  }

  /**
   * Legacy Command14 "تنفيد" (:3219-3467) — stream-copies each queued scene (no re-encode)
   * to "<desc> Clip <ser>.<ext>". Legacy wrote to a folder chosen in a Save dialog; a browser
   * cannot offer one, so output lands in the server-side archive and is listed for download.
   */
  extractClips(): void {
    this.startDeliveryJob(ids => this.digitizationService.extractDemandClips(ids));
  }

  private startDeliveryJob(
    start: (ids: number[]) => Observable<{ data: DeliveryJobStatus }>
  ): void {
    // Legacy iterates the grid acting on dmd_chek = 1 rows only.
    const ids = this.selectedSceneIds();
    if (ids.length === 0) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.NOTHING_SELECTED'), '', { duration: 4000 });
      return;
    }

    this.batchJob.set(null);
    this.batchRunning.set(true);
    start(ids).subscribe({
      next: r => this.pollDeliveryJob(r.data.jobId),
      error: () => {
        this.batchRunning.set(false);
        this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.BATCH_FAILED'), '', { duration: 5000 });
      }
    });
  }

  /** Legacy showed per-item progress in m_tit; over HTTP that becomes a poll. */
  private pollDeliveryJob(jobId: string): void {
    timer(0, BATCH_POLL_INTERVAL_MS).pipe(
      switchMap(() => this.digitizationService.getDeliveryJob(jobId)),
      takeWhile(r => r.data.state === 'RUNNING', true),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe({
      next: r => {
        this.batchJob.set(r.data);
        if (r.data.state !== 'RUNNING') this.finishDeliveryJob(r.data);
      },
      error: () => {
        this.batchRunning.set(false);
        this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.BATCH_FAILED'), '', { duration: 5000 });
      }
    });
  }

  /** Reproduces legacy's three end-of-batch messages. */
  private finishDeliveryJob(job: DeliveryJobStatus): void {
    this.batchRunning.set(false);
    this.loadScenes();

    if (job.state === 'FAILED') {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.BATCH_FAILED'), '', { duration: 5000 });
      return;
    }
    if (job.nothingSelected) {
      this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.NOTHING_SELECTED'), '', { duration: 4000 });
      return;
    }
    if (job.failedStockNumbers.length > 0) {
      this.snackBar.open(
        this.translate.instant('ARCHIVE_SEARCH.BATCH_PARTIAL', { stocks: job.failedStockNumbers.join(', ') }),
        '', { duration: 8000 });
      return;
    }
    this.snackBar.open(this.translate.instant('ARCHIVE_SEARCH.BATCH_COMPLETE'), '', { duration: 4000 });
  }

  formatDuration(totalSeconds: number): string {
    const s = Math.max(0, Math.round(totalSeconds));
    const h = Math.floor(s / 3600);
    const m = Math.floor((s % 3600) / 60);
    const sec = s % 60;
    return [h, m, sec].map(n => String(n).padStart(2, '0')).join(':');
  }

  private toSeconds(hours: number | null, minutes: number | null, seconds: number | null): number {
    return (hours ?? 0) * 3600 + (minutes ?? 0) * 60 + (seconds ?? 0);
  }

  private releaseVideo(): void {
    const current = this.videoBlobUrl();
    if (current) {
      URL.revokeObjectURL(current);
    }
    this.videoBlobUrl.set(null);
  }

  /** Legacy WindowsMediaPlayer1 playback controls */
  playMedia(): void {
    if (this.mediaEl) {
      this.mediaEl.play();
      this.mediaStatusText.set('يتم التشغيل...');
    }
  }

  stopMedia(): void {
    if (this.mediaEl) {
      this.mediaEl.pause();
      this.mediaEl.currentTime = 0;
      this.mediaStatusText.set('متوقف');
    }
  }

  previousFrame(): void {
    if (this.mediaEl && this.mediaEl.currentTime > 0) {
      this.mediaEl.currentTime = Math.max(0, this.mediaEl.currentTime - this.jogStep());
    }
  }

  nextFrame(): void {
    if (this.mediaEl) {
      this.mediaEl.currentTime = Math.min(this.mediaEl.duration, this.mediaEl.currentTime + this.jogStep());
    }
  }

  toggleMute(): void {
    this.playerMuted.update(m => !m);
    if (this.mediaEl) {
      this.mediaEl.muted = this.playerMuted();
    }
  }

  previousPage(): void {
    this.currentPageNo.update(n => Math.max(1, n - 1));
  }

  nextPage(): void {
    this.currentPageNo.update(n => n + 1);
  }

  togglePlayerCollapse(): void {
    this.playerCollapsed.update(c => !c);
  }
}
