import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../services/digitization.service';

@Component({ standalone: false, selector: 'app-digit-record-form', templateUrl: './digit-record-form.component.html', styleUrls: ['./digit-record-form.component.scss'] })
export class DigitRecordFormComponent {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private svc = inject(DigitizationService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);
  isLoading = signal(false);

  form = this.fb.group({
    docNo: ['', [Validators.required, Validators.maxLength(7)]],
    serial: [1, Validators.required],
    digitNo: ['', Validators.maxLength(6)],
    type: ['', Validators.maxLength(4)],
    type1: ['', Validators.maxLength(2)],
    durationHours: [0], durationMinutes: [0], durationSeconds: [0],
    durationHours1: [0], durationMinutes1: [0], durationSeconds1: [0],
    size: [null as number | null],
    chartNo: ['', Validators.maxLength(6)],
    newChartNo: ['', Validators.maxLength(6)],
    chartType: ['', Validators.maxLength(2)],
    chartGeo: ['', Validators.maxLength(10)],
    choice: [null as number | null],
    materialType: ['', Validators.maxLength(2)],
    highType: ['', Validators.maxLength(3)]
  });

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    this.svc.createRecord(this.form.getRawValue() as any).subscribe({
      next: () => { this.isLoading.set(false); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/digitization']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/digitization']); }
}
