import { Component, Input, OnInit, inject, signal } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { TempFilesService } from '../services/temp-files.service';
import { TempFile } from '../models/catalogue.models';

@Component({
  standalone: false,
  selector: 'app-temp-files',
  templateUrl: './temp-files.component.html',
  styleUrls: ['./temp-files.component.scss']
})
export class TempFilesComponent implements OnInit {

  @Input() appNo!: string;

  private tempFilesService = inject(TempFilesService);
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

  /** tmp_file.frm Insert key: execute op_tmp Form2.Text1, box_user_no, today — the server fills the row. */
  openAddDialog(): void {
    this.tempFilesService.createTempFile({ tmpFadNo: this.appNo }).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      },
      error: () => {}
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
