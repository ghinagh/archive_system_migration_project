import { Component, Inject, inject, signal } from '@angular/core';
import { AbstractControl, FormBuilder, ValidationErrors, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';

@Component({ standalone: false, selector: 'app-change-password-dialog', templateUrl: './change-password-dialog.component.html', styleUrls: ['./change-password-dialog.component.scss'] })
export class ChangePasswordDialogComponent {
  private fb = inject(FormBuilder);
  private dialogRef = inject(MatDialogRef<ChangePasswordDialogComponent>);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isLoading = signal(false);

  form = this.fb.group({
    newPassword: ['', [Validators.required, Validators.minLength(4)]],
    confirmPassword: ['', Validators.required]
  }, { validators: [this.passwordsMatch] });

  constructor(@Inject(MAT_DIALOG_DATA) public data: { userNo: string }) {}

  passwordsMatch(group: AbstractControl): ValidationErrors | null {
    const pass = group.get('newPassword')?.value;
    const confirm = group.get('confirmPassword')?.value;
    return pass === confirm ? null : { passwordsMismatch: true };
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
    this.dialogRef.close(true);
  }

  onCancel(): void { this.dialogRef.close(); }
}
