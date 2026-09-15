import { Component, Input, OnChanges, SimpleChanges, computed, inject, signal } from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { of } from 'rxjs';
import { CatalogueService } from '../services/catalogue.service';
import { AutocompleteService, MacnzOption, FormOption } from '../../../core/services/autocomplete.service';
import { ConfirmPromptDialogComponent } from '../documentation-form/dialogs/confirm-prompt-dialog.component';
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

  isCollapsed = signal(false);

  private catalogueService = inject(CatalogueService);
  private autoSvc = inject(AutocompleteService);
  private fb = inject(FormBuilder);
  private dialog = inject(MatDialog);

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
  private resolvingFormCodes = new Set<string>();

  selectedSubject = signal<SubjectDescriptor | null>(null);
  activeRelativeNo = signal<string>('01');

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

  private matchesSelected(descriptorNo: string, serialNo: string): boolean {
    const sel = this.selectedSubject();
    return !!sel && sel.descriptorNo === descriptorNo && sel.serialNo === serialNo;
  }

  overallNarrower = computed(() => this.narrowerTerms().filter(n => n.narrowerType !== '2' && this.matchesSelected(n.descriptorNo, n.serialNo)));
  overallRelated = computed(() => this.relatedTerms().filter(r => r.relativeType !== '2' && this.matchesSelected(r.descriptorNo, r.serialNo)));
  overallGeo = computed(() => this.geoDescriptors().filter(g => this.matchesSelected(g.descriptorNo, g.serialNo)));
  overallFileFor = computed(() => this.fileRelations().filter(f => f.fileType1 !== '2' && f.fileType2 !== '2' && this.matchesSelected(f.descriptorNo, f.serialNo)));
  overallFileAbout = computed(() => this.fileRelations().filter(f => f.fileType1 !== '2' && f.fileType2 === '2' && this.matchesSelected(f.descriptorNo, f.serialNo)));

  relationNarrower = computed(() => this.narrowerTerms().filter(n => n.narrowerType === '2' && n.relativeNo === this.activeRelativeNo() && this.matchesSelected(n.descriptorNo, n.serialNo)));
  relationRelated = computed(() => this.relatedTerms().filter(r => r.relativeType === '2' && r.relativeNo === this.activeRelativeNo() && this.matchesSelected(r.descriptorNo, r.serialNo)));
  relationFileFor = computed(() => this.fileRelations().filter(f => f.fileType1 === '2' && f.fileType2 !== '2' && f.relativeNo === this.activeRelativeNo() && this.matchesSelected(f.descriptorNo, f.serialNo)));
  relationFileAbout = computed(() => this.fileRelations().filter(f => f.fileType1 === '2' && f.fileType2 === '2' && f.relativeNo === this.activeRelativeNo() && this.matchesSelected(f.descriptorNo, f.serialNo)));

  activeTimeMark = computed(() => this.timeDescriptors().find(t =>
    t.rltvNo === this.activeRelativeNo() && (this.selectedSubject() ? t.descNo === this.selectedSubject()!.descriptorNo : true)
  ) ?? null);

  activeDateSubject = computed(() => this.dateSubjects().find(d =>
    d.dteRelNo === this.activeRelativeNo() && (this.selectedSubject() ? d.dteDescNo === this.selectedSubject()!.descriptorNo : true)
  ) ?? null);

  activeText = computed(() => this.text1Items().find(t =>
    t.txtRltvN === this.activeRelativeNo() && (this.selectedSubject() ? t.txtDescN === this.selectedSubject()!.descriptorNo : true)
  ) ?? null);

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

  textForm = this.fb.group({
    txtSerNo: ['', [Validators.required, Validators.maxLength(2)]],
    txtText: ['', Validators.maxLength(4000)]
  });

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['appNo'] && this.appNo) {
      this.loadAll();
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
        if (q.length < 2) return of({ data: { content: [] as FormOption[] } });
        return this.autoSvc.searchForms(q);
      })
    ).subscribe(r => target.set(r.data.content));
  }

  private matchesSearch(code: string, description: string, q: string): boolean {
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
    return this.macnzOptions().find(o => o.code === code)?.description ?? '';
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
      const lookupCode = stripTypePrefix ? code.slice(2) : code;
      this.autoSvc.getFormByCode(lookupCode).subscribe({
        next: r => this.formNames.update(m => ({ ...m, [code]: r.data.name })),
        error: () => {},
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
  }

  toggleCollapsed(): void {
    this.isCollapsed.update(v => !v);
  }

  // رقم العلاقة stepper — تقدم / تراجع
  nextRelative(): void {
    const n = Number(this.activeRelativeNo()) + 1;
    this.activeRelativeNo.set(String(n).padStart(2, '0'));
  }

  prevRelative(): void {
    const n = Math.max(1, Number(this.activeRelativeNo()) - 1);
    this.activeRelativeNo.set(String(n).padStart(2, '0'));
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

  onAddSubject(): void {
    if (this.subjectForm.invalid) return;
    const picked = this.subjectForm.getRawValue().descriptorPicker;
    if (!picked || typeof picked === 'string') return;
    this.catalogueService.addSubject(this.appNo, { descriptorNo: picked.code, serialNo: this.nextSubjectSerialNo() }).subscribe({
      next: () => {
        this.catalogueService.getSubjects(this.appNo).subscribe({ next: r => this.subjects.set(r.data), error: () => {} });
        this.subjectForm.reset();
        this.isAddingSubject.set(false);
      },
      error: () => {}
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
        error: () => {}
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
      error: () => {}
    });
  }

  onDeleteGeo(id: number): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteGeoDescriptor(this.appNo, id).subscribe({
        next: () => this.catalogueService.getGeoDescriptors(this.appNo).subscribe({ next: r => this.geoDescriptors.set(r.data), error: () => {} }),
        error: () => {}
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
      relativeNo: relationSpecific ? this.activeRelativeNo() : undefined,
      narrowerType: relationSpecific ? '2' : '1',
      narrowerNo: picked.code
    }).subscribe({
      next: () => {
        this.catalogueService.getNarrowerTerms(this.appNo).subscribe({ next: r => this.narrowerTerms.set(r.data), error: () => {} });
        form.reset();
        (relationSpecific ? this.isAddingNarrowerRelation : this.isAddingNarrowerOverall).set(false);
      },
      error: () => {}
    });
  }

  onDeleteNarrower(id: number): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteNarrowerTerm(this.appNo, id).subscribe({
        next: () => this.catalogueService.getNarrowerTerms(this.appNo).subscribe({ next: r => this.narrowerTerms.set(r.data), error: () => {} }),
        error: () => {}
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
      relativeNo: relationSpecific ? this.activeRelativeNo() : undefined,
      relativeType: relationSpecific ? '2' : '1',
      relationNo: picked.code
    }).subscribe({
      next: () => {
        this.catalogueService.getRelatedTerms(this.appNo).subscribe({ next: r => this.relatedTerms.set(r.data), error: () => {} });
        form.reset();
        (relationSpecific ? this.isAddingRelatedRelation : this.isAddingRelatedOverall).set(false);
      },
      error: () => {}
    });
  }

  onDeleteRelated(id: number): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteRelatedTerm(this.appNo, id).subscribe({
        next: () => this.catalogueService.getRelatedTerms(this.appNo).subscribe({ next: r => this.relatedTerms.set(r.data), error: () => {} }),
        error: () => {}
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
      relativeNo: relationSpecific ? this.activeRelativeNo() : undefined,
      fileNo: picked.formNo
    }).subscribe({
      next: () => {
        this.formNames.update(m => ({ ...m, [picked.formNo]: picked.name }));
        this.catalogueService.getFiles(this.appNo).subscribe({ next: r => this.fileRelations.set(r.data), error: () => {} });
        form.reset();
        const flag = relationSpecific
          ? (aboutIt ? this.isAddingFileAboutRelation : this.isAddingFileForRelation)
          : (aboutIt ? this.isAddingFileAboutOverall : this.isAddingFileForOverall);
        flag.set(false);
      },
      error: () => {}
    });
  }

  onDeleteFile(id: string): void {
    this.confirmDelete(() => {
      this.catalogueService.deleteFile(this.appNo, id).subscribe({
        next: () => this.catalogueService.getFiles(this.appNo).subscribe({ next: r => this.fileRelations.set(r.data), error: () => {} }),
        error: () => {}
      });
    });
  }

  // --- Time marks — the current descriptor+relation's start/end timecode ---
  onSaveTime(): void {
    const sel = this.selectedSubject();
    if (!sel || this.timeForm.invalid) return;
    const raw = this.timeForm.getRawValue();
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
      error: () => {}
    });
  }

  onDeleteTime(serNo: string, rltvNo: string): void {
    this.catalogueService.deleteTimeDescriptor(this.appNo, serNo, rltvNo).subscribe({
      next: () => this.catalogueService.getTimeDescriptors(this.appNo).subscribe({ next: r => this.timeDescriptors.set(r.data), error: () => {} }),
      error: () => {}
    });
  }

  // --- Date range — the current descriptor+relation's validity period ---
  onSaveDateSubject(): void {
    const sel = this.selectedSubject();
    if (!sel || this.dateSubjectForm.invalid) return;
    const raw = this.dateSubjectForm.getRawValue();
    this.catalogueService.addDateSubject(this.appNo, {
      dteSerNo: sel.serialNo,
      dteRelNo: this.activeRelativeNo(),
      dteDescNo: sel.descriptorNo,
      dteDteDeb: raw.dteDteDeb || undefined,
      dteDteFin: raw.dteDteFin || undefined
    }).subscribe({
      next: () => {
        this.catalogueService.getDateSubjects(this.appNo).subscribe({ next: r => this.dateSubjects.set(r.data), error: () => {} });
        this.dateSubjectForm.reset();
        this.isAddingDateSubject.set(false);
      },
      error: () => {}
    });
  }

  onDeleteDateSubject(serNo: string, relNo: string): void {
    this.catalogueService.deleteDateSubject(this.appNo, serNo, relNo).subscribe({
      next: () => this.catalogueService.getDateSubjects(this.appNo).subscribe({ next: r => this.dateSubjects.set(r.data), error: () => {} }),
      error: () => {}
    });
  }

  // --- Free text (فتح النص) — the current descriptor+relation's attached text ---
  toggleText(): void {
    if (!this.isTextOpen()) {
      const existing = this.activeText();
      this.textForm.reset({ txtSerNo: existing?.txtSerNo ?? '', txtText: existing?.txtText ?? '' });
    }
    this.isTextOpen.update(v => !v);
  }

  onSaveText(): void {
    const sel = this.selectedSubject();
    if (!sel || this.textForm.invalid) return;
    const raw = this.textForm.getRawValue();
    const existing = this.activeText();
    const req = {
      txtSerNo: raw.txtSerNo!,
      txtDescN: sel.descriptorNo,
      txtRltvN: this.activeRelativeNo(),
      txtRltvTyp: '2',
      txtText: raw.txtText || undefined
    };
    const action$ = existing
      ? this.catalogueService.updateText1(this.appNo, existing.txtSerNo, req)
      : this.catalogueService.createText1(this.appNo, req);
    action$.subscribe({
      next: () => {
        this.catalogueService.getText1(this.appNo).subscribe({ next: r => this.text1Items.set(r.data), error: () => {} });
        this.isTextOpen.set(false);
      },
      error: () => {}
    });
  }
}
