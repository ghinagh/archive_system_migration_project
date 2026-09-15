import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { SitesService } from '../services/sites.service';
import { SiteRequest } from '../models/sites.model';

@Component({ standalone: false, selector: 'app-site-form', templateUrl: './site-form.component.html', styleUrls: ['./site-form.component.scss'] })
export class SiteFormComponent implements OnInit {
  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private sitesService = inject(SitesService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  isEditMode = signal(false);
  isLoading = signal(false);
  pageLoading = signal(false);

  form = this.fb.group({
    siteNo: ['', [Validators.required, Validators.maxLength(10)]],
    level: ['', Validators.maxLength(2)],
    description: ['', Validators.maxLength(100)],
    docNo: ['', Validators.maxLength(7)],
    startDate: [''],
    endDate: [''],
    free: [null as number | null],
    type: ['', Validators.maxLength(2)],
    wilyaNo: [null as number | null],
    status: ['', Validators.maxLength(2)],
    user: ['', Validators.maxLength(3)],
    permission: [null as number | null],
    accessLevel: ['', Validators.maxLength(1)],
    kind: ['', Validators.maxLength(2)]
  });

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.isEditMode.set(true);
      this.pageLoading.set(true);
      this.sitesService.getSiteById(id).subscribe({
        next: r => { this.form.patchValue(r.data); this.form.get('siteNo')?.disable(); this.pageLoading.set(false); },
        error: () => { this.pageLoading.set(false); this.router.navigate(['/sites']); }
      });
    }
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    const raw = this.form.getRawValue() as SiteRequest;
    const req$ = this.isEditMode() ? this.sitesService.updateSite(raw.siteNo, raw) : this.sitesService.createSite(raw);
    req$.subscribe({
      next: () => { this.isLoading.set(false); this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/sites']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/sites']); }
}
