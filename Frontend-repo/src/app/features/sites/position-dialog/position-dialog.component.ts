import { Component, OnInit, inject } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { SitesService } from '../services/sites.service';
import { Position } from '../models/sites.model';

@Component({
  standalone: false,
  selector: 'app-position-dialog',
  templateUrl: './position-dialog.component.html'
})
export class PositionDialogComponent implements OnInit {

  private fb = inject(FormBuilder);
  private sitesService = inject(SitesService);
  dialogRef = inject(MatDialogRef<PositionDialogComponent>);
  data = inject<Position | null>(MAT_DIALOG_DATA);

  isEdit = !!this.data;
  isSaving = false;

  form = this.fb.group({
    posNo: ['', [Validators.required, Validators.maxLength(10)]],
    name: ['', Validators.maxLength(60)],
    recordDate: ['']
  });

  ngOnInit(): void {
    if (this.data) {
      this.form.patchValue({
        posNo: this.data.posNo,
        name: this.data.name ?? '',
        recordDate: this.data.recordDate ?? ''
      });
      this.form.get('posNo')!.disable();
    }
  }

  onSave(): void {
    if (this.form.invalid || this.isSaving) return;
    this.isSaving = true;
    const raw = this.form.getRawValue();
    const req = {
      posNo: raw.posNo!,
      name: raw.name || undefined,
      recordDate: raw.recordDate || undefined
    };

    const action$ = this.isEdit
      ? this.sitesService.updatePosition(this.data!.posNo, req)
      : this.sitesService.createPosition(req);

    action$.subscribe({
      next: () => this.dialogRef.close(true),
      error: () => { this.isSaving = false; }
    });
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
