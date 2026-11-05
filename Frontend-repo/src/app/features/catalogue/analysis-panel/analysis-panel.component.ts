import { Component, HostListener, Input, OnChanges, SimpleChanges, computed, inject, signal } from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatAutocompleteTrigger } from '@angular/material/autocomplete';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { ApiResponse } from '../../../core/models/api-response.model';
import { CatalogueService } from '../services/catalogue.service';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { ArchiveSearchService } from '../../archive-search/services/archive-search.service';
import { DigitRecord } from '../../digitization/models/digitization.model';
import { AutocompleteService, MacnzOption, FormOption } from '../../../core/services/autocomplete.service';
import { ConfirmPromptDialogComponent } from '../documentation-form/dialogs/confirm-prompt-dialog.component';
import { AdditionalFilesComponent } from '../../form-thesaurus/additional-files/additional-files.component';
import {
  SubjectDescriptor, GeoDescriptor, NarowerTerm, RelatedTerm, FileAddItem, TimeDescriptor,
  DateSubject, Text1Item
} from '../models/catalogue.models';

/**
 * Visual + functional replacement for Form2.frm ("برنامج معالجة التحليل"), opened by
 * الوثيقة's التحليل toolbar button. Mirrors the legacy layout: a document-wide
 * descriptor list (right column, codes 10/20/01/02/03/04) and, once one descriptor
 * row is selected, a relation-number stepper (رقم العلاقة) that scopes a second set
 * of relation-specific lists (left column, codes 30/40/50/60) plus that relation's
 * time marks and validity date range.
 */
@Component({
  standalone: false,
  selector: 'app-analysis-panel',
  templateUrl: './analysis-panel.component.html',
  styleUrls: ['./analysis-panel.component.scss']
})
export class AnalysisPanelComponent implements OnChanges {

  @Input() appNo!: string;
  @Input() activeTitle: string | null = null;
  /** main.MN_RESULT — Form2.frm shows the abstract (m_mn_result) and saves it on Esc. */
  @Input() result: string | null = null;

  isCollapsed = signal(false);

  private catalogueService = inject(CatalogueService);
  private autoSvc = inject(AutocompleteService);
  private fb = inject(FormBuilder);
  private dialog = inject(MatDialog);
  private snack = inject(MatSnackBar);
  private digitization = inject(DigitizationService);
  private archiveSearch = inject(ArchiveSearchService);

  // --- WindowsMediaPlayer1 ---
  mediaRows = signal<DigitRecord[]>([]);
  mediaRow = signal<DigitRecord | null>(null);
  mediaUrl = signal<string | null>(null);
  mediaMessage = signal<string | null>(null);
  /** m_step: seconds moved by the step buttons. */
  playerStep = signal(5);
  playerTime = signal('00:00:00');
  private pendingSeek: number | null = null;
  private router = inject(Router);
  private t = inject(TranslateService);

  /** Legacy messages (Form2.frm MsgBox texts). */
  private static readonly MSG_PICK_SUBJECT = 'لايمكن ادخل العلاقات الا بعد تحديد الواصفة!!!!';
  private static readonly MSG_FIRST_FIELD = 'يجب ان تملأ خانة الاولى..........';

  /** Server refusals (e.g. the lock: "لاتستطيع التعدل او الالغاء ....لان الوثيقة مقفلة.") are shown, never swallowed. */
  private showError(err: unknown): void {
    const msg = err instanceof HttpErrorResponse ? err.error?.message : null;
    this.snack.open(typeof msg === 'string' && msg ? msg : this.t.instant('APP.ERROR'), '', { duration: 4000 });
  }

  private message(text: string): void {
    this.snack.open(text, '', { duration: 4000 });
  }

  /**
   * Every delete on Form2.frm (DBList1..DBList10_KeyUp Delete) shows
   * InputBox("هل تريد الغاء المقالة(ن/ك)") before running the del_* proc — no list
   * deletes silently. Centralized here so all 10 sections confirm the same way.
   */
  private confirmDelete(action: () => void): void {
    this.dialog.open(ConfirmPromptDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { messageKey: 'DOC_FORM.CONFIRM_DELETE_ROW' }
    }).afterClosed().subscribe(confirmed => {
      if (confirmed) action();
    });
  }

  subjects = signal<SubjectDescriptor[]>([]);
  geoDescriptors = signal<GeoDescriptor[]>([]);
  narrowerTerms = signal<NarowerTerm[]>([]);
  relatedTerms = signal<RelatedTerm[]>([]);
  fileRelations = signal<FileAddItem[]>([]);
  timeDescriptors = signal<TimeDescriptor[]>([]);
  dateSubjects = signal<DateSubject[]>([]);
  text1Items = signal<Text1Item[]>([]);

  // MACNZ/forms have no server-side "contains" search — cached full lists filtered
  // client-side, matching bحث بالبداية (prefix) / بحث بكلمة معينة (contains) exactly
  // like Form2.frm's Option1/Option2 radio buttons.
  macnzOptions = signal<MacnzOption[]>([]);
  searchMode = signal<'prefix' | 'contains'>('prefix');

  // Legacy's GEO/FILE_ADD lists bind ListField="sub_name" — never show a raw code
  // alone. There's no bulk lookup endpoint, so codes are resolved one at a time
  // via getFormByCode() and cached here as they're encountered.
  private formNames = signal<Record<string, string>>({});
  /** Name codes the server could not resolve (legacy INNER JOIN view_form drops those rows). */
  private missingFormCodes = signal<Set<string>>(new Set());
  private resolvingFormCodes = new Set<string>();

  selectedSubject = signal<SubjectDescriptor | null>(null);
  activeRelativeNo = signal<string>('02');

  isAddingSubject = signal(false);
  isAddingGeo = signal(false);
  isAddingNarrowerOverall = signal(false);
  isAddingRelatedOverall = signal(false);
  isAddingFileForOverall = signal(false);
  isAddingFileAboutOverall = signal(false);
  isAddingNarrowerRelation = signal(false);
  isAddingRelatedRelation = signal(false);
  isAddingFileForRelation = signal(false);
  isAddingFileAboutRelation = signal(false);
  isAddingTime = signal(false);
  isAddingDateSubject = signal(false);
  isTextOpen = signal(false);
  isTempFilesOpen = signal(false);
  replacingSubject = signal<SubjectDescriptor | null>(null);
  positionsOf = signal<{ code: string; name: string } | null>(null);
  positions = signal<string[]>([]);
  abstractCtrl = new FormControl<string>('', { nonNullable: true });
  textCtrl = new FormControl<string>('', { nonNullable: true });
  wordCtrl = new FormControl<string>('', { nonNullable: true });
  highlightedText = signal<{ text: string; hit: boolean }[]>([]);
  /** Text of the selected descriptor serial + relation number (serh_text1); "" when none. */
  private loadedTextKey = '';

  subjectFilteredMacnz = signal<MacnzOption[]>([]);
  narrowerOverallFilteredMacnz = signal<MacnzOption[]>([]);
  relatedOverallFilteredMacnz = signal<MacnzOption[]>([]);
  narrowerRelationFilteredMacnz = signal<MacnzOption[]>([]);
  relatedRelationFilteredMacnz = signal<MacnzOption[]>([]);
  geoFilteredForms = signal<FormOption[]>([]);
  fileForOverallFilteredForms = signal<FormOption[]>([]);
  fileAboutOverallFilteredForms = signal<FormOption[]>([]);
  fileForRelationFilteredForms = signal<FormOption[]>([]);
  fileAboutRelationFilteredForms = signal<FormOption[]>([]);

  /**
   * form2.frm reloads every relation list with ANALIS.Resultset![an_ser_no] only (GEO_PROC,
   * NAROWER_PROC, RELATIVE_PROC, file_add_PROC … take @desc nvarchar(2) = the serial), never the
   * descriptor code — real legacy rows often carry a different code than their descriptor.
   */
  private matchesSelected(serialNo: string | null): boolean {
    const sel = this.selectedSubject();
    return !!sel && (sel.serialNo ?? '').trim() === (serialNo ?? '').trim();
  }

  /** Legacy procs INNER JOIN macnz (SUB_CODE): a code the thesaurus doesn't have is not listed. */
  private hasMacnz(code: string | null): boolean {
    if (!code?.trim()) return false;
    return this.macnzOptions().length === 0 || this.macnzOptions().some(o => o?.code === code.trim());
  }

  /** Legacy procs INNER JOIN view_form (sub_cod): an empty or unknown name code is not listed. */
  private hasForm(code: string | null): boolean {
    return !!code?.trim() && !this.missingFormCodes().has(code);
  }

  private eq(value: string | null | undefined, expected: string): boolean {
    return (value ?? '').trim() === expected;
  }

  // NAROWER_PROC / RELATIVE_PROC typ '1', GEO_PROC, file_add_PROC (typ '1', rel '01', typ1 '1'|'2')
  overallNarrower = computed(() => this.narrowerTerms().filter(n => this.eq(n.narrowerType, '1') && this.matchesSelected(n.serialNo) && this.hasMacnz(n.narrowerNo)));
  overallRelated = computed(() => this.relatedTerms().filter(r => this.eq(r.relativeType, '1') && this.matchesSelected(r.serialNo) && this.hasMacnz(r.relationNo)));
  overallGeo = computed(() => this.geoDescriptors().filter(g => this.matchesSelected(g.serialNo) && this.hasForm(g.geoNo)));
  overallFileFor = computed(() => this.fileRelations().filter(f => this.eq(f.fileType1, '1') && this.eq(f.relativeNo, '01') && this.eq(f.fileType2, '1') && this.matchesSelected(f.serialNo) && this.hasForm(f.fileNo)));
  overallFileAbout = computed(() => this.fileRelations().filter(f => this.eq(f.fileType1, '1') && this.eq(f.relativeNo, '01') && this.eq(f.fileType2, '2') && this.matchesSelected(f.serialNo) && this.hasForm(f.fileNo)));

  // NAROWER1_PROC / relative1_PROC typ '2', file_add_PROC (typ '2', rel = Text3, typ1 '1'|'2')
  relationNarrower = computed(() => this.narrowerTerms().filter(n => this.eq(n.narrowerType, '2') && this.eq(n.relativeNo, this.activeRelativeNo()) && this.matchesSelected(n.serialNo) && this.hasMacnz(n.narrowerNo)));
  relationRelated = computed(() => this.relatedTerms().filter(r => this.eq(r.relativeType, '2') && this.eq(r.relativeNo, this.activeRelativeNo()) && this.matchesSelected(r.serialNo) && this.hasMacnz(r.relationNo)));
  relationFileFor = computed(() => this.fileRelations().filter(f => this.eq(f.fileType1, '2') && this.eq(f.relativeNo, this.activeRelativeNo()) && this.eq(f.fileType2, '1') && this.matchesSelected(f.serialNo) && this.hasForm(f.fileNo)));
  relationFileAbout = computed(() => this.fileRelations().filter(f => this.eq(f.fileType1, '2') && this.eq(f.relativeNo, this.activeRelativeNo()) && this.eq(f.fileType2, '2') && this.matchesSelected(f.serialNo) && this.hasForm(f.fileNo)));

  activeTimeMark = computed(() => {
    const sel = this.selectedSubject();
    return sel ? this.timeDescriptors().find(t => t.rltvNo === this.activeRelativeNo() && t.serNo === sel.serialNo) ?? null : null;
  });

  activeDateSubject = computed(() => {
    const sel = this.selectedSubject();
    return sel ? this.dateSubjects().find(d => d.dteRelNo?.trim() === this.activeRelativeNo() && d.dteSerNo?.trim() === sel.serialNo) ?? null : null;
  });

  // tit_istext — "يوجد نص" / "لا يوجد نص" status in Form2.frm's header.
  hasText = computed(() => this.text1Items().length > 0);

  subjectForm = this.fb.group({
    descriptorPicker: new FormControl<MacnzOption | string | null>(null, Validators.required)
  });

  geoForm = this.fb.group({
    geoPicker: new FormControl<FormOption | string | null>(null, Validators.required)
  });

  narrowerOverallForm = this.fb.group({
    narrowerPicker: new FormControl<MacnzOption | string | null>(null, Validators.required)
  });

  relatedOverallForm = this.fb.group({
    relationPicker: new FormControl<MacnzOption | string | null>(null, Validators.required)
  });

  fileForOverallForm = this.fb.group({
    filePicker: new FormControl<FormOption | string | null>(null, Validators.required)
  });

  fileAboutOverallForm = this.fb.group({
    filePicker: new FormControl<FormOption | string | null>(null, Validators.required)
  });

  narrowerRelationForm = this.fb.group({
    narrowerPicker: new FormControl<MacnzOption | string | null>(null, Validators.required)
  });

  relatedRelationForm = this.fb.group({
    relationPicker: new FormControl<MacnzOption | string | null>(null, Validators.required)
  });

  fileForRelationForm = this.fb.group({
    filePicker: new FormControl<FormOption | string | null>(null, Validators.required)
  });

  fileAboutRelationForm = this.fb.group({
    filePicker: new FormControl<FormOption | string | null>(null, Validators.required)
  });

  timeForm = this.fb.group({
    tmO: [null as number | null], tmM: [null as number | null], tmS: [null as number | null],
    tmO1: [null as number | null], tmM1: [null as number | null], tmS1: [null as number | null]
  });

  dateSubjectForm = this.fb.group({
    dteDteDeb: [''],
    dteDteFin: ['']
  });


  ngOnChanges(changes: SimpleChanges): void {
    if (changes['result']) {
      this.abstractCtrl.reset((this.result ?? '').trimEnd());
    }
    if (changes['appNo'] && this.appNo) {
      this.loadAll();
      this.loadMediaRows();
      this.autoSvc.getAllMacnz().subscribe({ next: r => this.macnzOptions.set(r.data), error: () => {} });
      this.wireMacnz(this.subjectForm.controls.descriptorPicker, this.subjectFilteredMacnz);
      this.wireMacnz(this.narrowerOverallForm.controls.narrowerPicker, this.narrowerOverallFilteredMacnz);
      this.wireMacnz(this.relatedOverallForm.controls.relationPicker, this.relatedOverallFilteredMacnz);
      this.wireMacnz(this.narrowerRelationForm.controls.narrowerPicker, this.narrowerRelationFilteredMacnz);
      this.wireMacnz(this.relatedRelationForm.controls.relationPicker, this.relatedRelationFilteredMacnz);
      this.wireForm(this.geoForm.controls.geoPicker, this.geoFilteredForms);
      this.wireForm(this.fileForOverallForm.controls.filePicker, this.fileForOverallFilteredForms);
      this.wireForm(this.fileAboutOverallForm.controls.filePicker, this.fileAboutOverallFilteredForms);
      this.wireForm(this.fileForRelationForm.controls.filePicker, this.fileForRelationFilteredForms);
      this.wireForm(this.fileAboutRelationForm.controls.filePicker, this.fileAboutRelationFilteredForms);
    }
  }

  private wireMacnz(ctrl: FormControl<MacnzOption | string | null>, target: ReturnType<typeof signal<MacnzOption[]>>): void {
    ctrl.valueChanges.pipe(debounceTime(200)).subscribe(val => {
      const q = typeof val === 'string' ? val.trim().toLowerCase() : '';
      if (!q) { target.set(this.macnzOptions().filter(o => Number(o.level) > 2).slice(0, 100)); return; }
      target.set(
        this.macnzOptions()
          .filter(o => Number(o.level) > 2 && this.matchesSearch(o.code, o.description, q))
          .slice(0, 50)
      );
    });
  }

  /**
   * DBList11 shows its full list the instant it opens, before any typing —
   * a plain mat-autocomplete only populates via valueChanges, so clicking into
   * an empty field showed nothing and looked exactly like a free-text box.
   * This seeds a browsable slice of leaf-level MACNZ codes on first focus.
   */
  onMacnzFocus(target: ReturnType<typeof signal<MacnzOption[]>>): void {
    if (target().length === 0) {
      target.set(this.macnzOptions().filter(o => Number(o.level) > 2).slice(0, 100));
    }
  }

  private wireForm(ctrl: FormControl<FormOption | string | null>, target: ReturnType<typeof signal<FormOption[]>>): void {
    ctrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => {
        const q = typeof val === 'string' ? val.trim() : '';
        if (q.length < 1) return of({ data: { content: [] as FormOption[] } });
        return this.autoSvc.searchForms(q, this.searchMode());
      })
    ).subscribe(r => target.set(r.data.content));
  }

  private matchesSearch(code: string | null, description: string | null, q: string): boolean {
    // Legacy MACNZ has terms with a NULL SUB_DESC: they never match (SQL LIKE on NULL), and must not
    // throw here — a throw ends the valueChanges subscription and the picker stops filtering for good.
    description = description ?? '';
    code = code ?? '';
    return this.searchMode() === 'prefix'
      ? description.toLowerCase().startsWith(q) || code.toLowerCase().startsWith(q)
      : description.toLowerCase().includes(q) || code.toLowerCase().includes(q);
  }

  displayMacnz(opt: MacnzOption | string): string {
    if (!opt) return '';
    return typeof opt === 'string' ? opt : `${opt.code} — ${opt.description}`;
  }

  displayForm(opt: FormOption | string): string {
    if (!opt) return '';
    return typeof opt === 'string' ? opt : opt.name;
  }

  macnzDescription(code: string | null): string {
    if (!code) return '';
    return this.macnzOptions().find(o => o?.code === code)?.description ?? '';
  }

  /** Falls back to the raw code while the name is still being fetched. */
  formDescription(code: string | null): string {
    if (!code) return '';
    return this.formNames()[code] ?? code;
  }

  /**
   * GEO_GEO_NO is stored as SUB_TYP+SUB_NO concatenated (Form2.frm:
   * m_geo_no = view_form![sub_typ] & view_form![sub_no]), but /api/forms/{formNo}
   * only accepts the bare SUB_NO — so geo codes need their 2-char type prefix
   * stripped before lookup, while FILE_ADD codes (not concatenated) don't.
   * Cached by the original, un-stripped code either way.
   */
  private resolveFormNames(codes: (string | null)[], stripTypePrefix = false): void {
    const cache = this.formNames();
    const toFetch = [...new Set(codes.filter((c): c is string => !!c && !cache[c] && !this.resolvingFormCodes.has(c)))];
    for (const code of toFetch) {
      this.resolvingFormCodes.add(code);
      // GEO_GEO_NO and FAD_FAD_NO join view_form.sub_cod (SUB_TYP + SUB_NO); an 8-char value is
      // an older migrated FILE_ADD row that stored SUB_NO alone.
      void stripTypePrefix;
      const lookup$: Observable<ApiResponse<{ name: string }>> = code.trim().length > 8
        ? this.autoSvc.getFormNameByTypedCode(code.trim())
        : this.autoSvc.getFormByCode(code.trim());
      lookup$.subscribe({
        next: r => this.formNames.update(m => ({ ...m, [code]: r.data.name })),
        error: () => this.missingFormCodes.update(set => new Set(set).add(code)),
        complete: () => this.resolvingFormCodes.delete(code)
      });
    }
  }

  private loadAll(): void {
    this.catalogueService.getSubjects(this.appNo).subscribe({ next: r => this.subjects.set(r.data), error: () => {} });
    this.catalogueService.getGeoDescriptors(this.appNo).subscribe({
      next: r => { this.geoDescriptors.set(r.data); this.resolveFormNames(r.data.map(g => g.geoNo), true); },
      error: () => {}
    });
    this.catalogueService.getNarrowerTerms(this.appNo).subscribe({ next: r => this.narrowerTerms.set(r.data), error: () => {} });
    this.catalogueService.getRelatedTerms(this.appNo).subscribe({ next: r => this.relatedTerms.set(r.data), error: () => {} });
    this.catalogueService.getFiles(this.appNo).subscribe({
      next: r => { this.fileRelations.set(r.data); this.resolveFormNames(r.data.map(f => f.fileNo)); },
      error: () => {}
    });
    this.catalogueService.getTimeDescriptors(this.appNo).subscribe({ next: r => this.timeDescriptors.set(r.data), error: () => {} });
    this.catalogueService.getDateSubjects(this.appNo).subscribe({ next: r => this.dateSubjects.set(r.data), error: () => {} });
    this.catalogueService.getText1(this.appNo).subscribe({ next: r => this.text1Items.set(r.data), error: () => {} });
  }

  selectSubject(s: SubjectDescriptor): void {
    this.selectedSubject.set(s);
    this.reloadOpenText();
    this.seekToActiveMark();
  }

  // ---------- WindowsMediaPlayer1 ----------

  /** Form6.frm rel_digit loop: the document's video row (DIG_TYP1 04) is the player's file; audio (02) also plays. */
  private loadMediaRows(): void {
    this.digitization.getRecords(0, 100, this.appNo).subscribe({
      next: r => {
        const rows = (r.data?.content ?? []).filter(d => ['04', '02'].includes((d.type1 ?? '').trim()) && !!d.digitNo);
        this.mediaRows.set(rows);
        const video = [...rows].reverse().find(d => d.type1.trim() === '04');
        const pick = video ?? rows[rows.length - 1] ?? null;
        if (pick) this.loadMedia(pick); else this.mediaMessage.set('CATALOGUE.NO_MEDIA_LINKED');
      },
      error: () => this.mediaMessage.set('CATALOGUE.NO_MEDIA_LINKED')
    });
  }

  loadMedia(row: DigitRecord): void {
    this.mediaRow.set(row);
    const old = this.mediaUrl();
    if (old) URL.revokeObjectURL(old);
    this.mediaUrl.set(null);
    this.mediaMessage.set('CATALOGUE.MEDIA_LOADING');
    const type1 = row.type1.trim();
    // 04 → the tape proxy through ranjpath (rjp_typ 2, m_STCOK_path_new); 02 → the audio asset (waves)
    const blob$ = type1 === '04'
      ? this.digitization.downloadMedia(row.digitNo.trim(), (row.type ?? '').trim() || undefined, true)
      : this.archiveSearch.downloadAsset(row.digitNo.trim(), type1, row.type);
    blob$.subscribe({
      next: blob => {
        this.mediaMessage.set(null);
        // legacy starts at the DIGIT row's own start time (v_mch_o/m/s)
        this.pendingSeek = (row.durationHours ?? 0) * 3600 + (row.durationMinutes ?? 0) * 60 + (row.durationSeconds ?? 0);
        this.mediaUrl.set(URL.createObjectURL(blob));
      },
      error: () => this.mediaMessage.set('DOC_FORM.FILE_NOT_FOUND')
    });
  }

  onMediaReady(player: HTMLVideoElement): void {
    this.player = player;
    player.ontimeupdate = () => this.playerTime.set(this.hms(player.currentTime));
    const mark = this.activeTimeMark();
    const start = mark ? this.markStart(mark) : this.pendingSeek;
    if (start !== null && start !== undefined) player.currentTime = start;
    this.pendingSeek = null;
    player.pause();
  }

  private player: HTMLVideoElement | null = null;

  /** disp_time: when the descriptor/relation has time marks, the player goes to their start. */
  private seekToActiveMark(): void {
    setTimeout(() => {
      const mark = this.activeTimeMark();
      if (this.player && mark) { this.player.currentTime = this.markStart(mark); this.player.pause(); }
    });
  }

  private markStart(m: { startHour: number | null; startMinute: number | null; startSecond: number | null }): number {
    return (m.startHour ?? 0) * 3600 + (m.startMinute ?? 0) * 60 + (m.startSecond ?? 0);
  }

  private hms(t: number): string {
    const s = Math.max(0, Math.floor(t));
    const p = (n: number) => String(n).padStart(2, '0');
    return `${p(Math.floor(s / 3600))}:${p(Math.floor((s % 3600) / 60))}:${p(s % 60)}`;
  }

  /** WindowsMediaPlayer1_Click: pause / continue. */
  togglePlay(player: HTMLVideoElement): void {
    if (player.paused) player.play(); else player.pause();
  }

  /** Command7 / Command6: back / forward by m_step seconds. */
  stepBy(player: HTMLVideoElement, dir: 1 | -1): void {
    player.currentTime = Math.max(0, player.currentTime + dir * (this.playerStep() || 0));
  }

  /** m_step_KeyDown (← −1 s, → +1 s, Space pause) and m_step_KeyPress (j −0.04, l +0.04, k pause). */
  onStepKey(e: KeyboardEvent, player: HTMLVideoElement): void {
    const moves: Record<string, number> = { ArrowLeft: -1, ArrowRight: 1, j: -0.04, l: 0.04 };
    if (e.key in moves) {
      e.preventDefault();
      player.currentTime = Math.max(0, player.currentTime + moves[e.key]);
      player.pause();
    } else if (e.key === ' ' || e.key === 'k') {
      e.preventDefault();
      player.pause();
    }
  }

  /** Command26 "in" / Command25 "out": the position − 1 s becomes the start / end mark (insr_time1 / upd_time1). */
  markIn(player: HTMLVideoElement): void { this.saveMarkFromPlayer(player, 'start'); }
  markOut(player: HTMLVideoElement): void { this.saveMarkFromPlayer(player, 'end'); }

  private saveMarkFromPlayer(player: HTMLVideoElement, which: 'start' | 'end'): void {
    const sel = this.selectedSubject();
    if (!sel) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    const t = Math.max(0, Math.floor(player.currentTime - 1));
    const h = Math.floor(t / 3600), m = Math.floor((t % 3600) / 60), s = t % 60;
    const cur = this.activeTimeMark();
    const start = which === 'start' ? [h, m, s] : [cur?.startHour ?? 0, cur?.startMinute ?? 0, cur?.startSecond ?? 0];
    const end = which === 'end' ? [h, m, s] : [cur?.endHour ?? null, cur?.endMinute ?? null, cur?.endSecond ?? null];
    this.catalogueService.addTimeDescriptor(this.appNo, {
      tmSerNo: sel.serialNo, tmRltvNo: this.activeRelativeNo(), tmDescNo: sel.descriptorNo,
      tmO: start[0] ?? undefined, tmM: start[1] ?? undefined, tmS: start[2] ?? undefined,
      tmO1: end[0] ?? undefined, tmM1: end[1] ?? undefined, tmS1: end[2] ?? undefined
    }).subscribe({
      next: () => this.catalogueService.getTimeDescriptors(this.appNo).subscribe({ next: r => this.timeDescriptors.set(r.data), error: () => {} }),
      error: e => this.showError(e)
    });
  }

  /** Form2.frm "اغلاق الصفحة" / Esc: Unload Form2 — back to استمارة التوثيق on the same record. */
  /** Command8: tmp_file.Show — Insert there adds a row for this document (op_tmp Form2.Text1). */
  openAdditionalFiles(): void {
    this.dialog.open(AdditionalFilesComponent, {
      hasBackdrop: false, width: '1100px', maxWidth: '96vw', autoFocus: false, panelClass: 'additional-files-window',
      data: { fileNo: this.appNo }
    });
  }

  closePage(): void {
    this.router.navigate(['/catalogue/new'], { queryParams: { appNo: this.appNo } });
  }

  /** Form_KeyPress 27 closes the screen — only when nothing else on it is taking the Esc. */
  @HostListener('document:keydown.escape', ['$event'])
  onEscape(event: Event): void {
    const target = event.target as HTMLElement | null;
    if (event.defaultPrevented || !target) return;
    if (['INPUT', 'TEXTAREA', 'SELECT'].includes(target.tagName) || target.isContentEditable) return;
    if (document.querySelector('.cdk-overlay-container .cdk-overlay-pane')) return;
    if (this.positionsOf()) { this.positionsOf.set(null); return; }
    if (this.isTextOpen() || this.isAddingSubject() || this.isAddingGeo() || this.isAddingTime() || this.isAddingDateSubject()
        || this.isAddingNarrowerOverall() || this.isAddingRelatedOverall() || this.isAddingFileForOverall() || this.isAddingFileAboutOverall()
        || this.isAddingNarrowerRelation() || this.isAddingRelatedRelation() || this.isAddingFileForRelation() || this.isAddingFileAboutRelation()) return;
    this.closePage();
  }

  /** m_mn_result Esc → upd_mn_result. */
  saveAbstract(): void {
    this.catalogueService.saveAbstract(this.appNo, this.abstractCtrl.value).subscribe({
      next: () => { this.abstractCtrl.markAsPristine(); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 2500 }); },
      error: e => this.showError(e)
    });
  }

  /** DBList12 F2: positions (DBList13) of the highlighted name; Esc closes. */
  showPositions(trigger: MatAutocompleteTrigger, current?: FormOption | string | null, list?: FormOption[]): void {
    // DBList12 always has a current row: the highlighted suggestion, else the name already chosen
    // in the box, else the first suggestion shown.
    const highlighted = trigger.activeOption?.value as FormOption | string | undefined;
    const candidates = [highlighted, current, list?.[0]];
    const active = candidates.find((c): c is FormOption => !!c && typeof c !== 'string');
    if (!active) { this.message(this.t.instant('CATALOGUE.POSITIONS_PICK_NAME')); return; }
    const code = (active.formType ?? '') + active.formNo;
    this.autoSvc.getPositionsByFormCode(code).subscribe({
      next: r => {
        this.positions.set((r.data ?? []).map(p => (p.name ?? '').trim()).filter(n => !!n));
        this.positionsOf.set({ code, name: active.name });
        // DBList13.SetFocus — Esc then closes it
        setTimeout(() => (document.querySelector('.positions-popup') as HTMLElement | null)?.focus());
      },
      error: e => this.showError(e)
    });
  }

  /** view_form = pay_form: the list opens on the countries before anything is typed. */
  onFormFocus(target: ReturnType<typeof signal<FormOption[]>>): void {
    if (target().length > 0) return;
    this.autoSvc.searchPaysForm('').subscribe({
      next: r => target.set(r.data?.content ?? []),
      error: () => {}
    });
  }



  // رقم العلاقة stepper — تقدم / تراجع
  // Command3 "تقدم" / Command2 "تراجع": both need a selected descriptor; تراجع never goes below 02.
  nextRelative(): void {
    if (!this.selectedSubject()) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    const n = Number(this.activeRelativeNo()) + 1;
    this.applyRelative(String(n).padStart(2, '0'));
  }

  prevRelative(): void {
    if (!this.selectedSubject()) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    const n = Number(this.activeRelativeNo());
    if (n - 1 > 1) this.applyRelative(String(n - 1).padStart(2, '0'));
  }

  /** Text3_KeyPress Enter: the typed relation number reloads the relation-specific lists. */
  setRelativeNo(value: string): void {
    if (!this.selectedSubject()) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    const n = Number((value ?? '').trim());
    if (!Number.isInteger(n) || n < 0 || n > 99) return;
    this.applyRelative(String(n).padStart(2, '0'));
  }

  private applyRelative(rel: string): void {
    this.activeRelativeNo.set(rel);
    this.reloadOpenText();
    this.seekToActiveMark();
  }

  // --- Subjects (ANALIS) ---
  /**
   * Form2.frm's DBList11 handler never lets the user type a serial number for a
   * new ANALIS row — it takes the highest existing an_ser_no and adds 1, padded
   * to 2 digits only below 10 (01..09, then 10, 11, ...).
   */
  private nextSubjectSerialNo(): string {
    const max = this.subjects().reduce((m, s) => Math.max(m, Number(s.serialNo) || 0), 0);
    return String(max + 1).padStart(2, '0');
  }

  startAddSubject(): void {
    this.replacingSubject.set(null);
    this.subjectForm.reset();
    this.isAddingSubject.set(true);
  }

  /** DBList1 Space / "M" (an_typ = 2): the next pick replaces the selected descriptor (upd_analis). */
  startReplaceSubject(s: SubjectDescriptor): void {
    this.selectedSubject.set(s);
    this.replacingSubject.set(s);
    this.subjectForm.reset();
    this.isAddingSubject.set(true);
  }

  cancelSubjectPicker(): void {
    this.replacingSubject.set(null);
    this.isAddingSubject.set(false);
  }

  onAddSubject(): void {
    if (this.subjectForm.invalid) return;
    const picked = this.subjectForm.getRawValue().descriptorPicker;
    if (!picked || typeof picked === 'string') return;
    const replacing = this.replacingSubject();
    if (replacing) {
      this.catalogueService.replaceSubject(this.appNo, replacing.id, picked.code).subscribe({
        next: r => {
          this.catalogueService.getSubjects(this.appNo).subscribe({ next: x => this.subjects.set(x.data), error: () => {} });
          this.selectedSubject.set(r.data);
          this.subjectForm.reset();
          this.cancelSubjectPicker();
        },
        error: e => this.showError(e)
      });
      return;
    }
    this.catalogueService.addSubject(this.appNo, { descriptorNo: picked.code, serialNo: this.nextSubjectSerialNo() }).subscribe({
      next: () => {
        this.catalogueService.getSubjects(this.appNo).subscribe({ next: r => this.subjects.set(r.data), error: () => {} });
        this.subjectForm.reset();
        this.isAddingSubject.set(false);
      },
      error: e => this.showError(e)
    });
  }

  onDeleteSubject(id: number): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteSubject(this.appNo, id).subscribe({
        next: () => {
          // Cascades server-side (del_analis + del_geo1/rel1/nar1/fad1/time1) — reload everything it touched.
          this.catalogueService.getSubjects(this.appNo).subscribe({ next: r => this.subjects.set(r.data), error: () => {} });
          this.catalogueService.getGeoDescriptors(this.appNo).subscribe({ next: r => this.geoDescriptors.set(r.data), error: () => {} });
          this.catalogueService.getNarrowerTerms(this.appNo).subscribe({ next: r => this.narrowerTerms.set(r.data), error: () => {} });
          this.catalogueService.getRelatedTerms(this.appNo).subscribe({ next: r => this.relatedTerms.set(r.data), error: () => {} });
          this.catalogueService.getFiles(this.appNo).subscribe({ next: r => this.fileRelations.set(r.data), error: () => {} });
          this.catalogueService.getTimeDescriptors(this.appNo).subscribe({ next: r => this.timeDescriptors.set(r.data), error: () => {} });
          if (this.selectedSubject()?.id === id) this.selectedSubject.set(null);
        },
        error: e => this.showError(e)
      });
    });
  }

  // --- Geo ---
  onAddGeo(): void {
    const sel = this.selectedSubject();
    const picked = this.geoForm.getRawValue().geoPicker;
    if (!sel || this.geoForm.invalid || !picked || typeof picked === 'string') return;
    // Form2.frm: m_geo_no = view_form![sub_typ] & view_form![sub_no] — GEO_GEO_NO
    // is the type+number concatenation, not the bare site number alone.
    const geoNo = picked.formType + picked.formNo;
    this.catalogueService.addGeoDescriptor(this.appNo, { descriptorNo: sel.descriptorNo, serialNo: sel.serialNo, geoNo }).subscribe({
      next: () => {
        this.formNames.update(m => ({ ...m, [geoNo]: picked.name }));
        this.catalogueService.getGeoDescriptors(this.appNo).subscribe({ next: r => this.geoDescriptors.set(r.data), error: () => {} });
        this.geoForm.reset();
        this.isAddingGeo.set(false);
      },
      error: e => this.showError(e)
    });
  }

  onDeleteGeo(id: number): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteGeoDescriptor(this.appNo, id).subscribe({
        next: () => this.catalogueService.getGeoDescriptors(this.appNo).subscribe({ next: r => this.geoDescriptors.set(r.data), error: () => {} }),
        error: e => this.showError(e)
      });
    });
  }

  // --- Narrower / Related — overall (type 1) and relation-specific (type 2) ---
  onAddNarrower(relationSpecific: boolean): void {
    const sel = this.selectedSubject();
    const form = relationSpecific ? this.narrowerRelationForm : this.narrowerOverallForm;
    const picked = form.getRawValue().narrowerPicker;
    if (!sel || form.invalid || !picked || typeof picked === 'string') return;
    this.catalogueService.addNarrowerTerm(this.appNo, {
      descriptorNo: sel.descriptorNo,
      serialNo: sel.serialNo,
      relativeNo: relationSpecific ? this.activeRelativeNo() : '01',
      narrowerType: relationSpecific ? '2' : '1',
      narrowerNo: picked.code
    }).subscribe({
      next: () => {
        this.catalogueService.getNarrowerTerms(this.appNo).subscribe({ next: r => this.narrowerTerms.set(r.data), error: () => {} });
        form.reset();
        (relationSpecific ? this.isAddingNarrowerRelation : this.isAddingNarrowerOverall).set(false);
      },
      error: e => this.showError(e)
    });
  }

  onDeleteNarrower(id: number): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteNarrowerTerm(this.appNo, id).subscribe({
        next: () => this.catalogueService.getNarrowerTerms(this.appNo).subscribe({ next: r => this.narrowerTerms.set(r.data), error: () => {} }),
        error: e => this.showError(e)
      });
    });
  }

  onAddRelated(relationSpecific: boolean): void {
    const sel = this.selectedSubject();
    const form = relationSpecific ? this.relatedRelationForm : this.relatedOverallForm;
    const picked = form.getRawValue().relationPicker;
    if (!sel || form.invalid || !picked || typeof picked === 'string') return;
    this.catalogueService.addRelatedTerm(this.appNo, {
      descriptorNo: sel.descriptorNo,
      serialNo: sel.serialNo,
      relativeNo: relationSpecific ? this.activeRelativeNo() : '01',
      relativeType: relationSpecific ? '2' : '1',
      relationNo: picked.code
    }).subscribe({
      next: () => {
        this.catalogueService.getRelatedTerms(this.appNo).subscribe({ next: r => this.relatedTerms.set(r.data), error: () => {} });
        form.reset();
        (relationSpecific ? this.isAddingRelatedRelation : this.isAddingRelatedOverall).set(false);
      },
      error: e => this.showError(e)
    });
  }

  onDeleteRelated(id: number): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteRelatedTerm(this.appNo, id).subscribe({
        next: () => this.catalogueService.getRelatedTerms(this.appNo).subscribe({ next: r => this.relatedTerms.set(r.data), error: () => {} }),
        error: e => this.showError(e)
      });
    });
  }

  // --- File relations — overall/relation-specific x for-it/about-it ---
  onAddFile(relationSpecific: boolean, aboutIt: boolean): void {
    const sel = this.selectedSubject();
    const form = relationSpecific
      ? (aboutIt ? this.fileAboutRelationForm : this.fileForRelationForm)
      : (aboutIt ? this.fileAboutOverallForm : this.fileForOverallForm);
    const picked = form.getRawValue().filePicker;
    if (!sel || form.invalid || !picked || typeof picked === 'string') return;
    this.catalogueService.addFile(this.appNo, {
      descriptorNo: sel.descriptorNo,
      serialNo: sel.serialNo,
      fileType1: relationSpecific ? '2' : '1',
      fileType2: aboutIt ? '2' : '1',
      relativeNo: relationSpecific ? this.activeRelativeNo() : '01',
      // insr_file_add stores view_form![sub_cod] = SUB_TYP + SUB_NO
      fileNo: (picked.formType ?? '') + picked.formNo
    }).subscribe({
      next: () => {
        this.formNames.update(m => ({ ...m, [(picked.formType ?? '') + picked.formNo]: picked.name }));
        this.catalogueService.getFiles(this.appNo).subscribe({ next: r => this.fileRelations.set(r.data), error: () => {} });
        form.reset();
        const flag = relationSpecific
          ? (aboutIt ? this.isAddingFileAboutRelation : this.isAddingFileForRelation)
          : (aboutIt ? this.isAddingFileAboutOverall : this.isAddingFileForOverall);
        flag.set(false);
      },
      error: e => this.showError(e)
    });
  }

  onDeleteFile(id: string): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteFile(this.appNo, id).subscribe({
        next: () => this.catalogueService.getFiles(this.appNo).subscribe({ next: r => this.fileRelations.set(r.data), error: () => {} }),
        error: e => this.showError(e)
      });
    });
  }

  // --- Time marks — the current descriptor+relation's start/end timecode ---
  openTimeEditor(): void {
    if (!this.selectedSubject()) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    const tm = this.activeTimeMark();
    this.timeForm.reset({
      tmO: tm?.startHour ?? null, tmM: tm?.startMinute ?? null, tmS: tm?.startSecond ?? null,
      tmO1: tm?.endHour ?? null, tmM1: tm?.endMinute ?? null, tmS1: tm?.endSecond ?? null
    });
    this.isAddingTime.set(true);
  }

  onSaveTime(): void {
    const sel = this.selectedSubject();
    if (!sel) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    if (this.timeForm.invalid) return;
    const raw = this.timeForm.getRawValue();
    if (raw.tmS === null || raw.tmS === undefined || String(raw.tmS) === '') {
      this.message(AnalysisPanelComponent.MSG_FIRST_FIELD);
      return;
    }
    this.catalogueService.addTimeDescriptor(this.appNo, {
      tmSerNo: sel.serialNo,
      tmRltvNo: this.activeRelativeNo(),
      tmDescNo: sel.descriptorNo,
      tmO: raw.tmO ?? undefined, tmM: raw.tmM ?? undefined, tmS: raw.tmS ?? undefined,
      tmO1: raw.tmO1 ?? undefined, tmM1: raw.tmM1 ?? undefined, tmS1: raw.tmS1 ?? undefined
    }).subscribe({
      next: () => {
        this.catalogueService.getTimeDescriptors(this.appNo).subscribe({ next: r => this.timeDescriptors.set(r.data), error: () => {} });
        this.timeForm.reset();
        this.isAddingTime.set(false);
      },
      error: e => this.showError(e)
    });
  }

  onDeleteTime(serNo: string, rltvNo: string): void {
    this.catalogueService.deleteTimeDescriptor(this.appNo, serNo, rltvNo).subscribe({
      next: () => this.catalogueService.getTimeDescriptors(this.appNo).subscribe({ next: r => this.timeDescriptors.set(r.data), error: () => {} }),
      error: e => this.showError(e)
    });
  }

  // --- Date range — the current descriptor+relation's validity period ---
  openDateEditor(): void {
    if (!this.selectedSubject()) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    const ds = this.activeDateSubject();
    this.dateSubjectForm.reset({
      dteDteDeb: ds?.dteDteDeb ? ds.dteDteDeb.substring(0, 10) : '',
      dteDteFin: ds?.dteDteFin ? ds.dteDteFin.substring(0, 10) : ''
    });
    this.isAddingDateSubject.set(true);
  }

  onSaveDateSubject(): void {
    const sel = this.selectedSubject();
    if (!sel) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    if (this.dateSubjectForm.invalid) return;
    const raw = this.dateSubjectForm.getRawValue();
    this.catalogueService.addDateSubject(this.appNo, {
      dteSerNo: sel.serialNo,
      dteRelNo: this.activeRelativeNo(),
      dteDescNo: sel.descriptorNo,
      // legacy m_dte_deb / m_dte_fin are dates (dd/mm/yyyy masks); the column is a timestamp
      dteDteDeb: raw.dteDteDeb ? raw.dteDteDeb + 'T00:00:00' : undefined,
      dteDteFin: raw.dteDteFin ? raw.dteDteFin + 'T00:00:00' : undefined
    }).subscribe({
      next: () => {
        this.catalogueService.getDateSubjects(this.appNo).subscribe({ next: r => this.dateSubjects.set(r.data), error: () => {} });
        this.dateSubjectForm.reset();
        this.isAddingDateSubject.set(false);
      },
      error: e => this.showError(e)
    });
  }

  onDeleteDateSubject(serNo: string, relNo: string): void {
    this.catalogueService.deleteDateSubject(this.appNo, serNo, relNo).subscribe({
      next: () => this.catalogueService.getDateSubjects(this.appNo).subscribe({ next: r => this.dateSubjects.set(r.data), error: () => {} }),
      error: e => this.showError(e)
    });
  }

  // --- Free text (فتح النص) — Command5: needs a selected descriptor; text of serial + relation ---
  toggleText(): void {
    if (this.isTextOpen()) { this.isTextOpen.set(false); return; }
    if (!this.selectedSubject()) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    this.isTextOpen.set(true);
    this.loadText();
  }

  private reloadOpenText(): void {
    if (this.isTextOpen()) this.loadText();
  }

  private loadText(): void {
    const sel = this.selectedSubject();
    if (!sel) return;
    const key = sel.serialNo + '/' + this.activeRelativeNo();
    this.loadedTextKey = key;
    this.textCtrl.reset('');
    this.highlightedText.set([]);
    this.catalogueService.getAnalysisText(this.appNo, sel.serialNo, this.activeRelativeNo()).subscribe({
      next: r => { if (this.loadedTextKey === key) this.textCtrl.reset(r.data?.text ?? ''); },
      error: e => this.showError(e)
    });
  }

  /** m_txt_text Esc: filter_desc + 3900-character pages (insr_text1 / upd_text1 / del_text2). */
  onSaveText(): void {
    const sel = this.selectedSubject();
    if (!sel) { this.message(AnalysisPanelComponent.MSG_PICK_SUBJECT); return; }
    this.catalogueService.saveAnalysisText(this.appNo, {
      serNo: sel.serialNo, relNo: this.activeRelativeNo(), descNo: sel.descriptorNo, text: this.textCtrl.value
    }).subscribe({
      next: () => {
        this.catalogueService.getText1(this.appNo).subscribe({ next: r => this.text1Items.set(r.data), error: () => {} });
        this.isTextOpen.set(false);
      },
      error: e => this.showError(e)
    });
  }

  /** Command4 "البحث عن كلمة" (HighlightWords): every occurrence of the word, in red. */
  highlightWord(): void {
    const text = this.textCtrl.value ?? '';
    const word = (this.wordCtrl.value ?? '').trim();
    if (!word || !text) { this.highlightedText.set([]); return; }
    const parts: { text: string; hit: boolean }[] = [];
    let from = 0;
    for (let at = text.indexOf(word); at >= 0; at = text.indexOf(word, at + word.length)) {
      if (at > from) parts.push({ text: text.substring(from, at), hit: false });
      parts.push({ text: word, hit: true });
      from = at + word.length;
    }
    if (from < text.length) parts.push({ text: text.substring(from), hit: false });
    this.highlightedText.set(parts.some(p => p.hit) ? parts : []);
  }
}
