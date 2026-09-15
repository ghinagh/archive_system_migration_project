import { Component, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  standalone: false,
  selector: 'app-goto-record-dialog',
  templateUrl: './goto-record-dialog.component.html'
})
export class GotoRecordDialogComponent {
  dialogRef = inject(MatDialogRef<GotoRecordDialogComponent>);
  private fb = inject(FormBuilder);

  form = this.fb.group({
    appNo: ['', [Validators.required, Validators.maxLength(7)]]
  });

  onSubmit(): void {
    if (this.form.invalid) return;
    this.dialogRef.close(this.form.getRawValue().appNo);
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
