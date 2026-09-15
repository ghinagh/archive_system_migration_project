import { Component, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { TempFilesService } from '../services/temp-files.service';

@Component({
  standalone: false,
  selector: 'app-temp-file-dialog',
  templateUrl: './temp-file-dialog.component.html'
})
export class TempFileDialogComponent {

  private fb = inject(FormBuilder);
  private tempFilesService = inject(TempFilesService);
  dialogRef = inject(MatDialogRef<TempFileDialogComponent>);
  data = inject<{ appNo: string }>(MAT_DIALOG_DATA);

  isSaving = false;

  form = this.fb.group({
    tmpFileName: ['', [Validators.required, Validators.maxLength(50)]],
    tmpRmrk: ['', Validators.maxLength(50)],
    tmpMk: ['', Validators.maxLength(30)],
    tmpDate: ['']
  });

  onSave(): void {
    if (this.form.invalid || this.isSaving) return;
    this.isSaving = true;
    const raw = this.form.getRawValue();
    this.tempFilesService.createTempFile({
      tmpFadNo: this.data.appNo,
      tmpFileName: raw.tmpFileName || undefined,
      tmpRmrk: raw.tmpRmrk || undefined,
      tmpMk: raw.tmpMk || undefined,
      tmpDate: raw.tmpDate || undefined
    }).subscribe({
      next: () => this.dialogRef.close(true),
      error: () => { this.isSaving = false; }
    });
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
