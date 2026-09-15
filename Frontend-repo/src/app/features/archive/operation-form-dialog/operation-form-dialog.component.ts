import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ArchiveService } from '../services/archive.service';
import { ChartOperation, OperationRequest } from '../models/archive.model';

export interface OperationFormDialogData {
  chartId: number;
  operationId?: number;
  operation?: ChartOperation;
}

@Component({
  standalone: false,
  selector: 'app-operation-form-dialog',
  templateUrl: './operation-form-dialog.component.html',
  styleUrls: ['./operation-form-dialog.component.scss']
})
export class OperationFormDialogComponent {

  private data = inject<OperationFormDialogData>(MAT_DIALOG_DATA);
  private fb = inject(FormBuilder);
  private archiveService = inject(ArchiveService);
  private dialogRef = inject(MatDialogRef<OperationFormDialogComponent>);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isLoading = signal(false);
  isEditMode = !!this.data.operationId;

  form = this.fb.group({
    oprNo:      [this.data.operation?.oprNo      ?? '', Validators.maxLength(7)],
    subject:    [this.data.operation?.subject    ?? '', Validators.maxLength(2)],
    date:       [this.data.operation?.date       ?? ''],
    time:       [this.data.operation?.time       ?? '', Validators.maxLength(15)],
    fromSite:   [this.data.operation?.fromSite   ?? '', Validators.maxLength(3)],
    fromPerson: [this.data.operation?.fromPerson ?? '', Validators.maxLength(3)],
    toSite:     [this.data.operation?.toSite     ?? '', Validators.maxLength(3)],
    toPerson:   [this.data.operation?.toPerson   ?? '', Validators.maxLength(3)],
    returnDate: [this.data.operation?.returnDate ?? ''],
    remark:     [this.data.operation?.remark     ?? '', Validators.maxLength(50)],
    title:      [this.data.operation?.title      ?? '', Validators.maxLength(70)],
    transferred:[this.data.operation?.transferred ?? false]
  });

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);

    const raw = this.form.getRawValue();
    const request: OperationRequest = {
      ...raw,
      oprNo:      raw.oprNo      || undefined,
      subject:    raw.subject    || undefined,
      date:       raw.date       || undefined,
      time:       raw.time       || undefined,
      fromSite:   raw.fromSite   || undefined,
      fromPerson: raw.fromPerson || undefined,
      toSite:     raw.toSite     || undefined,
      toPerson:   raw.toPerson   || undefined,
      returnDate: raw.returnDate || undefined,
      remark:     raw.remark     || undefined,
      title:      raw.title      || undefined,
      transferred: raw.transferred ?? false
    };

    if (this.isEditMode) {
      this.archiveService.updateOperation(this.data.chartId, this.data.operationId!, request).subscribe({
        next: () => {
          this.isLoading.set(false);
          this.snack.open(this.t.instant('ARCHIVE.OPERATION_UPDATED_CHART_SYNCED'), '', { duration: 4000 });
          this.dialogRef.close(true);
        },
        error: () => this.isLoading.set(false)
      });
    } else {
      this.archiveService.createOperation(this.data.chartId, request).subscribe({
        next: () => { this.isLoading.set(false); this.dialogRef.close(true); },
        error: () => this.isLoading.set(false)
      });
    }
  }

  onCancel(): void { this.dialogRef.close(); }
}
