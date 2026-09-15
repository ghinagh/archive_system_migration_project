import { Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { CatalogueService } from '../services/catalogue.service';
import { Main2Item } from '../models/catalogue.models';

export interface Main2FormDialogData {
  appNo: string;
  item: Main2Item | null;
}

@Component({
  standalone: false,
  selector: 'app-main2-form-dialog',
  templateUrl: './main2-form-dialog.component.html'
})
export class Main2FormDialogComponent {

  private fb = inject(FormBuilder);
  private catalogueService = inject(CatalogueService);
  dialogRef = inject(MatDialogRef<Main2FormDialogComponent>);
  data = inject<Main2FormDialogData>(MAT_DIALOG_DATA);

  isSaving = signal(false);
  isEditMode = !!this.data.item;

  form = this.fb.group({
    chartNo:      [this.data.item?.chartNo ?? '', Validators.maxLength(6)],
    startHours:   [this.data.item?.startHours ?? null as number | null],
    startMinutes: [this.data.item?.startMinutes ?? null as number | null],
    startSeconds: [this.data.item?.startSeconds ?? null as number | null],
    endHours:     [this.data.item?.endHours ?? null as number | null],
    endMinutes:   [this.data.item?.endMinutes ?? null as number | null],
    endSeconds:   [this.data.item?.endSeconds ?? null as number | null],
    size:         [this.data.item?.size ?? null as number | null],
    type:         [this.data.item?.type ?? '', Validators.maxLength(1)],
    pictureCode:  [this.data.item?.pictureCode ?? '', Validators.maxLength(2)],
    voiceCode:    [this.data.item?.voiceCode ?? '', Validators.maxLength(2)],
    result:       [this.data.item?.result ?? '', Validators.maxLength(500)]
  });

  onSave(): void {
    if (this.form.invalid || this.isSaving()) return;
    this.isSaving.set(true);

    const raw = this.form.getRawValue();
    const req = {
      chartNo:      raw.chartNo || null,
      startHours:   raw.startHours,
      startMinutes: raw.startMinutes,
      startSeconds: raw.startSeconds,
      endHours:     raw.endHours,
      endMinutes:   raw.endMinutes,
      endSeconds:   raw.endSeconds,
      size:         raw.size,
      type:         raw.type || null,
      pictureCode:  raw.pictureCode || null,
      voiceCode:    raw.voiceCode || null,
      result:       raw.result || null
    };

    const action$ = this.isEditMode
      ? this.catalogueService.updateExtendedInfo(this.data.appNo, req)
      : this.catalogueService.createExtendedInfo(this.data.appNo, req);

    action$.subscribe({
      next: () => this.dialogRef.close(true),
      error: () => this.isSaving.set(false)
    });
  }

  onCancel(): void {
    this.dialogRef.close(null);
  }
}
