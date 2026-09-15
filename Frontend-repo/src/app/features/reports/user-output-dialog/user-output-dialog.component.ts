import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';
import { ReportsService } from '../services/reports.service';

@Component({ standalone: false, selector: 'app-user-output-dialog', templateUrl: './user-output-dialog.component.html', styleUrls: ['./user-output-dialog.component.scss'] })
export class UserOutputDialogComponent {
  private fb = inject(FormBuilder);
  private svc = inject(ReportsService);
  private dialogRef = inject(MatDialogRef<UserOutputDialogComponent>);
  isLoading = signal(false);

  form = this.fb.group({
    institutionNo: ['', [Validators.required, Validators.maxLength(2)]],
    userNo: ['', [Validators.required, Validators.maxLength(3)]],
    outputNum: [null as number | null, Validators.required],
    outputChoice: [null as number | null],
    userIndex: ['', Validators.maxLength(3)],
    sign: ['', Validators.maxLength(1)],
    outputChoice1: [null as number | null],
    sign1: ['', Validators.maxLength(1)]
  });

  onSubmit(): void {
    if (this.form.invalid) return;
    this.isLoading.set(true);
    this.svc.createUserOutput(this.form.getRawValue() as any).subscribe({
      next: () => { this.isLoading.set(false); this.dialogRef.close(true); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.dialogRef.close(); }
}
