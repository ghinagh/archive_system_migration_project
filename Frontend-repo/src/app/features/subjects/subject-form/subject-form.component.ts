import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { SubjectsService } from '../services/subjects.service';
import { MacnzSubject, MacnzRequest } from '../models/subject.model';

export interface SubjectFormData {
  mode: 'create' | 'edit';
  subject?: MacnzSubject;
  parent?: MacnzSubject;
  allSubjects: MacnzSubject[];
}

@Component({
  standalone: false,
  selector: 'app-subject-form',
  templateUrl: './subject-form.component.html',
  styleUrls: ['./subject-form.component.scss']
})
export class SubjectFormComponent {

  data              = inject<SubjectFormData>(MAT_DIALOG_DATA);
  private fb        = inject(FormBuilder);
  private svc       = inject(SubjectsService);
  private snack     = inject(MatSnackBar);
  private t         = inject(TranslateService);
  private dialogRef = inject(MatDialogRef<SubjectFormComponent>);

  isLoading  = signal(false);
  isEditMode = this.data.mode === 'edit';

  level = this.isEditMode
    ? this.data.subject!.level
    : this.data.parent
      ? String(Number(this.data.parent.level) + 1)
      : '1';

  parentCode = this.isEditMode ? null : (this.data.parent?.code ?? null);

  form = this.fb.group({
    code: [
      { value: this.isEditMode ? this.data.subject!.code : this.suggestCode(), disabled: this.isEditMode },
      [Validators.required, Validators.maxLength(9)]
    ],
    description: [
      this.isEditMode ? this.data.subject!.description : '',
      [Validators.required, Validators.maxLength(40)]
    ]
  });

  private suggestCode(): string {
    const parent = this.data.parent;
    if (!parent) return '';
    const siblingPrefix = parent.code;
    const siblings = this.data.allSubjects.filter(s =>
      s.code.startsWith(siblingPrefix) && s.code.length === siblingPrefix.length + 2
    );
    const next = siblings.length + 1;
    return siblingPrefix + String(next).padStart(2, '0');
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const raw = this.form.getRawValue();
    const req: MacnzRequest = {
      code:        raw.code!,
      level:       this.level,
      description: raw.description!
    };

    this.isLoading.set(true);

    const action$ = this.isEditMode
      ? this.svc.updateSubject(this.data.subject!.code, req)
      : this.svc.createSubject(req);

    action$.subscribe({
      next: () => {
        this.isLoading.set(false);
        const key = this.isEditMode ? 'SUBJECTS.FORM.UPDATED' : 'SUBJECTS.FORM.CREATED';
        this.snack.open(this.t.instant(key), '', { duration: 3000 });
        this.dialogRef.close(true);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.dialogRef.close(); }
}
