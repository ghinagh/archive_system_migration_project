import { Component, Input, OnChanges, SimpleChanges, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitRecord } from '../../digitization/models/digitization.model';
import { DigitRecordDialogComponent } from './digit-record-dialog.component';
import { ConfirmPromptDialogComponent } from '../documentation-form/dialogs/confirm-prompt-dialog.component';

@Component({
  standalone: false,
  selector: 'app-digital-files-grid',
  templateUrl: './digital-files-grid.component.html',
  styleUrls: ['./digital-files-grid.component.scss']
})
export class DigitalFilesGridComponent implements OnChanges {

  @Input() docNo!: string;

  private digitizationService = inject(DigitizationService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = [
    'serial', 'type', 'highType', 'type1', 'digitNo', 'materialType', 'size',
    'from', 'to', 'chartType', 'newChartNo', 'chartNo', 'chartGeo', 'actions'
  ];
  items = signal<DigitRecord[]>([]);
  isLoading = signal(false);

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['docNo'] && this.docNo) {
      this.loadData();
    }
  }

  loadData(): void {
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

  openAddDialog(): void {
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

  openEditDialog(record: DigitRecord): void {
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
    const ref = this.dialog.open(ConfirmPromptDialogComponent, {
      panelClass: 'doc-form-dialog',
      data: { messageKey: 'DOC_FORM.CONFIRM_DELETE_ROW' }
    });
    ref.afterClosed().subscribe(confirmed => {
      if (!confirmed) return;
      this.digitizationService.deleteRecord(this.docNo, serial).subscribe({
        next: () => {
          this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
          this.loadData();
        },
        error: () => {}
      });
    });
  }
}
