import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { SitesService } from '../services/sites.service';
import { PostRequest } from '../models/sites.model';

@Component({ standalone: false, selector: 'app-post-form', templateUrl: './post-form.component.html', styleUrls: ['./post-form.component.scss'] })
export class PostFormComponent implements OnInit {
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
    serial: ['', [Validators.required, Validators.maxLength(6)]],
    formNo: ['', Validators.maxLength(10)],
    siteNo: ['', Validators.maxLength(13)],
    docNo: ['', Validators.maxLength(7)],
    startDate: [''],
    endDate: [''],
    wilyaNo: [null as number | null],
    status: [null as number | null],
    levelNo: ['', Validators.maxLength(2)],
    type: [null as number | null],
    user: ['', Validators.maxLength(3)],
    permission: [null as number | null],
    level: ['', Validators.maxLength(1)]
  });

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.isEditMode.set(true);
      this.pageLoading.set(true);
      this.sitesService.getPostById(id).subscribe({
        next: r => { this.form.patchValue(r.data); this.form.get('serial')?.disable(); this.pageLoading.set(false); },
        error: () => { this.pageLoading.set(false); this.router.navigate(['/sites']); }
      });
    } else {
      const formNo = this.route.snapshot.queryParamMap.get('formNo');
      if (formNo) this.form.patchValue({ formNo });
    }
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    const raw = this.form.getRawValue() as PostRequest;
    const req$ = this.isEditMode() ? this.sitesService.updatePost(raw.serial, raw) : this.sitesService.createPost(raw);
    req$.subscribe({
      next: () => { this.isLoading.set(false); this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/sites']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/sites']); }
}
