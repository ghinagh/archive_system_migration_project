import { Component, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  standalone: false,
  selector: 'app-search-by-title-dialog',
  templateUrl: './search-by-title-dialog.component.html'
})
export class SearchByTitleDialogComponent {
  dialogRef = inject(MatDialogRef<SearchByTitleDialogComponent>);
  private fb = inject(FormBuilder);

  form = this.fb.group({
    title: ['', [Validators.required, Validators.maxLength(125)]]
  });

  onSubmit(): void {
    if (this.form.invalid) return;
    this.dialogRef.close(this.form.getRawValue().title);
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
