import { Component, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitRecord, DigitRecordRequest } from '../../digitization/models/digitization.model';

@Component({
  standalone: false,
  selector: 'app-digit-record-dialog',
  templateUrl: './digit-record-dialog.component.html',
  styleUrls: ['./digit-record-dialog.component.scss']
})
export class DigitRecordDialogComponent {

  private fb = inject(FormBuilder);
  private digitizationService = inject(DigitizationService);
  dialogRef = inject(MatDialogRef<DigitRecordDialogComponent>);
  data = inject<{ docNo: string; nextSerial: number; record: DigitRecord | null }>(MAT_DIALOG_DATA);

  isSaving = false;
  isEditMode = !!this.data.record;

  form = this.fb.group({
    digitNo: [this.data.record?.digitNo ?? '', Validators.maxLength(6)],
    type: [this.data.record?.type ?? '', Validators.maxLength(4)],
    highType: [this.data.record?.highType ?? '', Validators.maxLength(3)],
    type1: [this.data.record?.type1 ?? '', Validators.maxLength(2)],
    materialType: [this.data.record?.materialType ?? '', Validators.maxLength(2)],
    size: [this.data.record?.size ?? null as number | null],
    durationHours: [this.data.record?.durationHours ?? 0],
    durationMinutes: [this.data.record?.durationMinutes ?? 0],
    durationSeconds: [this.data.record?.durationSeconds ?? 0],
    durationHours1: [this.data.record?.durationHours1 ?? 0],
    durationMinutes1: [this.data.record?.durationMinutes1 ?? 0],
    durationSeconds1: [this.data.record?.durationSeconds1 ?? 0],
    chartType: [this.data.record?.chartType ?? '', Validators.maxLength(2)],
    chartNo: [this.data.record?.chartNo ?? '', Validators.maxLength(6)],
    newChartNo: [this.data.record?.newChartNo ?? '', Validators.maxLength(6)],
    chartGeo: [this.data.record?.chartGeo ?? '', Validators.maxLength(10)]
  });

  onSave(): void {
    if (this.form.invalid || this.isSaving) return;
    this.isSaving = true;
    const raw = this.form.getRawValue();
    const req: DigitRecordRequest = {
      docNo: this.data.docNo,
      serial: this.isEditMode ? this.data.record!.serial : this.data.nextSerial,
      digitNo: raw.digitNo || undefined,
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
      chartGeo: raw.chartGeo || undefined
    };

    const op$ = this.isEditMode
      ? this.digitizationService.updateRecord(this.data.docNo, this.data.record!.serial, req)
      : this.digitizationService.createRecord(req);

    op$.subscribe({
      next: () => this.dialogRef.close(true),
      error: () => { this.isSaving = false; }
    });
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
