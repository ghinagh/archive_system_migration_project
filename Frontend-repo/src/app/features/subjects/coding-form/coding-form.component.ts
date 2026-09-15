import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { SubjectsService } from '../services/subjects.service';
import { CodingEntry, CodingRequest } from '../models/subject.model';

export interface CodingFormData {
  mode: 'create' | 'edit';
  entry?: CodingEntry;
}

@Component({
  standalone: false,
  selector: 'app-coding-form',
  templateUrl: './coding-form.component.html',
  styleUrls: ['./coding-form.component.scss']
})
export class CodingFormComponent {

  data              = inject<CodingFormData>(MAT_DIALOG_DATA);
  private fb        = inject(FormBuilder);
  private svc       = inject(SubjectsService);
  private snack     = inject(MatSnackBar);
  private t         = inject(TranslateService);
  private dialogRef = inject(MatDialogRef<CodingFormComponent>);

  isLoading  = signal(false);
  isEditMode = this.data.mode === 'edit';

  form = this.fb.group({
    level: [
      { value: this.data.entry?.level ?? '', disabled: this.isEditMode },
      [Validators.required, Validators.maxLength(1)]
    ],
    code: [
      { value: this.data.entry?.code ?? '', disabled: this.isEditMode },
      [Validators.required, Validators.maxLength(4)]
    ],
    description: [
      this.data.entry?.description ?? '',
      [Validators.required, Validators.maxLength(100)]
    ]
  });

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const raw = this.form.getRawValue();
    const req: CodingRequest = {
      level:       raw.level!,
      code:        raw.code!,
      description: raw.description || undefined
    };

    this.isLoading.set(true);

    const action$ = this.isEditMode
      ? this.svc.updateCoding(this.data.entry!.level, this.data.entry!.code, req)
      : this.svc.createCoding(req);

    action$.subscribe({
      next: () => {
        this.isLoading.set(false);
        const key = this.isEditMode ? 'SUBJECTS.CODING.UPDATED' : 'SUBJECTS.CODING.CREATED';
        this.snack.open(this.t.instant(key), '', { duration: 3000 });
        this.dialogRef.close(true);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.dialogRef.close(); }
}
