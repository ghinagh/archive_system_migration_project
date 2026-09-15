import { Component, inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

export interface ConfirmPromptDialogData {
  messageKey: string;
}

@Component({
  standalone: false,
  selector: 'app-confirm-prompt-dialog',
  templateUrl: './confirm-prompt-dialog.component.html'
})
export class ConfirmPromptDialogComponent {
  data = inject<ConfirmPromptDialogData>(MAT_DIALOG_DATA);
  dialogRef = inject(MatDialogRef<ConfirmPromptDialogComponent>);

  onYes(): void {
    this.dialogRef.close(true);
  }

  onNo(): void {
    this.dialogRef.close(false);
  }
}
