import { Component, OnInit, inject, signal } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { catchError, of } from 'rxjs';
import { debounceTime, distinctUntilChanged, switchMap, map } from 'rxjs/operators';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitRecord, DigitRecordRequest } from '../../digitization/models/digitization.model';
import { AutocompleteService, CodingOption, FormOption } from '../../../core/services/autocomplete.service';

@Component({
  standalone: false,
  selector: 'app-digit-record-dialog',
  templateUrl: './digit-record-dialog.component.html',
  styleUrls: ['./digit-record-dialog.component.scss']
})
export class DigitRecordDialogComponent implements OnInit {

  private fb = inject(FormBuilder);
  private digitizationService = inject(DigitizationService);
  private autoSvc = inject(AutocompleteService);
  dialogRef = inject(MatDialogRef<DigitRecordDialogComponent>);
  data = inject<{ docNo: string; nextSerial: number; record: DigitRecord | null }>(MAT_DIALOG_DATA);

  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  /**
   * A signal, not a plain field: this app has no zone.js, so a plain boolean reassigned inside an
   * HTTP callback never schedules a re-render. After a failed upload the Save button stayed
   * disabled with no feedback (and dev builds reported it as NG0100).
   */
  isSaving = signal(false);
  isEditMode = !!this.data.record;

  /**
   * Legacy never let the operator type DIG_DIG_NO — Column04's space-bar only opens
   * CommonDialog1.ShowOpen when the cell is empty (Form6.frm:3568-3576); the number and
   * DIG_TYP (extension) are always server-generated from the selected file. A free-text
   * digitNo box in create mode would let the browser fabricate a number legacy never allowed,
   * so it is a file picker instead; in edit mode the already-generated value is shown read-only.
   */
  selectedFile: File | null = null;
  fileError: string | null = null;
  uploadClasses = new Set(['01', '02', '03', '05']);

  form = this.fb.group({
    type: [this.data.record?.type ?? '', Validators.maxLength(4)],
    highType: [this.data.record?.highType ?? '', Validators.maxLength(3)],
    // Legacy Column02 "شكل الوثيقة" (desc_typ1) — Locked=True, SPACE opens DBList4.
    // CODING domain '24' PROVEN (user_inetrface.frm Form_Load: "'24'+ dig_typ1 = CODING.SUB_CODE").
    type1: [this.data.record?.type1 ?? '', Validators.maxLength(2)],
    // Legacy Column05 "نوع المادة" (desc_typmat) — Locked=True, SPACE opens DBList6.
    // Exact CODING domain NOT FOUND in source; unfiltered CODING list used (documented below).
    materialType: [this.data.record?.materialType ?? '', Validators.maxLength(2)],
    size: [this.data.record?.size ?? null as number | null],
    durationHours: [this.data.record?.durationHours ?? 0],
    durationMinutes: [this.data.record?.durationMinutes ?? 0],
    durationSeconds: [this.data.record?.durationSeconds ?? 0],
    durationHours1: [this.data.record?.durationHours1 ?? 0],
    durationMinutes1: [this.data.record?.durationMinutes1 ?? 0],
    durationSeconds1: [this.data.record?.durationSeconds1 ?? 0],
    // Legacy Column15 "نوع الشريط" (desc_typchrt) — Locked=True, SPACE opens DBList5.
    // Exact CODING domain NOT FOUND in source; unfiltered CODING list used (documented below).
    chartType: [this.data.record?.chartType ?? '', Validators.maxLength(2)],
    chartNo: [this.data.record?.chartNo ?? '', Validators.maxLength(6)],
    newChartNo: [this.data.record?.newChartNo ?? '', Validators.maxLength(6)]
  });

  /** Legacy Column16 "مكان التصوير/النشر" (desc_geo) — Locked=True, SPACE opens DBList12
   *  (ListField=SUB_NAME/BoundColumn=sub_cod) — the same "form"/sites table lookup already
   *  proven and reused for شاشة البحث's geo/file fields, not a CODING domain. */
  chartGeoCtrl = new FormControl<string | FormOption | null>(
    this.data.record?.chartGeoName ?? this.data.record?.chartGeo ?? ''
  );
  chartGeoOptions = signal<FormOption[]>([]);

  /** Domain '24' — PROVEN. */
  type1Options = signal<CodingOption[]>([]);
  /** Unfiltered CODING — domain NOT FOUND for either; closest defensible source, shared. */
  unresolvedDomainOptions = signal<CodingOption[]>([]);

  displayForm = (value: string | FormOption | null): string =>
    typeof value === 'string' ? value : (value?.name ?? '');

  ngOnInit(): void {
    this.autoSvc.getCodingByCodePrefix('24').subscribe({
      next: r => this.type1Options.set(r.data ?? []),
      error: () => this.type1Options.set([])
    });
    this.autoSvc.getCoding().subscribe({
      next: r => this.unresolvedDomainOptions.set(r.data ?? []),
      error: () => this.unresolvedDomainOptions.set([])
    });

    this.chartGeoCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(term => {
        const q = typeof term === 'string' ? term.trim() : '';
        if (q.length < 2) return of<FormOption[]>([]);
        return this.autoSvc.searchForms(q).pipe(
          map(r => r.data?.content ?? []),
          catchError(() => of<FormOption[]>([]))
        );
      })
    ).subscribe(opts => this.chartGeoOptions.set(opts));
  }

  /** CODING.SUB_CODE is domain(2)+tail — every CODING-bound field in this legacy app strips
   *  it via Mid(x,3,2) before storing/comparing (proven repeatedly elsewhere in this codebase).
   *  Applied here too for materialType/chartType even though their exact domain number is NOT
   *  FOUND, since DigitEntity's columns are 2-char and the stripping convention is consistent
   *  app-wide — not a guess about which domain, just the established tail-only storage shape. */
  codeSuffix(code: string): string {
    return code.length > 2 ? code.slice(2) : code;
  }

  private codeOf(value: string | FormOption | null): string | undefined {
    if (value == null) return undefined;
    if (typeof value === 'string') return value.trim() || undefined;
    return value.formNo || undefined;
  }

  /** Legacy Form6.frm datagrid1_KeyPress (:3574) never sends "04" through the browse dialog —
   *  video is ingested through the tape/ranjpath pipeline, not this screen. Mirrors the same
   *  gate MediaService.isNonVideoAssetClass enforces server-side. */
  get canAttachFile(): boolean {
    const type1 = this.form.getRawValue().type1;
    return !!type1 && this.uploadClasses.has(type1);
  }

  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    const file = input.files && input.files.length > 0 ? input.files[0] : null;
    this.fileError = null;
    if (file && !/\.[A-Za-z0-9]{1,4}$/.test(file.name)) {
      this.fileError = 'الملف المحدد لا يحمل امتداداً صالحاً';
      this.selectedFile = null;
      input.value = '';
      return;
    }
    this.selectedFile = file;
  }

  clearSelectedFile(): void {
    this.selectedFile = null;
    this.fileError = null;
  }

  onSave(): void {
    if (this.form.invalid || this.isSaving()) return;
    this.isSaving.set(true);
    const raw = this.form.getRawValue();

    if (!this.isEditMode && this.selectedFile) {
      this.digitizationService.uploadRecord(
        this.data.docNo,
        this.data.nextSerial,
        raw.type1!,
        this.selectedFile,
        {
          // No `size` here: legacy's upload flow (max_digit/op_digit) never writes DIG_SIZE —
          // confirmed against the DDL, no stored procedure touches it. Not fabricating it.
          highType: raw.highType || undefined,
          materialType: raw.materialType || undefined,
          durationHours: raw.durationHours ?? undefined,
          durationMinutes: raw.durationMinutes ?? undefined,
          durationSeconds: raw.durationSeconds ?? undefined,
          durationHours1: raw.durationHours1 ?? undefined,
          durationMinutes1: raw.durationMinutes1 ?? undefined,
          durationSeconds1: raw.durationSeconds1 ?? undefined,
          chartType: raw.chartType || undefined,
          chartNo: raw.chartNo || undefined,
          newChartNo: raw.newChartNo || undefined,
          chartGeo: this.codeOf(this.chartGeoCtrl.value)
        }
      ).subscribe({
        next: () => this.dialogRef.close(true),
        error: (err: HttpErrorResponse) => this.onSaveError(err)
      });
      return;
    }

    // No file attached: preserves legacy's other real capability — DataGrid1_KeyUp's Insert
    // key creates a blank row (insr_digit1, DDL :6297) with no digitNo until a file is picked
    // later. digitNo has no form control any more (it's always server-generated by the upload
    // above), so on an EDIT it must be echoed back from the existing record explicitly — the
    // mapper sets any omitted field to null on update, which would otherwise wipe an
    // already-generated digitNo. On a brand-new blank row it's correctly left undefined,
    // matching insr_digit1's bare insert.
    const req: DigitRecordRequest = {
      docNo: this.data.docNo,
      serial: this.isEditMode ? this.data.record!.serial : this.data.nextSerial,
      digitNo: this.isEditMode ? (this.data.record!.digitNo || undefined) : undefined,
      type: raw.type || undefined,
      highType: raw.highType || undefined,
      type1: raw.type1 || undefined,
      materialType: raw.materialType || undefined,
      size: raw.size ?? undefined,
      durationHours: raw.durationHours ?? undefined,
      durationMinutes: raw.durationMinutes ?? undefined,
      durationSeconds: raw.durationSeconds ?? undefined,
      durationHours1: raw.durationHours1 ?? undefined,
      durationMinutes1: raw.durationMinutes1 ?? undefined,
      durationSeconds1: raw.durationSeconds1 ?? undefined,
      chartType: raw.chartType || undefined,
      chartNo: raw.chartNo || undefined,
      newChartNo: raw.newChartNo || undefined,
      chartGeo: this.codeOf(this.chartGeoCtrl.value)
    };

    const op$ = this.isEditMode
      ? this.digitizationService.updateRecord(this.data.docNo, this.data.record!.serial, req)
      : this.digitizationService.createRecord(req);

    op$.subscribe({
      next: () => this.dialogRef.close(true),
      error: (err: HttpErrorResponse) => this.onSaveError(err)
    });
  }

  /**
   * Legacy reported a rejected upload with a MsgBox (e.g. "هذا الملف مدخل سابقا", Form6.frm:3614).
   * The error interceptor already toasts 401/403/500, so only the business rejections (409/404/400)
   * — which it ignores and which used to fail silently — are surfaced here, with the server's text.
   */
  private onSaveError(err: HttpErrorResponse): void {
    this.isSaving.set(false);
    if (err.status !== 401 && err.status !== 403 && err.status !== 500) {
      const message = (err.error && err.error.message) || this.translate.instant('APP.ERROR');
      this.snackBar.open(message, '', { duration: 5000 });
    }
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
