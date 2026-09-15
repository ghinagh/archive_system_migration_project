import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ArchiveService } from '../services/archive.service';
import { ChartItem } from '../models/archive.model';
import { PERM_CREATE, PERM_DELETE } from '../../../shared/models/permission-constants';

@Component({
  standalone: false,
  selector: 'app-archive-list',
  templateUrl: './archive-list.component.html',
  styleUrls: ['./archive-list.component.scss']
})
export class ArchiveListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private archiveService = inject(ArchiveService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['chaNo', 'subject', 'type', 'date', 'title', 'stock', 'nbDis', 'actions'];

  items = signal<ChartItem[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  filterTitle = signal('');
  filterType = signal<number | null>(null);

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);
    const title = this.filterTitle() || undefined;
    const type = this.filterType() ?? undefined;

    this.archiveService.getAll(this.pageIndex(), this.pageSize(), title, type).subscribe({
      next: res => { this.items.set(res.data.content); this.totalElements.set(res.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.loadData(); }
  applyFilter(): void { this.pageIndex.set(0); this.loadData(); }
  clearFilter(): void { this.filterTitle.set(''); this.filterType.set(null); this.pageIndex.set(0); this.loadData(); }
  viewDetail(id: number): void { this.router.navigate(['/archive', id]); }
  addNew(): void { this.router.navigate(['/archive', 'new']); }

  onDelete(id: number): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.archiveService.delete(id).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 }); this.loadData(); }
    });
  }
}
