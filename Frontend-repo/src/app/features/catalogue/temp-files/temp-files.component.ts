import { Component, Input, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { TempFilesService } from '../services/temp-files.service';
import { TempFile } from '../models/catalogue.models';
import { TempFileDialogComponent } from '../temp-file-dialog/temp-file-dialog.component';

@Component({
  standalone: false,
  selector: 'app-temp-files',
  templateUrl: './temp-files.component.html',
  styleUrls: ['./temp-files.component.scss']
})
export class TempFilesComponent implements OnInit {

  @Input() appNo!: string;

  private tempFilesService = inject(TempFilesService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['tmpFileName', 'tmpRmrk', 'tmpMk', 'tmpDate', 'tmpUserNo', 'status', 'actions'];
  items = signal<TempFile[]>([]);
  isLoading = signal(false);

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.isLoading.set(true);
    this.tempFilesService.getTempFiles(this.appNo).subscribe({
      next: r => { this.items.set(r.data); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  openAddDialog(): void {
    const ref = this.dialog.open(TempFileDialogComponent, {
      width: '440px',
      data: { appNo: this.appNo }
    });
    ref.afterClosed().subscribe(r => {
      if (r) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }

  finalize(no: string, ser: number): void {
    this.tempFilesService.finalizeTempFile(no, ser).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      },
      error: () => {}
    });
  }

  delete(no: string, ser: number): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.tempFilesService.deleteTempFile(no, ser).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      },
      error: () => {}
    });
  }
}
