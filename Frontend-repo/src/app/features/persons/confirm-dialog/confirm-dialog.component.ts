import { Component } from '@angular/core';

@Component({
  standalone: false,
  selector: 'app-confirm-dialog',
  template: `
    <h2 mat-dialog-title>{{ 'APP.CONFIRM_DELETE' | translate }}</h2>
    <mat-dialog-actions align="end">
      <button mat-button mat-dialog-close>{{ 'APP.NO' | translate }}</button>
      <button mat-raised-button color="warn" [mat-dialog-close]="true">{{ 'APP.YES' | translate }}</button>
    </mat-dialog-actions>
  `
})
export class ConfirmDialogComponent { }
