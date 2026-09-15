import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitResultRequest } from '../../digitization/models/digitization.model';

/**
 * Migrated equivalent of f_result.frm's hidden "معالجة طلبات معينة" panel: edits the
 * beneficiary/approving-body/beneficiary-entity/subject of one existing usage request.
 * Legacy has no working "add" here — this form is edit-only.
 */
@Component({
  standalone: false,
  selector: 'app-usage-request-form',
  templateUrl: './usage-request-form.component.html',
  styleUrls: ['./usage-request-form.component.scss']
})
export class UsageRequestFormComponent implements OnInit {
  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(DigitizationService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  private requestId!: number;

  isLoading = signal(false);
  pageLoading = signal(true);

  form = this.fb.group({
    resultNo: [{ value: '', disabled: true }],
    serial: [{ value: 1, disabled: true }],
    catalogueAppNo: [{ value: '', disabled: true }],
    digitNo: [{ value: '', disabled: true }],
    type1: [{ value: '', disabled: true }],
    person: ['', [Validators.required, Validators.maxLength(50)]],
    cote: ['', Validators.maxLength(3)],
    permit: ['', Validators.maxLength(2)],
    subject: ['', Validators.maxLength(50)]
  });

  ngOnInit(): void {
    this.requestId = Number(this.route.snapshot.paramMap.get('id'));
    this.svc.getResultById(this.requestId).subscribe({
      next: r => {
        this.form.patchValue(r.data);
        this.pageLoading.set(false);
      },
      error: () => { this.pageLoading.set(false); this.router.navigate(['/requests']); }
    });
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    const raw = this.form.getRawValue() as DigitResultRequest;
    this.svc.updateResult(this.requestId, raw).subscribe({
      next: () => { this.isLoading.set(false); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/requests']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/requests']); }
}
