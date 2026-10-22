import { Component, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

export interface PasswordGateDialogData {
  isLocked: boolean;
}

@Component({
  standalone: false,
  selector: 'app-password-gate-dialog',
  templateUrl: './password-gate-dialog.component.html'
})
export class PasswordGateDialogComponent {
  data = inject<PasswordGateDialogData>(MAT_DIALOG_DATA);
  dialogRef = inject(MatDialogRef<PasswordGateDialogComponent>);
  private fb = inject(FormBuilder);

  form = this.fb.group({
    password: ['', Validators.required]
  });

  onSubmit(): void {
    if (this.form.invalid) return;
    // Form6.frm compares LTrim(m_user_password) with "891045" — the server does that check
    this.dialogRef.close(this.form.getRawValue().password ?? '');
  }

  onCancel(): void {
    this.dialogRef.close(false);
  }
}
