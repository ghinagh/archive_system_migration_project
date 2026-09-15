import { Component, inject } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';

export type Page2PromptResult = 'with-saving' | 'without-saving' | null;

@Component({
  standalone: false,
  selector: 'app-page2-prompt-dialog',
  templateUrl: './page2-prompt-dialog.component.html'
})
export class Page2PromptDialogComponent {
  dialogRef = inject(MatDialogRef<Page2PromptDialogComponent, Page2PromptResult>);

  withSaving(): void { this.dialogRef.close('with-saving'); }
  withoutSaving(): void { this.dialogRef.close('without-saving'); }
  cancel(): void { this.dialogRef.close(null); }
}
