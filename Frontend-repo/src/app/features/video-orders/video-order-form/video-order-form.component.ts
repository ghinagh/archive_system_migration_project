import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { VideoOrderService } from '../services/video-order.service';
import { VideoOrderRequest } from '../models/video-order.model';

@Component({
  standalone: false,
  selector: 'app-video-order-form',
  templateUrl: './video-order-form.component.html',
  styleUrls: ['./video-order-form.component.scss']
})
export class VideoOrderFormComponent implements OnInit {
  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(VideoOrderService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  private orderId: string | null = null;

  isEditMode = signal(false);
  isLoading = signal(false);
  pageLoading = signal(false);

  form = this.fb.group({
    orderNo: ['', [Validators.required, Validators.maxLength(20)]],
    stockNo: ['', [Validators.required, Validators.maxLength(6)]],
    chartId: [null as number | null],
    description: ['', Validators.maxLength(200)],
    requestedBy: ['', [Validators.required, Validators.maxLength(30)]],
    requestDate: ['', Validators.required],
    status: ['PENDING']
  });

  ngOnInit(): void {
    this.orderId = this.route.snapshot.paramMap.get('id');
    if (this.orderId) {
      this.isEditMode.set(true);
      this.pageLoading.set(true);
      this.svc.getById(this.orderId).subscribe({
        next: r => {
          this.form.patchValue(r.data);
          this.pageLoading.set(false);
        },
        error: () => { this.pageLoading.set(false); this.router.navigate(['/video-orders', 'approvals']); }
      });
    }
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    const raw = this.form.getRawValue() as VideoOrderRequest;

    const req$ = this.isEditMode() && this.orderId
      ? this.svc.update(this.orderId, raw)
      : this.svc.create(raw);

    req$.subscribe({
      next: () => { this.isLoading.set(false); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/video-orders', 'approvals']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/video-orders', 'approvals']); }
}
