import { Component, OnInit, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { AuthorsService } from '../services/authors.service';
import { Author } from '../models/author.model';

@Component({
  standalone: false,
  selector: 'app-author-dialog',
  templateUrl: './author-dialog.component.html'
})
export class AuthorDialogComponent implements OnInit {

  private fb = inject(FormBuilder);
  private authorsService = inject(AuthorsService);
  dialogRef = inject(MatDialogRef<AuthorDialogComponent>);
  data = inject<Author | null>(MAT_DIALOG_DATA);

  isEdit = !!this.data;
  isSaving = false;

  form = this.fb.group({
    autNo: [null as number | null, [Validators.required]],
    name: ['', Validators.maxLength(100)],
    type: ['', Validators.maxLength(2)],
    subjectNo: ['', Validators.maxLength(10)]
  });

  ngOnInit(): void {
    if (this.data) {
      this.form.patchValue({
        autNo: this.data.autNo,
        name: this.data.name ?? '',
        type: this.data.type ?? '',
        subjectNo: this.data.subjectNo ?? ''
      });
      this.form.get('autNo')!.disable();
    }
  }

  onSave(): void {
    if (this.form.invalid || this.isSaving) return;
    this.isSaving = true;
    const raw = this.form.getRawValue();
    const req = {
      autNo: raw.autNo!,
      name: raw.name || undefined,
      type: raw.type || undefined,
      subjectNo: raw.subjectNo || undefined
    };

    const action$ = this.isEdit
      ? this.authorsService.update(this.data!.autNo, req)
      : this.authorsService.create(req);

    action$.subscribe({
      next: () => this.dialogRef.close(true),
      error: () => { this.isSaving = false; }
    });
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
