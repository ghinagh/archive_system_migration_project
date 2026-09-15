import { HttpErrorResponse } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { CatalogueService } from '../services/catalogue.service';
import { CatalogueItem, CatalogueFormData } from '../models/catalogue.models';

@Component({
  standalone: false,
  selector: 'app-catalogue-form',
  templateUrl: './catalogue-form.component.html',
  styleUrls: ['./catalogue-form.component.scss']
})
export class CatalogueFormComponent implements OnInit {

  @Input() editData: CatalogueItem | null = null;
  @Output() saved = new EventEmitter<void>();
  @Output() cancelled = new EventEmitter<void>();
  @Output() lockError = new EventEmitter<void>();

  private fb = inject(FormBuilder);
  private catalogueService = inject(CatalogueService);
  private router = inject(Router);

  isLoading = signal(false);
  isEditMode = signal(false);

  form = this.fb.group({
    appNo: ['', [Validators.required, Validators.maxLength(7)]],
    activeTitleAr: ['', Validators.maxLength(125)],
    additionalTitle: ['', Validators.maxLength(125)],
    dataEntry: ['', Validators.maxLength(2)],
    appDoc: ['', Validators.maxLength(2)],
    entryDate: [''],
    writeDate: [''],
    appRevision: ['', Validators.maxLength(2)],
    type: ['', Validators.maxLength(1)],
    result: ['', Validators.maxLength(1000)],
    trans: [0]
  });

  ngOnInit(): void {
    if (this.editData) {
      this.isEditMode.set(true);
      this.form.patchValue(this.editData);
      this.form.get('appNo')?.disable();
    }
  }

  onSubmit(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    const rawValue = this.form.getRawValue() as CatalogueFormData;

    if (this.isEditMode()) {
      this.catalogueService.update(rawValue.appNo, rawValue).subscribe({
        next: () => {
          this.isLoading.set(false);
          this.saved.emit();
        },
        error: (err: HttpErrorResponse) => {
          this.isLoading.set(false);
          if (err.status === 409) {
            this.lockError.emit();
          }
        }
      });
    } else {
      this.catalogueService.create(rawValue).subscribe({
        next: () => {
          this.isLoading.set(false);
          this.router.navigate(['/catalogue']);
        },
        error: () => this.isLoading.set(false)
      });
    }
  }

  onCancel(): void {
    if (this.isEditMode()) {
      this.cancelled.emit();
    } else {
      this.router.navigate(['/catalogue']);
    }
  }
}
