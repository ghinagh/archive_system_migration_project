import { Component, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PageEvent } from '@angular/material/paginator';
import { SitesService } from '../services/sites.service';
import { Position } from '../models/sites.model';
import { PositionDialogComponent } from '../position-dialog/position-dialog.component';

@Component({
  standalone: false,
  selector: 'app-position-list',
  templateUrl: './position-list.component.html',
  styleUrls: ['./position-list.component.scss']
})
export class PositionListComponent implements OnInit {

  private sitesService = inject(SitesService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['posNo', 'name', 'recordDate', 'actions'];
  items = signal<Position[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterName = signal('');

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.isLoading.set(true);
    this.sitesService.getPositions(this.pageIndex(), this.pageSize(), this.filterName() || undefined).subscribe({
      next: r => {
        this.items.set(r.data.content);
        this.totalElements.set(r.data.totalElements);
        this.isLoading.set(false);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void {
    this.pageIndex.set(e.pageIndex);
    this.pageSize.set(e.pageSize);
    this.loadData();
  }

  applyFilter(): void {
    this.pageIndex.set(0);
    this.loadData();
  }

  openDialog(item?: Position): void {
    const ref = this.dialog.open(PositionDialogComponent, { width: '420px', data: item || null });
    ref.afterClosed().subscribe(r => {
      if (r) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }

  onDelete(posNo: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.sitesService.deletePosition(posNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }
}
