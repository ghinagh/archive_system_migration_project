import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../services/digitization.service';

@Component({ standalone: false, selector: 'app-demand-form', templateUrl: './demand-form.component.html', styleUrls: ['./demand-form.component.scss'] })
export class DemandFormComponent {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private svc = inject(DigitizationService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);
  isLoading = signal(false);

  form = this.fb.group({
    demandNo: ['', [Validators.required, Validators.maxLength(7)]],
    serial: [1, Validators.required],
    userNo: ['', Validators.maxLength(3)],
    date: [''],
    machineNo: ['', Validators.maxLength(7)],
    description: ['', Validators.maxLength(100)],
    cote: ['', Validators.maxLength(50)],
    time1: ['', Validators.maxLength(12)]
  });

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    this.svc.createDemand(this.form.getRawValue() as any).subscribe({
      next: () => { this.isLoading.set(false); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/digitization']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/digitization']); }
}
