import { Component, Inject, OnInit, computed, inject, signal } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ArchiveService } from '../services/archive.service';
import { ChartOperation } from '../models/archive.model';

export interface ChartDeleteConfirmDialogData {
  chartId: number;
}

@Component({
  standalone: false,
  selector: 'app-chart-delete-confirm-dialog',
  templateUrl: './chart-delete-confirm-dialog.component.html',
  styleUrls: ['./chart-delete-confirm-dialog.component.scss']
})
export class ChartDeleteConfirmDialogComponent implements OnInit {

  private archiveService = inject(ArchiveService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isLoading = signal(true);
  isDeleting = signal(false);
  confirmed = signal(false);
  operations = signal<ChartOperation[]>([]);
  totalCount = signal(0);

  visibleOperations = computed(() => this.operations().slice(0, 5));
  extraCount = computed(() => Math.max(0, this.totalCount() - 5));

  constructor(
    @Inject(MAT_DIALOG_DATA) readonly data: ChartDeleteConfirmDialogData,
    private dialogRef: MatDialogRef<ChartDeleteConfirmDialogComponent>
  ) {}

  ngOnInit(): void {
    this.archiveService.getOperations(this.data.chartId, 0, 100).subscribe({
      next: res => {
        this.operations.set(res.data.content);
        this.totalCount.set(res.data.totalElements);
        this.isLoading.set(false);
      },
      error: () => {
        this.totalCount.set(0);
        this.isLoading.set(false);
      }
    });
  }

  onConfirm(): void {
    this.isDeleting.set(true);
    this.archiveService.delete(this.data.chartId).subscribe({
      next: () => {
        this.dialogRef.close();
        this.snack.open(this.t.instant('ARCHIVE.CHART_DELETED'), '', { duration: 3000 });
        this.router.navigate(['/archive']);
      },
      error: () => {
        this.isDeleting.set(false);
        this.dialogRef.close();
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
      }
    });
  }

  onCancel(): void {
    this.dialogRef.close();
  }
}
