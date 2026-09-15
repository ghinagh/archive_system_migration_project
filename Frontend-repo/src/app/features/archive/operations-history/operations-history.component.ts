import { Component, Input, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ArchiveService } from '../services/archive.service';
import { ChartOperation } from '../models/archive.model';
import { OperationFormDialogComponent } from '../operation-form-dialog/operation-form-dialog.component';

@Component({
  standalone: false,
  selector: 'app-operations-history',
  templateUrl: './operations-history.component.html',
  styleUrls: ['./operations-history.component.scss']
})
export class OperationsHistoryComponent implements OnInit {

  @Input({ required: true }) chartId!: number;

  private archiveService = inject(ArchiveService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['oprNo', 'date', 'fromSite', 'toSite', 'fromPerson', 'toPerson', 'remark', 'transferred'];

  operations = signal<ChartOperation[]>([]);
  isLoading = signal(true);

  ngOnInit(): void { this.loadOperations(); }

  openAddDialog(): void {
    const dialogRef = this.dialog.open(OperationFormDialogComponent, {
      width: '600px',
      data: { chartId: this.chartId }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.loadOperations();
      }
    });
  }

  private loadOperations(): void {
    this.isLoading.set(true);
    this.archiveService.getOperations(this.chartId).subscribe({
      next: res => { this.operations.set(res.data.content); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }
}
