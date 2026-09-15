import { Component, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PageEvent } from '@angular/material/paginator';
import { AuthorsService } from '../services/authors.service';
import { Author } from '../models/author.model';
import { AuthorDialogComponent } from '../author-dialog/author-dialog.component';

@Component({
  standalone: false,
  selector: 'app-author-list',
  templateUrl: './author-list.component.html',
  styleUrls: ['./author-list.component.scss']
})
export class AuthorListComponent implements OnInit {

  private authorsService = inject(AuthorsService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['autNo', 'name', 'type', 'subjectNo', 'actions'];
  items = signal<Author[]>([]);
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
    this.authorsService.getAll(this.pageIndex(), this.pageSize(), this.filterName() || undefined).subscribe({
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

  openDialog(item?: Author): void {
    const ref = this.dialog.open(AuthorDialogComponent, { width: '420px', data: item || null });
    ref.afterClosed().subscribe(r => {
      if (r) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }

  onDelete(autNo: number): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.authorsService.delete(autNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }
}
