import { Component, OnInit, inject, signal } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { MaintenanceService } from '../services/maintenance.service';
import { CopyToArchiveResult, FileLink, BackupInfo, RetrievalField } from '../models/maintenance.model';
import { CatalogueItem } from '../../catalogue/models/catalogue.models';
import { RetrievalFieldDialogComponent } from '../retrieval-field-dialog/retrieval-field-dialog.component';

const TAB_INDEX_BY_KEY: Record<string, number> = {
  renumber: 0,
  copy: 1,
  links: 2,
  backup: 3,
  unlock: 4,
  fields: 5
};

@Component({
  standalone: false,
  selector: 'app-maintenance-shell',
  templateUrl: './maintenance-shell.component.html',
  styleUrls: ['./maintenance-shell.component.scss']
})
export class MaintenanceShellComponent implements OnInit {

  private maintenanceService = inject(MaintenanceService);
  private translate = inject(TranslateService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private route = inject(ActivatedRoute);

  linkCols = ['filePath', 'linkedByUser', 'linkedAt', 'actions'];
  backupCols = ['fileName', 'sizeBytes', 'createdAt'];
  lockedCols = ['appNo', 'activeTitleAr', 'dataEntry', 'actions'];
  fieldCols = ['module', 'fieldKey', 'label', 'fieldType', 'enabled', 'actions'];

  selectedTabIndex = signal(0);

  private backupsLoaded = false;
  private lockedLoaded = false;
  private fieldsLoaded = false;

  ngOnInit(): void {
    const tabKey = this.route.snapshot.queryParamMap.get('tab');
    const index = tabKey ? TAB_INDEX_BY_KEY[tabKey] : undefined;
    if (index !== undefined) {
      this.selectedTabIndex.set(index);
      this.onTabChange(index);
    }
  }

  onTabChange(index: number): void {
    this.selectedTabIndex.set(index);
    if (index === 3 && !this.backupsLoaded) {
      this.backupsLoaded = true;
      this.loadBackups();
    } else if (index === 4 && !this.lockedLoaded) {
      this.lockedLoaded = true;
      this.loadLockedDocs();
    } else if (index === 5 && !this.fieldsLoaded) {
      this.fieldsLoaded = true;
      this.loadRetrievalFields();
    }
  }

  // --- Tab 1: Renumber ---
  oldAppNo = signal('');
  newAppNo = signal('');
  renumberLoading = signal(false);
  renumberSuccess = signal(false);
  renumberError = signal<string | null>(null);

  submitRenumber(): void {
    if (!this.oldAppNo() || !this.newAppNo()) return;
    this.renumberLoading.set(true);
    this.renumberSuccess.set(false);
    this.renumberError.set(null);

    this.maintenanceService.renumber({ oldAppNo: this.oldAppNo(), newAppNo: this.newAppNo() }).subscribe({
      next: () => {
        this.renumberLoading.set(false);
        this.renumberSuccess.set(true);
        this.oldAppNo.set('');
        this.newAppNo.set('');
      },
      error: (err: HttpErrorResponse) => {
        this.renumberLoading.set(false);
        this.renumberError.set(this.extractErrorMessage(err));
      }
    });
  }

  // --- Tab 2: Copy to Archive ---
  stockNo = signal('');
  copyLoading = signal(false);
  copyResult = signal<CopyToArchiveResult | null>(null);
  copyError = signal<string | null>(null);

  submitCopyToArchive(): void {
    if (!this.stockNo()) return;
    this.copyLoading.set(true);
    this.copyResult.set(null);
    this.copyError.set(null);

    this.maintenanceService.copyToArchive({ stockNo: this.stockNo() }).subscribe({
      next: (res) => {
        this.copyLoading.set(false);
        this.copyResult.set(res.data);
      },
      error: (err: HttpErrorResponse) => {
        this.copyLoading.set(false);
        this.copyError.set(this.extractErrorMessage(err));
      }
    });
  }

  // --- Tab 3: Link Files ---
  linkAppNo = signal('');
  filePath = signal('');
  fileLinks = signal<FileLink[]>([]);
  linksLoaded = signal(false);
  linkLoading = signal(false);
  linkError = signal<string | null>(null);

  loadLinks(): void {
    if (!this.linkAppNo()) return;
    this.linkLoading.set(true);
    this.linkError.set(null);

    this.maintenanceService.getFileLinks(this.linkAppNo()).subscribe({
      next: (res) => {
        this.linkLoading.set(false);
        this.linksLoaded.set(true);
        this.fileLinks.set(res.data);
      },
      error: (err: HttpErrorResponse) => {
        this.linkLoading.set(false);
        this.linkError.set(this.extractErrorMessage(err));
      }
    });
  }

  addLink(): void {
    if (!this.linkAppNo() || !this.filePath()) return;
    this.linkLoading.set(true);
    this.linkError.set(null);

    this.maintenanceService.linkFile({ appNo: this.linkAppNo(), filePath: this.filePath() }).subscribe({
      next: () => {
        this.filePath.set('');
        this.loadLinks();
      },
      error: (err: HttpErrorResponse) => {
        this.linkLoading.set(false);
        this.linkError.set(this.extractErrorMessage(err));
      }
    });
  }

  deleteLink(id: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.maintenanceService.deleteFileLink(id).subscribe({
      next: () => this.loadLinks(),
      error: (err: HttpErrorResponse) => this.linkError.set(this.extractErrorMessage(err))
    });
  }

  // --- Tab 4: Database Backup ---
  backups = signal<BackupInfo[]>([]);
  backupsLoading = signal(false);
  backupCreating = signal(false);
  backupError = signal<string | null>(null);

  loadBackups(): void {
    this.backupsLoading.set(true);
    this.backupError.set(null);
    this.maintenanceService.listBackups().subscribe({
      next: (res) => {
        this.backupsLoading.set(false);
        this.backups.set(res.data);
      },
      error: (err: HttpErrorResponse) => {
        this.backupsLoading.set(false);
        this.backupError.set(this.extractErrorMessage(err));
      }
    });
  }

  createBackup(): void {
    this.backupCreating.set(true);
    this.backupError.set(null);
    this.maintenanceService.createBackup().subscribe({
      next: () => {
        this.backupCreating.set(false);
        this.snackBar.open(this.translate.instant('MAINTENANCE.BACKUP_SUCCESS'), '', { duration: 3000 });
        this.loadBackups();
      },
      error: (err: HttpErrorResponse) => {
        this.backupCreating.set(false);
        this.backupError.set(this.extractErrorMessage(err));
      }
    });
  }

  // --- Tab 5: Unlock Documents ---
  lockedDocs = signal<CatalogueItem[]>([]);
  lockedTotal = signal(0);
  lockedPageIndex = signal(0);
  lockedPageSize = signal(10);
  lockedLoading = signal(false);
  lockedError = signal<string | null>(null);

  loadLockedDocs(): void {
    this.lockedLoading.set(true);
    this.lockedError.set(null);
    this.maintenanceService.getLockedDocuments(this.lockedPageIndex(), this.lockedPageSize()).subscribe({
      next: (res) => {
        this.lockedLoading.set(false);
        this.lockedDocs.set(res.data.content);
        this.lockedTotal.set(res.data.totalElements);
      },
      error: (err: HttpErrorResponse) => {
        this.lockedLoading.set(false);
        this.lockedError.set(this.extractErrorMessage(err));
      }
    });
  }

  onLockedPageChange(event: { pageIndex: number; pageSize: number }): void {
    this.lockedPageIndex.set(event.pageIndex);
    this.lockedPageSize.set(event.pageSize);
    this.loadLockedDocs();
  }

  unlockDocument(appNo: string): void {
    this.maintenanceService.unlockDocument(appNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('MAINTENANCE.UNLOCK_SUCCESS'), '', { duration: 3000 });
        this.loadLockedDocs();
      },
      error: (err: HttpErrorResponse) => this.lockedError.set(this.extractErrorMessage(err))
    });
  }

  // --- Tab 6: Retrieval Fields ---
  retrievalFields = signal<RetrievalField[]>([]);
  retrievalFieldsLoading = signal(false);
  retrievalFieldsError = signal<string | null>(null);

  loadRetrievalFields(): void {
    this.retrievalFieldsLoading.set(true);
    this.retrievalFieldsError.set(null);
    this.maintenanceService.getRetrievalFields().subscribe({
      next: (res) => {
        this.retrievalFieldsLoading.set(false);
        this.retrievalFields.set(res.data);
      },
      error: (err: HttpErrorResponse) => {
        this.retrievalFieldsLoading.set(false);
        this.retrievalFieldsError.set(this.extractErrorMessage(err));
      }
    });
  }

  openFieldDialog(field?: RetrievalField): void {
    const ref = this.dialog.open(RetrievalFieldDialogComponent, {
      width: '440px',
      data: field ?? null
    });
    ref.afterClosed().subscribe((saved) => {
      if (saved) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadRetrievalFields();
      }
    });
  }

  deleteField(id: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.maintenanceService.deleteRetrievalField(id).subscribe({
      next: () => this.loadRetrievalFields(),
      error: (err: HttpErrorResponse) => this.retrievalFieldsError.set(this.extractErrorMessage(err))
    });
  }

  private extractErrorMessage(err: HttpErrorResponse): string {
    const body = err.error as { message?: string } | null;
    return body?.message || this.translate.instant('APP.ERROR');
  }
}
