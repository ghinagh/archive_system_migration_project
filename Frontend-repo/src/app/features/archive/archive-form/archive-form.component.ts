import { Component, DestroyRef, OnInit, inject, signal } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ArchiveService } from '../services/archive.service';
import { ChartRequest } from '../models/archive.model';

@Component({
  standalone: false,
  selector: 'app-archive-form',
  templateUrl: './archive-form.component.html',
  styleUrls: ['./archive-form.component.scss']
})
export class ArchiveFormComponent implements OnInit {

  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private archiveService = inject(ArchiveService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private destroyRef = inject(DestroyRef);

  isEditMode = signal(false);
  isLoading = signal(false);
  pageLoading = signal(false);
  private editId = 0;

  form = this.fb.group({
    chaNo: ['', [Validators.required, Validators.maxLength(6)]],
    subject: ['', Validators.maxLength(2)],
    type: [null as number | null],
    date: [''],
    title: ['', Validators.maxLength(70)],
    stock: [null as number | null],
    nbDis: [null as number | null],
    subjectCode: ['', Validators.maxLength(3)],
    source: ['', Validators.maxLength(3)],
    fromSite: ['', Validators.maxLength(3)],
    toSite: ['', Validators.maxLength(3)],
    fromPerson: ['', Validators.maxLength(3)],
    toPerson: ['', Validators.maxLength(3)],
    timeCode: ['', Validators.maxLength(2)]
  });

  ngOnInit(): void {
    // Clear the server-side duplicate error as soon as the user edits the stock value
    this.form.get('stock')?.valueChanges
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(() => {
        const ctrl = this.form.get('stock');
        if (ctrl?.hasError('duplicate')) {
          ctrl.setErrors(null);
        }
      });

    const id = this.route.snapshot.paramMap.get('id');
    if (id && id !== 'new') {
      this.isEditMode.set(true);
      this.editId = Number(id);
      this.pageLoading.set(true);
      this.archiveService.getById(this.editId).subscribe({
        next: res => { this.form.patchValue(res.data); this.form.get('chaNo')?.disable(); this.pageLoading.set(false); },
        error: () => { this.pageLoading.set(false); this.router.navigate(['/archive']); }
      });
    }
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    const raw = this.form.getRawValue() as ChartRequest;

    const req$ = this.isEditMode()
      ? this.archiveService.update(this.editId, raw)
      : this.archiveService.create(raw);

    req$.subscribe({
      next: () => {
        this.isLoading.set(false);
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.router.navigate(['/archive']);
      },
      error: (err: { status?: number }) => {
        this.isLoading.set(false);
        if (err.status === 409) {
          this.form.get('stock')?.setErrors({ duplicate: true });
          this.form.get('stock')?.markAsTouched();
        }
      }
    });
  }

  onCancel(): void { this.router.navigate(['/archive']); }
}
