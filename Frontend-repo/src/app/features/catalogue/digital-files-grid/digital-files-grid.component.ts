import { Component, Input, OnChanges, SimpleChanges, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitRecord } from '../../digitization/models/digitization.model';
import { DigitRecordDialogComponent } from './digit-record-dialog.component';
import { ConfirmPromptDialogComponent } from '../documentation-form/dialogs/confirm-prompt-dialog.component';
import { ArchiveSearchService } from '../../archive-search/services/archive-search.service';

/**
 * Legacy Form6.frm datagrid1_DblClick (:3432-3452): 01/03/05 open directly via OpenDoc; 04
 * goes to the ranjpath video-preview path instead (not reproduced here — no player component
 * wired into this grid yet). 02 (waves) also resolves through the same picture-root/asset-class
 * mechanism as 01/03/05 (MediaService.assetClassFolders already maps "02"→"waves" — proven by
 * its own doc-comment, which cites this exact legacy branch) even though legacy opens it in the
 * WindowsMediaPlayer-based vd_preview rather than OpenDoc; a browser plays audio natively from a
 * blob URL, so the existing download-and-open-in-new-tab flow already used for 01/03/05 is a
 * faithful equivalent for 02 as well, with zero new code.
 */
const OPENDOC_ASSET_CLASSES = new Set(['01', '02', '03', '05']);

@Component({
  standalone: false,
  selector: 'app-digital-files-grid',
  templateUrl: './digital-files-grid.component.html',
  styleUrls: ['./digital-files-grid.component.scss']
})
export class DigitalFilesGridComponent implements OnChanges {

  /**
   * Null until a form number exists. Legacy DataGrid1 is never hidden — it is always on the
   * form, and each of its handlers is guarded only by `If Not m_mn_app_no.Text = ""`
   * (DataGrid1_KeyPress :3541, DataGrid1_KeyUp :3654), so the grid structure has to render
   * before a record does.
   */
  @Input() docNo: string | null = null;

  /**
   * Message shown when an add is attempted with no record to attach to. Defaults to the exact
   * legacy MsgBox (Form6.frm:3644/3717); the parent overrides it when a number has been typed
   * but the row does not exist yet, which is a migrated-only state (legacy's op_article inserts
   * the MAIN row the moment سجل جديد is pressed).
   */
  @Input() blockedMessageKey = 'DOC_FORM.NO_RECORD_LOADED';

  private digitizationService = inject(DigitizationService);
  private archiveSearchService = inject(ArchiveSearchService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  /**
   * Legacy Form6.frm DataGrid1 (:1599-1929) — exactly its 17 visible columns, exact order.
   * من/الى are NOT collapsed (س/د/ث each stay separate, matching DIG_O/DIG_M/DIG_S and
   * DIG_O1/DIG_M1/DIG_S1 individually).
   */
  displayedColumns = [
    'serial', 'highType', 'type1', 'type', 'digitNo', 'materialType', 'size',
    'durationHours', 'durationMinutes', 'durationSeconds',
    'durationHours1', 'durationMinutes1', 'durationSeconds1',
    'newChartNo', 'chartNo', 'chartType', 'chartGeo', 'actions'
  ];
  items = signal<DigitRecord[]>([]);
  isLoading = signal(false);

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['docNo']) {
      if (this.docNo) {
        this.loadData();
      } else {
        // The grid now outlives a record (it used to be destroyed by the parent), so a
        // سجل جديد must clear the previous record's rows itself.
        this.items.set([]);
      }
    }
  }

  private showBlocked(): void {
    this.snackBar.open(this.translate.instant(this.blockedMessageKey), '', { duration: 4000 });
  }

  loadData(): void {
    if (!this.docNo) return;
    this.isLoading.set(true);
    this.digitizationService.getRecords(0, 100, this.docNo).subscribe({
      next: r => { this.items.set(r.data.content); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  private nextSerial(): number {
    const serials = this.items().map(i => i.serial);
    return serials.length === 0 ? 1 : Math.max(...serials) + 1;
  }

  /** Legacy DataGrid1_KeyDown F5 (:3523-3534): `execute op_digit(appNo, serial)` — the
   *  migrated equivalent creates the record via the same createRecord() call openAddDialog
   *  already uses, keeping docNo/serial assignment identical either way this is triggered. */
  onGridKeydown(event: KeyboardEvent): void {
    if (event.key === 'F5') {
      event.preventDefault();
      this.openAddDialog();
    }
  }

  openAddDialog(): void {
    if (!this.docNo) {
      this.showBlocked();
      return;
    }
    const ref = this.dialog.open(DigitRecordDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { docNo: this.docNo, nextSerial: this.nextSerial(), record: null }
    });
    ref.afterClosed().subscribe(r => {
      if (r) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }

  /**
   * Legacy datagrid1_DblClick (:3425-3518) — for DIG_TYP1 01/02/03/05, resolves the archive path
   * from DIG_DIG_NO and opens it, showing the exact legacy message when the file isn't found.
   * Reuses the same media/asset endpoint already proven for شاشة البحث's grid. For 04 (video)
   * legacy opens a player window (vd_preview) resolved through the ranjpath/tape mechanism
   * instead — DIG_DIG_NO is a valid stockNo for that path too (proven separately), but no
   * player component is wired into this grid yet, so 04 is left to the not-found message here
   * rather than guessing a UI for it (out of scope for the upload work this comment sits next
   * to — see the file-upload investigation for the full trace).
   */
  openAssetOnDblClick(row: DigitRecord): void {
    const type1 = row.type1?.trim();
    if (!row.digitNo || !type1 || !OPENDOC_ASSET_CLASSES.has(type1)) {
      this.snackBar.open(this.translate.instant('DOC_FORM.FILE_NOT_FOUND'), '', { duration: 4000 });
      return;
    }
    this.archiveSearchService.downloadAsset(row.digitNo, type1, row.type).subscribe({
      next: blob => window.open(URL.createObjectURL(blob), '_blank'),
      error: () => this.snackBar.open(this.translate.instant('DOC_FORM.FILE_NOT_FOUND'), '', { duration: 4000 })
    });
  }

  openEditDialog(record: DigitRecord): void {
    if (!this.docNo) return;
    const ref = this.dialog.open(DigitRecordDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { docNo: this.docNo, nextSerial: record.serial, record }
    });
    ref.afterClosed().subscribe(r => {
      if (r) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }

  delete(serial: number): void {
    const docNo = this.docNo;
    if (!docNo) return;
    const ref = this.dialog.open(ConfirmPromptDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { messageKey: 'DOC_FORM.CONFIRM_DELETE_ROW' }
    });
    ref.afterClosed().subscribe(confirmed => {
      if (!confirmed) return;
      this.digitizationService.deleteRecord(docNo, serial).subscribe({
        next: () => {
          this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
          this.loadData();
        },
        error: () => {}
      });
    });
  }
}
