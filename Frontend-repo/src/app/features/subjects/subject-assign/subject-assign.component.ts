import { Component, Input, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { SubjectsService } from '../services/subjects.service';
import { MacnzSubject, SubjectAnalysis } from '../models/subject.model';
import { SubjectSearchDialogComponent } from '../subject-search-dialog/subject-search-dialog.component';

@Component({
  standalone: false,
  selector: 'app-subject-assign',
  templateUrl: './subject-assign.component.html',
  styleUrls: ['./subject-assign.component.scss']
})
export class SubjectAssignComponent implements OnInit {

  @Input({ required: true }) appNo!: string;

  private subjectsService = inject(SubjectsService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  assignedSubjects = signal<SubjectAnalysis[]>([]);
  isLoading = signal(true);

  ngOnInit(): void {
    this.loadSubjects();
  }

  openAddDialog(): void {
    const dialogRef = this.dialog.open(SubjectSearchDialogComponent, {
      width: '500px'
    });

    dialogRef.afterClosed().subscribe((subject: MacnzSubject | undefined) => {
      if (!subject) return;

      this.subjectsService.addDocumentSubject(this.appNo, {
        descriptorNo: subject.code,
        serialNo: '01'
      }).subscribe({
        next: () => {
          this.snackBar.open(
            this.translate.instant('APP.SUCCESS'),
            this.translate.instant('APP.CANCEL'),
            { duration: 3000 }
          );
          this.loadSubjects();
        }
      });
    });
  }

  removeSubject(id: number): void {
    this.subjectsService.removeDocumentSubject(this.appNo, id).subscribe({
      next: () => {
        this.snackBar.open(
          this.translate.instant('APP.SUCCESS'),
          this.translate.instant('APP.CANCEL'),
          { duration: 3000 }
        );
        this.loadSubjects();
      }
    });
  }

  private loadSubjects(): void {
    this.isLoading.set(true);
    this.subjectsService.getDocumentSubjects(this.appNo).subscribe({
      next: (res) => {
        this.assignedSubjects.set(res.data);
        this.isLoading.set(false);
      },
      error: () => this.isLoading.set(false)
    });
  }
}
