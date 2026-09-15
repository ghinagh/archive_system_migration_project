import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../services/digitization.service';

@Component({ standalone: false, selector: 'app-result-form', templateUrl: './result-form.component.html', styleUrls: ['./result-form.component.scss'] })
export class ResultFormComponent {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private svc = inject(DigitizationService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);
  isLoading = signal(false);

  form = this.fb.group({
    resultNo: ['', [Validators.required, Validators.maxLength(7)]],
    serial: [1, Validators.required],
    digitNo: ['', Validators.maxLength(6)],
    type: ['', Validators.maxLength(3)],
    type1: ['', Validators.maxLength(2)],
    date: [''],
    userNo: ['', Validators.maxLength(3)],
    catalogueAppNo: ['', Validators.maxLength(7)],
    person: ['', Validators.maxLength(50)],
    cote: ['', Validators.maxLength(3)],
    permit: ['', Validators.maxLength(2)],
    subject: ['', Validators.maxLength(50)]
  });

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    this.svc.createResult(this.form.getRawValue() as any).subscribe({
      next: () => { this.isLoading.set(false); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/digitization']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/digitization']); }
}
