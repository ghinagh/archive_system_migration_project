import { Component, OnInit, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MaintenanceService } from '../services/maintenance.service';
import { RetrievalField } from '../models/maintenance.model';

@Component({
  standalone: false,
  selector: 'app-retrieval-field-dialog',
  templateUrl: './retrieval-field-dialog.component.html'
})
export class RetrievalFieldDialogComponent implements OnInit {

  private fb = inject(FormBuilder);
  private maintenanceService = inject(MaintenanceService);
  dialogRef = inject(MatDialogRef<RetrievalFieldDialogComponent>);
  data = inject<RetrievalField | null>(MAT_DIALOG_DATA);

  isEdit = !!this.data;
  isSaving = false;

  fieldTypes = ['STRING', 'NUMBER', 'DATE'];

  form = this.fb.group({
    module: ['', [Validators.required, Validators.maxLength(30)]],
    fieldKey: ['', [Validators.required, Validators.maxLength(50)]],
    entityPath: ['', [Validators.required, Validators.maxLength(100)]],
    fieldType: ['STRING', Validators.required],
    label: ['', [Validators.required, Validators.maxLength(100)]],
    enabled: [true]
  });

  ngOnInit(): void {
    if (this.data) {
      this.form.patchValue({
        module: this.data.module,
        fieldKey: this.data.fieldKey,
        entityPath: this.data.entityPath,
        fieldType: this.data.fieldType,
        label: this.data.label,
        enabled: this.data.enabled
      });
      this.form.get('module')!.disable();
      this.form.get('fieldKey')!.disable();
    }
  }

  onSave(): void {
    if (this.form.invalid || this.isSaving) return;
    this.isSaving = true;
    const raw = this.form.getRawValue();
    const req = {
      module: raw.module!,
      fieldKey: raw.fieldKey!,
      entityPath: raw.entityPath!,
      fieldType: raw.fieldType!,
      label: raw.label!,
      enabled: raw.enabled!
    };

    const action$ = this.isEdit
      ? this.maintenanceService.updateRetrievalField(this.data!.id, req)
      : this.maintenanceService.createRetrievalField(req);

    action$.subscribe({
      next: () => this.dialogRef.close(true),
      error: () => { this.isSaving = false; }
    });
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
