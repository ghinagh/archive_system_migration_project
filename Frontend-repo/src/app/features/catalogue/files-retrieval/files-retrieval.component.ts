import { Component, OnInit, inject, signal } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { TempFilesService } from '../services/temp-files.service';
import { TempFile } from '../models/catalogue.models';

@Component({
  standalone: false,
  selector: 'app-files-retrieval',
  templateUrl: './files-retrieval.component.html',
  styleUrls: ['./files-retrieval.component.scss']
})
export class FilesRetrievalComponent implements OnInit {

  private tempFilesService = inject(TempFilesService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['tmpFadNo', 'tmpFileName', 'tmpRmrk', 'tmpMk', 'tmpDate', 'tmpUserNo', 'status', 'actions'];
  items = signal<TempFile[]>([]);
  isLoading = signal(false);
  searched = signal(false);

  fadNo = signal('');
  userNo = signal('');
  finalStatus = signal<number | null>(null);

  ngOnInit(): void {
    this.search();
  }

  search(): void {
    this.isLoading.set(true);
    this.tempFilesService.searchTempFiles(
      this.fadNo() || undefined,
      this.userNo() || undefined,
      this.finalStatus() ?? undefined
    ).subscribe({
      next: r => {
        this.items.set(r.data);
        this.isLoading.set(false);
        this.searched.set(true);
      },
      error: () => {
        this.isLoading.set(false);
        this.searched.set(true);
      }
    });
  }

  clearFilters(): void {
    this.fadNo.set('');
    this.userNo.set('');
    this.finalStatus.set(null);
    this.search();
  }

  finalize(no: string, ser: number): void {
    this.tempFilesService.finalizeTempFile(no, ser).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.search();
      },
      error: () => {}
    });
  }

  delete(no: string, ser: number): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.tempFilesService.deleteTempFile(no, ser).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.search();
      },
      error: () => {}
    });
  }
}
