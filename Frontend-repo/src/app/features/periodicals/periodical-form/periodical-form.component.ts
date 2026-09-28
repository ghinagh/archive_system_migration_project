import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { of } from 'rxjs';
import { TranslateService } from '@ngx-translate/core';
import { PeriodicalsService } from '../services/periodicals.service';
import { Periodical, PeriodicalRequest } from '../models/periodical.model';
import {
  AutocompleteService,
  AuthorOption,
  FormOption,
  CodingOption
} from '../../../core/services/autocomplete.service';

/**
 * Person/role fields (PER_DIRCT, PER_MOASS, PER_TAHRIR, PER_TAH1, PER_PRESD,
 * PER_PUB) are legacy DBList1 typeaheads bound to "execute serh_allform" — the
 * generic SUB_NAME/SUB_NO "form" table search already exposed as
 * AutocompleteService.searchForms()/getFormByCode(). PER_GEO/PER_GEO1 are a
 * distinct legacy DBCombo bound to "pays_form" (see browsePaysForm/searchPaysForm),
 * not this generic form table — kept in the same FormLookupField union purely to
 * reuse the same typeahead-control plumbing, not because they share a data source.
 */
type FormLookupField = 'geo' | 'geo1' | 'director' | 'institution' | 'editor' | 'editingManager' | 'president' | 'pub';

@Component({
  standalone: false,
  selector: 'app-periodical-form',
  templateUrl: './periodical-form.component.html',
  styleUrls: ['./periodical-form.component.scss']
})
export class PeriodicalFormComponent implements OnInit {

  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(PeriodicalsService);
  private autoSvc = inject(AutocompleteService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isEdit = signal(false);
  isLoading = signal(false);
  isSaving = signal(false);
  perNoParam = signal<number | null>(null);

  // Command10 (بحث): inline "search by number" popup equivalent (legacy Frame2 + m_ist_no).
  showSearchByNo = signal(false);
  searchNoCtrl = new FormControl<number | null>(null);

  // Command8 (البحث بالعنوان): inline "search by title" popup equivalent (legacy Text4 +
  // m_typ_serh=3 -> serh_period1 -> DBList2 picker of matches).
  showSearchByTitle = signal(false);
  searchTitleCtrl = new FormControl('');
  titleSearchResults = signal<Periodical[]>([]);
  titleSearchAttempted = signal(false);

  // PER_PBLSHR: real DBCombo bound to AUTHER (ListField=AUT_NAM, BoundColumn=AUT_NO).
  publisherCtrl = new FormControl('');
  publisherOptions = signal<AuthorOption[]>([]);
  selectedPublisherId = signal<number | null>(null);

  // PER_FREQ / PER_TYP1: DBCombo bound to the shared SUB_DESC/SUB_CODE coding view,
  // filtered by SUB_CODE prefix ("12" for frequency, "13" for acquisition method).
  // PER_FREQ/PER_TYP1 columns are varchar(2) (see V1__baseline_macnz_manar.sql) while
  // CODING.SUB_CODE values in this family are 4 chars ("12"/"13" + 2-digit suffix);
  // the template stores/matches only the 2-digit suffix, consistent with the legacy
  // column width — the prefix is implied by which combo (frequency vs acquisition) is used.
  frequencyOptions = signal<CodingOption[]>([]);
  type1Options = signal<CodingOption[]>([]);

  // Generic typeahead-to-form-code controls (see FormLookupField above).
  formLookupCtrls: Record<FormLookupField, FormControl<string | null>> = {
    geo: new FormControl(''),
    geo1: new FormControl(''),
    director: new FormControl(''),
    institution: new FormControl(''),
    editor: new FormControl(''),
    editingManager: new FormControl(''),
    president: new FormControl(''),
    pub: new FormControl('')
  };
  formLookupOptions: Record<FormLookupField, ReturnType<typeof signal<FormOption[]>>> = {
    geo: signal<FormOption[]>([]),
    geo1: signal<FormOption[]>([]),
    director: signal<FormOption[]>([]),
    institution: signal<FormOption[]>([]),
    editor: signal<FormOption[]>([]),
    editingManager: signal<FormOption[]>([]),
    president: signal<FormOption[]>([]),
    pub: signal<FormOption[]>([])
  };
  private formLookupSelectedCode: Record<FormLookupField, string> = {
    geo: '', geo1: '', director: '', institution: '', editor: '', editingManager: '', president: '', pub: ''
  };

  form = this.fb.group({
    name: [''],
    lang: [''],
    rdmd: [''],
    type1: [''],
    frequency: [''],
    address: [''],
    phone: [''],
    amount: [null as number | null],
    price: [null as number | null],
    price1: [null as number | null],
    fax: [''],
    email: [''],
    website: [''],
    date: [null as string | null],
    utils: [null as number | null]
  });

  ngOnInit(): void {
    // Subscribe (not just snapshot) so سابق/لاحق/بحث, which navigate between
    // ':perNo'/':perNo/edit' routes without destroying this component instance,
    // actually reload the record on every param change.
    this.route.paramMap.subscribe(params => {
      const perNo = params.get('perNo');
      if (perNo) {
        this.isEdit.set(true);
        this.perNoParam.set(Number(perNo));
        this.loadPeriodical(Number(perNo));
      } else {
        this.resetForNew();
      }
    });

    this.publisherCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => val && val.length >= 2 ? this.autoSvc.searchAuthors(val) : of({ data: [], success: true, timestamp: '' }))
    ).subscribe(r => this.publisherOptions.set(r.data));

    this.autoSvc.getCodingByCodePrefix('12').subscribe(r => this.frequencyOptions.set(r.data));
    this.autoSvc.getCodingByCodePrefix('13').subscribe(r => this.type1Options.set(r.data));

    (Object.keys(this.formLookupCtrls) as FormLookupField[]).forEach(field => {
      // geo/geo1 (مكان الصدور 1/2) are bound to the distinct legacy pays_form table,
      // not the generic form table the other five typeahead fields use.
      const search = (val: string) => (field === 'geo' || field === 'geo1')
        ? this.autoSvc.searchPaysForm(val)
        : this.autoSvc.searchForms(val);
      this.formLookupCtrls[field].valueChanges.pipe(
        debounceTime(300),
        distinctUntilChanged(),
        switchMap(val => val && val.length >= 2
          ? search(val)
          : of({ data: { content: [] as FormOption[] }, success: true, timestamp: '' } as any))
      ).subscribe(r => this.formLookupOptions[field].set(r.data.content ?? []));
    });
  }

  /** Command11 (اضافة): next PER_PER_NO = max+1, clear all fields, ready for new entry. */
  resetForNew(): void {
    this.isEdit.set(false);
    this.perNoParam.set(null);
    this.form.reset({ name: '', lang: '', rdmd: '',
      type1: '', frequency: '', address: '', phone: '', amount: null, price: null, price1: null,
      fax: '', email: '', website: '', date: null, utils: null });
    this.publisherCtrl.setValue('', { emitEvent: false });
    this.selectedPublisherId.set(null);
    (Object.keys(this.formLookupCtrls) as FormLookupField[]).forEach(field => {
      this.formLookupCtrls[field].setValue('', { emitEvent: false });
      this.formLookupSelectedCode[field] = '';
    });
    this.showSearchByNo.set(false);
    this.showSearchByTitle.set(false);
    this.svc.getNextPerNo().subscribe({ next: r => this.perNoParam.set(r.data) });
  }

  private loadPeriodical(perNo: number): void {
    this.isLoading.set(true);
    this.svc.getById(perNo).subscribe({
      next: res => {
        const p = res.data;
        this.form.patchValue({
          name: p.name,
          lang: p.lang,
          rdmd: p.rdmd,
          type1: p.type1,
          frequency: p.frequency,
          address: p.address,
          phone: p.phone,
          amount: p.amount,
          price: p.price,
          price1: p.price1,
          fax: p.fax,
          email: p.email,
          website: p.website,
          date: p.date,
          utils: p.utils
        });

        if (p.publisher) {
          this.selectedPublisherId.set(p.publisher);
          this.publisherCtrl.setValue(String(p.publisher), { emitEvent: false });
        }

        const fieldValues: Record<FormLookupField, string> = {
          geo: p.geo, geo1: p.geo1, director: p.director, institution: p.institution,
          editor: p.editor, editingManager: p.editingManager, president: p.president, pub: p.pub
        };
        (Object.keys(fieldValues) as FormLookupField[]).forEach(field => {
          const code = fieldValues[field];
          if (code) {
            this.formLookupSelectedCode[field] = code;
            // Resolve the stored code to its display name (legacy ListField=sub_name).
            const resolve = (field === 'geo' || field === 'geo1')
              ? this.autoSvc.getPaysFormByCode(code)
              : this.autoSvc.getFormByCode(code);
            resolve.subscribe({
              next: fr => this.formLookupCtrls[field].setValue(fr.data.name, { emitEvent: false }),
              error: () => this.formLookupCtrls[field].setValue(code, { emitEvent: false })
            });
          }
        });

        this.isLoading.set(false);
      },
      error: () => { this.isLoading.set(false); this.router.navigate(['/periodicals']); }
    });
  }

  displayAuthor(opt: AuthorOption | string): string {
    if (!opt) return '';
    return typeof opt === 'string' ? opt : opt.name;
  }

  displayFormOption(opt: FormOption | string): string {
    if (!opt) return '';
    return typeof opt === 'string' ? opt : opt.name;
  }

  onPublisherSelected(e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as AuthorOption;
    this.selectedPublisherId.set(opt.id);
    this.publisherCtrl.setValue(opt.name, { emitEvent: false });
  }

  /** دار النشر (Publisher): same DBCombo-parity "browse all on arrow click" as geo/geo1. */
  browseAuthors(trigger: { openPanel: () => void }): void {
    this.autoSvc.searchAuthors('').subscribe(r => {
      this.publisherOptions.set(r.data);
      trigger.openPanel();
    });
  }

  /**
   * مكان الصدور 1/2 (geo1/geo): legacy DBCombo lets the user click the dropdown
   * arrow to browse the full pays_form list, not just filter by typing. The
   * mat-autocomplete input has no visible arrow by default, so this backs a
   * suffix icon button that fetches an unfiltered page and opens the panel.
   * The panel must open AFTER the options arrive — opening it synchronously
   * alongside the HTTP call shows a stale/empty panel since MatAutocomplete
   * renders whatever formLookupOptions held at the moment openPanel() ran.
   */
  browsePaysForm(field: 'geo' | 'geo1', trigger: { openPanel: () => void }): void {
    this.autoSvc.searchPaysForm('').subscribe(r => {
      this.formLookupOptions[field].set(r.data.content ?? []);
      trigger.openPanel();
    });
  }

  onFormLookupSelected(field: FormLookupField, e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as FormOption;
    this.formLookupSelectedCode[field] = opt.formNo;
    this.formLookupCtrls[field].setValue(opt.name, { emitEvent: false });
  }

  onSubmit(): void {
    if (this.perNoParam() == null) {
      this.snack.open(this.t.instant('PERIODICALS.NO_ACTIVE_RECORD'), '', { duration: 3000 });
      return;
    }
    const v = this.form.value;
    const req: PeriodicalRequest = {
      // Backend PeriodicalRequest.perNo is @NotNull — the legacy INSR_period/UPD_period
      // procs both key off PER_PER_NO explicitly, so we must send the number the form
      // is showing (assigned via /next-no for a new record, or the loaded record's own
      // number when editing) rather than leaving it server-assigned.
      perNo: this.perNoParam()!,
      name: v.name ?? '',
      lang: v.lang ?? '',
      rdmd: v.rdmd ?? '',
      geo: this.formLookupSelectedCode.geo,
      type1: v.type1 ?? '',
      frequency: v.frequency ?? '',
      address: v.address ?? '',
      phone: v.phone ?? '',
      amount: v.amount ?? null,
      price: v.price ?? null,
      price1: v.price1 ?? null,
      publisher: this.selectedPublisherId(),
      pub: this.formLookupSelectedCode.pub,
      institution: this.formLookupSelectedCode.institution,
      editor: this.formLookupSelectedCode.editor,
      director: this.formLookupSelectedCode.director,
      president: this.formLookupSelectedCode.president,
      fax: v.fax ?? '',
      email: v.email ?? '',
      website: v.website ?? '',
      date: v.date ?? null,
      utils: v.utils ?? null,
      geo1: this.formLookupSelectedCode.geo1,
      editingManager: this.formLookupSelectedCode.editingManager
    };

    this.isSaving.set(true);
    const op$ = this.isEdit()
      ? this.svc.update(this.perNoParam()!, req)
      : this.svc.create(req);

    op$.subscribe({
      next: res => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.router.navigate(['/periodicals', res.data.perNo]);
      },
      error: () => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
      }
    });
  }

  /** Command6 (لاحق). */
  goToNext(): void {
    const perNo = this.perNoParam();
    if (perNo == null) {
      this.snack.open(this.t.instant('PERIODICALS.NO_ACTIVE_RECORD'), '', { duration: 3000 });
      return;
    }
    this.svc.getNext(perNo).subscribe({
      next: r => this.router.navigate(['/periodicals', r.data.perNo, 'edit']),
      error: () => this.snack.open(this.t.instant('PERIODICALS.NO_NEXT'), '', { duration: 3000 })
    });
  }

  /** Command5 (سابق). */
  goToPrevious(): void {
    const perNo = this.perNoParam();
    if (perNo == null) {
      this.snack.open(this.t.instant('PERIODICALS.NO_ACTIVE_RECORD'), '', { duration: 3000 });
      return;
    }
    this.svc.getPrevious(perNo).subscribe({
      next: r => this.router.navigate(['/periodicals', r.data.perNo, 'edit']),
      error: () => this.snack.open(this.t.instant('PERIODICALS.NO_PREVIOUS'), '', { duration: 3000 })
    });
  }

  /** Command11 (اضافة). */
  addNew(): void {
    this.router.navigate(['/periodicals']);
    this.resetForNew();
  }

  /** Command7/Command2 (الغاء): cancel/delete current record after a Y/N confirm. */
  onDelete(): void {
    const perNo = this.perNoParam();
    if (perNo == null) {
      this.snack.open(this.t.instant('PERIODICALS.NO_ACTIVE_RECORD'), '', { duration: 3000 });
      return;
    }
    if (!confirm(this.t.instant('PERIODICALS.CONFIRM_CANCEL_FORM'))) return;
    this.svc.delete(perNo).subscribe({
      next: () => {
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.resetForNew();
      }
    });
  }

  /** Command1 (خروج): leave this screen entirely — same convention as other screens' exit (back to catalogue/dashboard). */
  exit(): void {
    this.router.navigate(['/catalogue']);
  }

  /** Command10/Command12 (بحث): open the inline number-entry popup and load that record. */
  toggleSearchByNo(): void {
    this.showSearchByTitle.set(false);
    this.showSearchByNo.set(!this.showSearchByNo());
    this.searchNoCtrl.setValue(null);
  }

  searchByNumber(): void {
    const no = this.searchNoCtrl.value;
    if (no == null) return;
    this.svc.getById(no).subscribe({
      next: () => {
        this.showSearchByNo.set(false);
        this.router.navigate(['/periodicals', no, 'edit']);
      },
      error: () => this.snack.open(this.t.instant('PERIODICALS.NOT_FOUND'), '', { duration: 3000 })
    });
  }

  /** Command8 (البحث بالعنوان): inline title-entry popup, matches shown for picking (legacy DBList2). */
  toggleSearchByTitle(): void {
    this.showSearchByNo.set(false);
    this.showSearchByTitle.set(!this.showSearchByTitle());
    this.searchTitleCtrl.setValue('');
    this.titleSearchResults.set([]);
    this.titleSearchAttempted.set(false);
  }

  searchByTitle(): void {
    const q = (this.searchTitleCtrl.value || '').trim();
    if (!q) return;
    this.svc.searchByTitle(q).subscribe({
      next: r => { this.titleSearchResults.set(r.data); this.titleSearchAttempted.set(true); },
      error: () => { this.titleSearchResults.set([]); this.titleSearchAttempted.set(true); }
    });
  }

  selectTitleMatch(p: Periodical): void {
    this.showSearchByTitle.set(false);
    this.router.navigate(['/periodicals', p.perNo, 'edit']);
  }
}
