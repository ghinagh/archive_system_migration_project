import { Component, ElementRef, OnInit, ViewChild, inject, signal } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSelect } from '@angular/material/select';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitResult } from '../../digitization/models/digitization.model';
import { AutocompleteService, CodingOption } from '../../../core/services/autocomplete.service';

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
  private autoSvc = inject(AutocompleteService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private fb = inject(FormBuilder);

  // Legacy DataGrid1 (f_result.frm), Column00–13 in order, Column05 (duplicate
  // hidden res_no) excluded — exactly matches the visible 13 legacy columns.
  // No 14th "actions" column — DataGrid1 has no such column, and legacy has
  // no per-row edit/delete affordance in the grid itself.
  displayedColumns = [
    'resultNo', 'catalogueTitle', 'coteDescription', 'catalogueAppNo', 'permitDescription',
    'serial', 'digitNo', 'type', 'date', 'userNo', 'person', 'subject', 'type1Description'
  ];

  items = signal<DigitResult[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(10);
  isLoading = signal(false);

  /** الجهة المستفيدة — m_res_cote DataCombo, CODING domain '32'. */
  coteOptions = signal<CodingOption[]>([]);
  /** الجهة الموافقة — m_res_permit DataCombo, CODING domain '33'. */
  permitOptions = signal<CodingOption[]>([]);
  /** نوع الوثيقة — m_dig_typ1 DataCombo, CODING domain '24'. */
  type1Options = signal<CodingOption[]>([]);

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

  // ===== "معالجة طلبات معينة" Frame2 (Command5 reveal, manually-entered — legacy has no
  // handler on v_res_no that looks up/pre-fills an existing row; see manageSpecificRequests()). =====
  showManagePanel = signal(false);
  manageForm = this.fb.group({
    permit: [''],
    cote: [''],
    person: [''],
    subject: [''],
    resultNo: ['']
  });

  @ViewChild('manageCoteSelect') manageCoteSelect?: MatSelect;
  @ViewChild('managePrsInput') managePrsInput?: ElementRef<HTMLInputElement>;
  @ViewChild('manageSubjectInput') manageSubjectInput?: ElementRef<HTMLInputElement>;
  @ViewChild('manageNoInput') manageNoInput?: ElementRef<HTMLInputElement>;

  ngOnInit(): void {
    // Form_Load resets the filter/question state but never calls d_result.Refresh — the
    // legacy grid opens empty and stays empty until "النتيجة" runs a real search (matches
    // all 4 reference screenshots, which show an empty grid on open).
    this.autoSvc.getCodingByCodePrefix('32').subscribe({ next: r => this.coteOptions.set(r.data || []) });
    this.autoSvc.getCodingByCodePrefix('33').subscribe({ next: r => this.permitOptions.set(r.data || []) });
    this.autoSvc.getCodingByCodePrefix('24').subscribe({ next: r => this.type1Options.set(r.data || []) });
  }

  /** CODING.SUB_CODE is domain(2)+code — legacy strips it via Mid(BoundText,3,2) before querying. */
  codeSuffix(code: string): string {
    return code.length > 2 ? code.slice(2) : code;
  }

  private hasAnyCriteria(): boolean {
    // getRawValue(), not .value — committed fields are disabled (legacy Enabled=False),
    // and FormGroup.value silently drops disabled controls, which would make a locked
    // criterion invisible to this check.
    const v = this.filters.getRawValue();
    return !!(v.dateFrom || v.dateTo || v.title || v.person || v.cote || v.permit
      || v.resultNo || v.digitNo || v.type || v.type1);
  }

  /** Legacy per-field KeyPress(Enter): commits that one field's criterion and locks it
   *  (Enabled=False) — it does NOT execute the search itself; only "النتيجة" does that. */
  commitField(name: string): void {
    const ctrl = this.filters.get(name);
    if (ctrl && ctrl.value) {
      ctrl.disable();
    }
  }

  /** Command1 also locks every currently non-empty field, including ones the user never
   *  pressed Enter on individually. */
  private lockFilledFields(): void {
    Object.values(this.filters.controls).forEach(ctrl => {
      if (ctrl.value) {
        ctrl.disable();
      }
    });
  }

  load(): void {
    this.isLoading.set(true);
    // getRawValue(), not .value — see hasAnyCriteria() for why: a committed (disabled)
    // field's value must still reach the backend as part of the search criteria.
    const v = this.filters.getRawValue();
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

  /** Command1 "النتيجة" — legacy: "يجب طرح السؤال اولا....." when every filter is still empty. */
  applyFilter(): void {
    if (!this.hasAnyCriteria()) {
      this.snackBar.open(this.translate.instant('USAGE_REQUESTS.NO_SEARCH_CRITERIA'), '', { duration: 4000 });
      return;
    }
    this.lockFilledFields();
    this.pageIndex.set(0);
    this.load();
  }

  /** Command4 "بحث جديد" — legacy explicitly sets all 10 fields back to Enabled=True and
   *  clears them; it never calls d_result.Refresh, so the grid keeps showing the previous
   *  result set until "النتيجة" is clicked again with new criteria. */
  clearFilter(): void {
    this.filters.enable();
    this.filters.reset({ dateFrom: '', dateTo: '', title: '', person: '', cote: '', permit: '', resultNo: '', digitNo: '', type: '', type1: '' });
    this.pageIndex.set(0);
  }

  /** Command3 "عدد المقالات" — MsgBox of the current result set's record count. */
  countArticles(): void {
    const count = this.totalElements();
    if (count === 0) {
      this.snackBar.open(this.translate.instant('USAGE_REQUESTS.ARTICLE_COUNT_EMPTY'), '', { duration: 4000 });
    } else {
      this.snackBar.open(this.translate.instant('USAGE_REQUESTS.ARTICLE_COUNT_RESULT', { count }), '', { duration: 4000 });
    }
  }

  /** Command2 "خروج" — legacy: Unload f_result. The code itself calls no other Show/Load —
   *  it relies on f_result.Show being non-modal, so the ARCHIVE menu shell underneath was
   *  never hidden and just reappears. Angular's router has no "still loaded behind" state to
   *  replicate that with; history-back was tried and empirically breaks (verified: navigating
   *  straight to /requests after login, as the sidenav link normally does, sends خروج to
   *  /auth/login). /catalogue is this app's own routing-config definition of its home/menu
   *  route (`{ path: '', redirectTo: 'catalogue' }`) and the same destination already used by
   *  the equivalent exit action on documentation-form.component.ts. */
  onExit(): void { this.router.navigate(['/catalogue']); }

  /** Command5 "معالجة طلبات معينة" — legacy: Frame2.Visible = True. Nothing else — no
   *  field is reset or pre-filled by opening it (matches legacy exactly). */
  manageSpecificRequests(): void {
    this.showManagePanel.set(true);
  }

  /** Command10 "الغاء الامر" — legacy: Frame2.Visible = False only, no data change. */
  closeManagePanel(): void {
    this.showManagePanel.set(false);
  }

  // Legacy v_res_permit_KeyPress: Enter -> v_res_cote.SetFocus + SendKeys "{f4}" (opens it).
  onManagePermitEnter(): void {
    this.manageCoteSelect?.open();
  }

  // Legacy v_res_cote_KeyPress: Enter -> v_res_prs.SetFocus.
  onManageCoteEnter(): void {
    this.managePrsInput?.nativeElement.focus();
  }

  // Legacy v_res_prs_KeyPress: Enter -> v_res_subject.SetFocus.
  onManagePrsEnter(): void {
    this.manageSubjectInput?.nativeElement.focus();
  }

  // Legacy v_res_subject_KeyPress: Enter -> v_res_no.SetFocus.
  onManageSubjectEnter(): void {
    this.manageNoInput?.nativeElement.focus();
  }

  /** Command9 "تعديل" — legacy: "If Not v_res_no.Text = """ is the only guard, then blindly
   *  executes upd_result1 with whatever is currently in the other 4 fields (no lookup of the
   *  existing row happens anywhere in the legacy code). */
  submitManageEdit(): void {
    const v = this.manageForm.value;
    if (!v.resultNo) {
      return;
    }
    this.digitizationService.updateResultByResultNo(v.resultNo, {
      person: v.person || '', cote: v.cote || '', permit: v.permit || '', subject: v.subject || ''
    }).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.showManagePanel.set(false);
        this.load();
      },
      error: () => this.snackBar.open(this.translate.instant('USAGE_REQUESTS.MANAGE_NOT_FOUND'), '', { duration: 4000 })
    });
  }

  /** Command6 "الغاء الطلب" — legacy: "If Not v_res_no.Text = "" And box_user_no = "244""
   *  then executes del_result; if the (hardcoded single-user) check fails, legacy silently
   *  does nothing. Modern equivalent is a real admin-role check enforced backend-side; here
   *  a denial message is shown, matching this app's existing CANCEL_DENIED convention rather
   *  than legacy's total silence on that specific branch. */
  submitManageDelete(): void {
    const resultNo = this.manageForm.value.resultNo;
    if (!resultNo) {
      return;
    }
    this.digitizationService.deleteResultByResultNo(resultNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.showManagePanel.set(false);
        this.load();
      },
      error: () => this.snackBar.open(this.translate.instant('USAGE_REQUESTS.CANCEL_DENIED'), '', { duration: 4000 })
    });
  }

  /** Command11 "اضافة" — legacy has NO Command11_Click handler anywhere in f_result.frm.
   *  Dead button; intentionally left with no behavior rather than inventing one. */
  submitManageAdd(): void {}

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }

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
