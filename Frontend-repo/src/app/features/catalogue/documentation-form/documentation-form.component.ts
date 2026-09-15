import { Component, OnInit, AfterViewInit, OnDestroy, HostListener, ViewChild, ElementRef, inject, signal } from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatAutocompleteSelectedEvent, MatAutocompleteTrigger } from '@angular/material/autocomplete';
import { TranslateService } from '@ngx-translate/core';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { of } from 'rxjs';
import { DocumentationFormService } from '../services/documentation-form.service';
import { CatalogueService } from '../services/catalogue.service';
import { DocumentationFormRequest, DocumentationFormResponse } from '../models/documentation-form.model';
import { CatalogueLinkedAuthor } from '../models/catalogue.models';
import { AutocompleteService, AuthorOption, PeriodicalOption, CodingOption } from '../../../core/services/autocomplete.service';
import { AuthService } from '../../../core/services/auth.service';
import { ConfirmPromptDialogComponent } from './dialogs/confirm-prompt-dialog.component';
import { PasswordGateDialogComponent } from './dialogs/password-gate-dialog.component';
import { GotoRecordDialogComponent } from './dialogs/goto-record-dialog.component';
import { Page2PromptDialogComponent, Page2PromptResult } from './dialogs/page2-prompt-dialog.component';
import { SearchByTitleDialogComponent } from './dialogs/search-by-title-dialog.component';
import { DigitalFilesGridComponent } from '../digital-files-grid/digital-files-grid.component';

@Component({
  standalone: false,
  selector: 'app-documentation-form',
  templateUrl: './documentation-form.component.html',
  styleUrls: ['./documentation-form.component.scss']
})
export class DocumentationFormComponent implements OnInit, AfterViewInit, OnDestroy {

  private fb = inject(FormBuilder);
  private svc = inject(DocumentationFormService);
  private catalogueService = inject(CatalogueService);
  private autoSvc = inject(AutocompleteService);
  private router = inject(Router);
  private dialog = inject(MatDialog);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);
  private authService = inject(AuthService);

  isLoading = signal(false);
  isSaving = signal(false);
  isEditMode = signal(false);
  savedAppNo = signal<string | null>(null);

  linkedAuthors = signal<CatalogueLinkedAuthor[]>([]);
  isAddingAuthor = signal(false);

  sourceCtrl = new FormControl('');
  sourceOptions = signal<PeriodicalOption[]>([]);
  selectedSourceId = signal<number | null>(null);

  translationSourceCtrl = new FormControl('');
  translationSourceOptions = signal<PeriodicalOption[]>([]);
  selectedTranslationSourceId = signal<number | null>(null);

  // ART_LANG ("lang") is a separate column this form has no UI for — it's managed by
  // the standalone article-form screen instead. Round-trip its existing value on save
  // so this form doesn't clobber it; only ART_LANG1 ("lang1") is actually edited here.
  private existingLang = signal<string | null>(null);

  // MN_TRANS on the loaded record — Form6.frm's is_trans() blocks الغاء (Cancel) and
  // gates the فتح صلاحية (Open Permission) lock-status label when this is true.
  isLocked = signal(false);

  authorCtrl = new FormControl('');
  authorOptions = signal<AuthorOption[]>([]);
  selectedAuthorId = signal<number | null>(null);

  // Legacy has no dedicated "edit" button — DBList1/DBList2's SPACE+ENTER on an
  // existing DataGrid2 row corrects the author or resource type in place via
  // upd_res/upd_res1. Non-null means the add-row form is editing this row's id
  // instead of creating a new one.
  editingAuthorId = signal<number | null>(null);

  @ViewChild('filesGrid') filesGrid?: DigitalFilesGridComponent;
  @ViewChild('authorInputEl') authorInputEl?: ElementRef<HTMLInputElement>;

  // Legacy DBList2 (نوع المصدر) is CODING-bound the same way as appDoc/dataEntry —
  // Mid(DBList2.BoundText, 3, 2) confirms the compound-key pattern. Domain prefix "29"
  // is inferred from the only unused CODING-domain artifact left in Form6.frm
  // (view_coding29, otherwise unreferenced) — unlike 01/02/03/34 there's no explicit
  // "XX" + code literal proving this number; verify against real data if available.
  resourceTypeOptions = signal<CodingOption[]>([]);

  // Legacy m_mn_app_doc / m_mn_data_en DataCombos are bound to CODING via the compound
  // SUB_CODE prefixes "01"+code / "02"+code (Form6.frm BoundText) — two disjoint
  // domains fetched independently, not a shared list filtered by SUB_LEVE.
  appDocOptions = signal<CodingOption[]>([]);
  dataEntryOptions = signal<CodingOption[]>([]);

  // Same compound-key CODING pattern for m_art_sub_ty ("03"+code) and m_art_lang
  // ("34"+code). m_art_lang's BoundText is saved into ART_LANG1 (not the separate,
  // legacy-unused ART_LANG column) — see Mid(m_art_lang.BoundText, 3, 2) in Form6.frm.
  subjectTypeOptions = signal<CodingOption[]>([]);
  articleLangOptions = signal<CodingOption[]>([]);

  form = this.fb.group({
    appNo: ['', [Validators.required, Validators.maxLength(7)]],
    entryDate: [null as string | null],
    appDoc: ['', Validators.maxLength(2)],
    dataEntry: ['', Validators.maxLength(2)],
    date: [null as string | null],
    date1: [null as string | null],
    activeTitleAr: ['', Validators.maxLength(125)],
    additionalCatalogueTitle: ['', Validators.maxLength(125)],
    documentNature: ['', Validators.maxLength(1)],
    articleNo: [null as number | null],
    subjectType: ['', Validators.maxLength(2)],
    pageNo: ['', Validators.maxLength(5)],
    lang1: ['', Validators.maxLength(2)],
    result: ['', Validators.maxLength(1000)]
  });

  authorRoleForm = this.fb.group({
    resourceType: ['', Validators.maxLength(2)]
  });

  ngOnInit(): void {
    // Load coding options (Documenter & Data Entry Location)
    this.autoSvc.getCodingByCodePrefix('01').subscribe({
      next: (res) => {
        console.log('Documenter (01) options loaded:', res.data?.length || 0, res.data);
        this.appDocOptions.set(res.data || []);
      },
      error: (err) => {
        console.error('Failed to load Documenter (01) options:', err);
        this.snack.open('خطأ في تحميل الموثق', 'إغلاق', { duration: 5000 });
      }
    });

    this.autoSvc.getCodingByCodePrefix('02').subscribe({
      next: (res) => {
        console.log('Data Entry (02) options loaded:', res.data?.length || 0, res.data);
        this.dataEntryOptions.set(res.data || []);
      },
      error: (err) => {
        console.error('Failed to load Data Entry (02) options:', err);
        this.snack.open('خطأ في تحميل مدخل البيانات', 'إغلاق', { duration: 5000 });
      }
    });

    // Load coding options (Document Type & Language)
    this.autoSvc.getCodingByCodePrefix('03').subscribe({
      next: (res) => {
        console.log('Document Type (03) options loaded:', res.data?.length || 0, res.data);
        this.subjectTypeOptions.set(res.data || []);
      },
      error: (err) => {
        console.error('Failed to load Document Type (03) options:', err);
        this.snack.open('خطأ في تحميل نوع الوثيقة', 'إغلاق', { duration: 5000 });
      }
    });

    this.autoSvc.getCodingByCodePrefix('34').subscribe({
      next: (res) => {
        console.log('Language (34) options loaded:', res.data?.length || 0, res.data);
        this.articleLangOptions.set(res.data || []);
      },
      error: (err) => {
        console.error('Failed to load Language (34) options:', err);
        this.snack.open('خطأ في تحميل اللغة', 'إغلاق', { duration: 5000 });
      }
    });

    this.autoSvc.getCodingByCodePrefix('29').subscribe({
      next: (res) => {
        console.log('Author Type (29) options loaded:', res.data?.length || 0, res.data);
        this.resourceTypeOptions.set(res.data || []);
      },
      error: (err) => {
        console.error('Failed to load Author Type (29) options:', err);
        this.snack.open('خطأ في تحميل نوع المسؤولية', 'إغلاق', { duration: 5000 });
      }
    });

    // Load all periodicals upfront
    this.autoSvc.getAllPeriodicals().subscribe({
      next: (res) => {
        console.log('Periodicals loaded:', res.data?.length || 0, res.data);
        this.sourceOptions.set(res.data || []);
        this.translationSourceOptions.set(res.data || []);
      },
      error: (err) => {
        console.error('Failed to load periodicals:', err);
        this.snack.open('خطأ في تحميل المجلات', 'إغلاق', { duration: 5000 });
      }
    });

    this.sourceCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => {
        if (val && val.length >= 2) {
          return this.autoSvc.searchPeriodicals(val);
        }
        // Return cached options if search is empty
        return of({ data: this.sourceOptions(), success: true, timestamp: '' });
      })
    ).subscribe(r => this.sourceOptions.set(r.data));

    this.translationSourceCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => {
        if (val && val.length >= 2) {
          return this.autoSvc.searchPeriodicals(val);
        }
        // Return cached options if search is empty
        return of({ data: this.translationSourceOptions(), success: true, timestamp: '' });
      })
    ).subscribe(r => this.translationSourceOptions.set(r.data));

    this.authorCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => val && val.length >= 2 ? this.autoSvc.searchAuthors(val) : of({ data: [], success: true, timestamp: '' }))
    ).subscribe(r => this.authorOptions.set(r.data));
  }

  displayPeriodical(opt: PeriodicalOption | string): string {
    if (!opt) return '';
    return typeof opt === 'string' ? opt : opt.name;
  }

  displayAuthor(opt: AuthorOption | string): string {
    if (!opt) return '';
    return typeof opt === 'string' ? opt : opt.name;
  }

  // CODING.SUB_CODE for these two domains is a compound "01"/"02" prefix + 2-char code;
  // MN_APP_DOC/MN_DATA_EN only store the 2-char suffix (see Form6.frm Mid(BoundText, 3, 2)).
  codeSuffix(code: string): string {
    return code.length > 2 ? code.slice(2) : code;
  }

  private toDatetimeLocal(d: Date): string {
    const pad = (n: number) => n.toString().padStart(2, '0');
    return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }

  // mat-select's second click closes because its CDK overlay has a backdrop that
  // intercepts the click before it ever reaches the trigger; mat-autocomplete has
  // no backdrop and MatAutocompleteTrigger's own (click)="_handleClick()" listener
  // reopens the panel whenever it finds panelOpen false — so closing in (mousedown)
  // alone isn't enough: the click event that follows the same physical click still
  // fires afterward and undoes it. document.activeElement in mousedown (which runs
  // before focus/click) distinguishes a genuine second click (already focused +
  // already open) from the first one that's still opening it. That verdict is
  // "armed" here and consumed by a capture-phase document click listener (below),
  // which runs before _handleClick()'s bubble listener on the input can fire at
  // all, so the panel closes exactly once and never reopens itself.
  private armedPeriodicalClose: { trigger: MatAutocompleteTrigger } | null = null;

  onPeriodicalTriggerMouseDown(event: MouseEvent, inputEl: HTMLInputElement, trigger: MatAutocompleteTrigger): void {
    if (document.activeElement === inputEl && trigger.panelOpen) {
      this.armedPeriodicalClose = { trigger };
    }
  }

  private periodicalClickCapture = (event: MouseEvent): void => {
    const armed = this.armedPeriodicalClose;
    if (!armed) return;
    this.armedPeriodicalClose = null;
    event.preventDefault();
    event.stopPropagation();
    armed.trigger.closePanel();
  };

  ngAfterViewInit(): void {
    document.addEventListener('click', this.periodicalClickCapture, true);
  }

  ngOnDestroy(): void {
    document.removeEventListener('click', this.periodicalClickCapture, true);
  }

  // Form6.frm's DataGrid1_KeyDown ("F5" -> op_digit, advancing to the next
  // digitization record) and DBList1_KeyDown ("F8" -> open the author search box)
  // are the two real function-key shortcuts from the legacy screen. Both already
  // have a mouse-driven equivalent here (the files grid's "add" dialog, and the
  // author autocomplete's own type-to-filter) — these bindings just give them the
  // same keyboard shortcut, gated the same way the legacy handlers were (only once
  // a record is loaded / not locked).
  @HostListener('window:keydown', ['$event'])
  handleFunctionKeyShortcuts(event: KeyboardEvent): void {
    if (event.key === 'F5') {
      if (!this.savedAppNo()) return;
      event.preventDefault();
      this.filesGrid?.openAddDialog();
      return;
    }

    if (event.key === 'F8') {
      if (!this.savedAppNo() || this.isLocked()) return;
      event.preventDefault();
      if (!this.isAddingAuthor()) {
        this.isAddingAuthor.set(true);
      }
      setTimeout(() => this.authorInputEl?.nativeElement.focus());
    }
  }

  onSourceSelected(e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as PeriodicalOption;
    this.selectedSourceId.set(opt.perNo);
    this.sourceCtrl.setValue(opt.name, { emitEvent: false });
  }

  onTranslationSourceSelected(e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as PeriodicalOption;
    this.selectedTranslationSourceId.set(opt.perNo);
    this.translationSourceCtrl.setValue(opt.name, { emitEvent: false });
  }

  onAuthorSelected(e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as AuthorOption;
    this.selectedAuthorId.set(opt.id);
    this.authorCtrl.setValue(opt.name, { emitEvent: false });
  }

  private buildRequest(): DocumentationFormRequest {
    const v = this.form.getRawValue();
    return {
      appNo: v.appNo ?? '',
      activeTitleAr: v.activeTitleAr || null,
      additionalCatalogueTitle: v.additionalCatalogueTitle || null,
      dataEntry: v.dataEntry || null,
      appDoc: v.appDoc || null,
      entryDate: v.entryDate || null,
      result: v.result || null,
      documentNature: v.documentNature || null,
      date: v.date || null,
      periodicalNo: this.selectedSourceId(),
      subjectType: v.subjectType || null,
      pageNo: v.pageNo || null,
      articleNo: v.articleNo,
      lang: this.existingLang(),
      lang1: v.lang1 || null,
      date1: v.date1 || null,
      periodical1: this.selectedTranslationSourceId()
    };
  }

  private patchFromResponse(r: DocumentationFormResponse): void {
    // A stale add/edit-author form open from a previously loaded record would
    // otherwise carry editingAuthorId pointing at a row belonging to a different appNo.
    this.onCancelAddAuthor();

    this.form.patchValue({
      appNo: r.appNo,
      entryDate: r.entryDate,
      appDoc: r.appDoc,
      dataEntry: r.dataEntry,
      date: r.date,
      date1: r.date1,
      activeTitleAr: r.catalogueTitle,
      additionalCatalogueTitle: r.additionalTitle,
      documentNature: r.documentNature,
      articleNo: r.articleNo,
      subjectType: r.subjectType,
      pageNo: r.pageNo,
      lang1: r.lang1,
      result: r.result
    });
    this.existingLang.set(r.lang);
    this.isLocked.set(!!r.locked);

    // Set document source (periodicalNo)
    if (r.periodicalNo) {
      this.selectedSourceId.set(r.periodicalNo);
      this.sourceCtrl.setValue(r.periodicalName ?? '', { emitEvent: false });
    }

    // Set translation source (periodical1)
    if (r.periodical1) {
      this.selectedTranslationSourceId.set(r.periodical1);
      const transPeriodical = this.translationSourceOptions().find(p => p.perNo === r.periodical1);
      if (transPeriodical) {
        this.translationSourceCtrl.setValue(transPeriodical.name, { emitEvent: false });
      }
    }

    this.form.get('appNo')?.disable();
    this.isEditMode.set(true);
    this.savedAppNo.set(r.appNo);
    this.loadLinkedAuthors(r.appNo);
  }

  loadLinkedAuthors(appNo: string): void {
    this.catalogueService.getLinkedAuthors(appNo).subscribe({
      next: res => this.linkedAuthors.set(res.data),
      error: () => this.linkedAuthors.set([])
    });
  }

  onAddAuthor(): void {
    const appNo = this.savedAppNo();
    if (!appNo) return;

    // Form6.frm gates every add/edit/delete on this grid through is_trans(box_mn_trans).
    if (this.isLocked()) {
      this.snack.open(this.t.instant('DOC_FORM.CANCEL_BLOCKED_LOCKED'), '', { duration: 4000 });
      return;
    }

    const authorNo = this.selectedAuthorId();
    if (!authorNo) {
      // Matches DBList1_KeyPress's exact empty-list guard message.
      this.snack.open(this.t.instant('DOC_FORM.AUTHOR_LIST_EMPTY'), '', { duration: 3000 });
      return;
    }

    const resourceType = this.authorRoleForm.getRawValue().resourceType ?? '';
    const editId = this.editingAuthorId();
    const op$ = editId
      ? this.catalogueService.updateLinkedAuthor(appNo, editId, { authorNo, resourceType })
      : this.catalogueService.addLinkedAuthor(appNo, { authorNo, resourceType });

    op$.subscribe({
      next: () => {
        this.loadLinkedAuthors(appNo);
        this.onCancelAddAuthor();
      },
      error: () => this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 })
    });
  }

  // ---- Edit an existing row's author or resource type without deleting it
  // (equivalent to DBList1/DBList2's SPACE+ENTER on an existing DataGrid2 row) ----
  onEditAuthor(row: CatalogueLinkedAuthor): void {
    if (this.isLocked()) {
      this.snack.open(this.t.instant('DOC_FORM.CANCEL_BLOCKED_LOCKED'), '', { duration: 4000 });
      return;
    }
    this.editingAuthorId.set(row.id);
    this.selectedAuthorId.set(row.authorNo);
    this.authorCtrl.setValue(row.authorName, { emitEvent: false });
    this.authorRoleForm.patchValue({ resourceType: row.resourceType });
    this.isAddingAuthor.set(true);
  }

  onCancelAddAuthor(): void {
    this.isAddingAuthor.set(false);
    this.authorCtrl.setValue('', { emitEvent: false });
    this.authorRoleForm.reset();
    this.selectedAuthorId.set(null);
    this.editingAuthorId.set(null);
  }

  onRemoveAuthor(id: number): void {
    const appNo = this.savedAppNo();
    if (!appNo) return;
    if (this.isLocked()) {
      this.snack.open(this.t.instant('DOC_FORM.CANCEL_BLOCKED_LOCKED'), '', { duration: 4000 });
      return;
    }
    const ref = this.dialog.open(ConfirmPromptDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { messageKey: 'DOC_FORM.CONFIRM_DELETE_ROW' }
    });
    ref.afterClosed().subscribe(confirmed => {
      if (!confirmed) return;
      this.catalogueService.removeLinkedAuthor(appNo, id).subscribe({
        next: () => this.loadLinkedAuthors(appNo),
        error: () => this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 })
      });
    });
  }

  // ---- Toolbar: سجل جديد ----
  onNewRecord(): void {
    this.form.reset();
    this.form.get('appNo')?.enable();
    this.authorRoleForm.reset();

    // Form6.frm Command2_Click: defaults entry date to today, and appDoc/dataEntry to
    // the logged-in user's own userDoc/userEnt (m_mn_app_doc/m_mn_data_en BoundText).
    const user = this.authService.getCurrentUser();
    this.form.patchValue({
      entryDate: this.toDatetimeLocal(new Date()),
      appDoc: user?.user_doc ?? '',
      dataEntry: user?.user_ent ?? ''
    });

    this.sourceCtrl.setValue('', { emitEvent: false });
    this.translationSourceCtrl.setValue('', { emitEvent: false });
    this.isLocked.set(false);
    this.selectedSourceId.set(null);
    this.selectedTranslationSourceId.set(null);
    this.existingLang.set(null);
    this.linkedAuthors.set([]);
    this.isEditMode.set(false);
    this.savedAppNo.set(null);
  }

  // ---- Toolbar: تسجيل ----
  onSave(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }
    this.isSaving.set(true);
    const req = this.buildRequest();
    const op$ = this.isEditMode()
      ? this.svc.update(req.appNo, req)
      : this.svc.create(req);

    op$.subscribe({
      next: res => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.patchFromResponse(res.data);
      },
      error: () => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
      }
    });
  }

  // ---- Toolbar: بحث (jump directly to a record number) ----
  onSearch(): void {
    this.onGotoRecord();
  }

  // ---- Toolbar: البحث بالعنوان (prompt for a title, load the first match) ----
  onSearchByTitle(): void {
    const ref = this.dialog.open(SearchByTitleDialogComponent, { panelClass: 'doc-form-dialog' });
    ref.afterClosed().subscribe((title: string | null) => {
      if (!title || !title.trim()) return;
      this.svc.searchByTitle(title.trim()).subscribe({
        next: res => {
          const items = res.data.content;
          if (items.length === 0) {
            this.snack.open(this.t.instant('DOC_FORM.NO_MATCH'), '', { duration: 3000 });
            return;
          }
          this.loadRecord(items[0].appNo);
        },
        error: () => this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 })
      });
    });
  }

  // ---- Toolbar: خروج ----
  onExit(): void {
    this.router.navigate(['/catalogue']);
  }

  // ---- Toolbar: الغاء (cancel-form confirmation) ----
  onCancelForm(): void {
    // Form6.frm Command6_Click calls is_trans(box_mn_trans) first, which shows
    // "لا تستطيع التعديل أو الإلغاء ... لأن الوثيقة مقفلة" and blocks the action
    // entirely when the record is locked, instead of opening the confirmation.
    if (this.isLocked()) {
      this.snack.open(this.t.instant('DOC_FORM.CANCEL_BLOCKED_LOCKED'), '', { duration: 4000 });
      return;
    }
    const ref = this.dialog.open(ConfirmPromptDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { messageKey: 'DOC_FORM.CONFIRM_CANCEL_FORM' }
    });
    ref.afterClosed().subscribe(confirmed => {
      if (confirmed) this.onNewRecord();
    });
  }

  // ---- Toolbar: فتح صلاحية (password gate -> unlock) ----
  onOpenPermission(): void {
    const appNo = this.savedAppNo();
    if (!appNo) {
      this.snack.open(this.t.instant('DOC_FORM.NO_RECORD_LOADED'), '', { duration: 3000 });
      return;
    }
    // Form6.frm Command19_Click sets Label17 to "الوثيقة مقفلة"/"الوثيقة مفتوحة" based on
    // the record's actual box_mn_trans state, rather than always assuming locked.
    const ref = this.dialog.open(PasswordGateDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { isLocked: this.isLocked() }
    });
    ref.afterClosed().subscribe(confirmed => {
      if (!confirmed) return;
      this.catalogueService.unlock(appNo).subscribe({
        next: () => {
          this.isLocked.set(false);
          this.snack.open(this.t.instant('DOC_FORM.UNLOCK_SUCCESS'), '', { duration: 3000 });
        },
        error: () => this.snack.open(this.t.instant('DOC_FORM.UNLOCK_DENIED'), '', { duration: 3000 })
      });
    });
  }

  // ---- Toolbar: التحليل (prompt: go to page 2, with/without saving first) ----
  onAnalysis(): void {
    const ref = this.dialog.open(Page2PromptDialogComponent, { panelClass: 'doc-form-dialog' });
    ref.afterClosed().subscribe((result: Page2PromptResult) => {
      if (result === 'with-saving') {
        if (this.form.invalid) {
          this.form.markAllAsTouched();
          return;
        }
        const req = this.buildRequest();
        const op$ = this.isEditMode() ? this.svc.update(req.appNo, req) : this.svc.create(req);
        op$.subscribe({
          next: res => {
            this.patchFromResponse(res.data);
            this.openPage2Dialog();
          },
          error: () => this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 })
        });
      } else if (result === 'without-saving') {
        this.openPage2Dialog();
      }
    });
  }

  // Form6.frm's Command16/14_Click always calls Form2.Show after saving — the actual
  // "Analysis" screen is the subject-taxonomy/relation editor on the catalogue detail
  // page (ANALIS/GEO/NAROWER/RELATIVE/FILE_ADD/TIME/date_subject sections), not the
  // main2-table dialog this used to open (that maps to a different, dead SQL path).
  openPage2Dialog(): void {
    const appNo = this.savedAppNo();
    if (!appNo) return;
    this.router.navigate(['/catalogue', appNo]);
  }

  // ---- Toolbar: سابق / لاحق / الاخير ----
  private goToNeighbour(direction: 'prev' | 'next' | 'last'): void {
    const sort = direction === 'prev' ? 'desc' : 'asc';
    this.svc.findAppNosSorted(direction === 'last' ? 'desc' : sort).subscribe({
      next: res => {
        const items = res.data.content;
        if (items.length === 0) return;
        if (direction === 'last') {
          this.loadRecord(items[0].appNo);
          return;
        }
        const currentAppNo = this.savedAppNo();
        const idx = currentAppNo ? items.findIndex(i => i.appNo === currentAppNo) : -1;
        const target = idx >= 0 && idx + 1 < items.length ? items[idx + 1] : items[0];
        this.loadRecord(target.appNo);
      },
      error: () => this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 })
    });
  }

  onPrevious(): void { this.goToNeighbour('prev'); }
  onNext(): void { this.goToNeighbour('next'); }
  onLast(): void { this.goToNeighbour('last'); }

  loadRecord(appNo: string): void {
    this.isLoading.set(true);
    this.svc.getById(appNo).subscribe({
      next: res => {
        this.isLoading.set(false);
        this.patchFromResponse(res.data);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onGotoRecord(): void {
    const ref = this.dialog.open(GotoRecordDialogComponent, { panelClass: 'doc-form-dialog' });
    ref.afterClosed().subscribe(appNo => {
      if (appNo) this.loadRecord(appNo);
    });
  }
}
