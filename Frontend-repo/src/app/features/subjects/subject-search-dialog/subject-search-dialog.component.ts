import { Component, inject } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MacnzSubject } from '../models/subject.model';

@Component({
  standalone: false,
  selector: 'app-subject-search-dialog',
  templateUrl: './subject-search-dialog.component.html',
  styleUrls: ['./subject-search-dialog.component.scss']
})
export class SubjectSearchDialogComponent {

  private dialogRef = inject(MatDialogRef<SubjectSearchDialogComponent>);

  onSubjectSelected(subject: MacnzSubject): void {
    this.dialogRef.close(subject);
  }

  onCancel(): void {
    this.dialogRef.close();
  }
}
