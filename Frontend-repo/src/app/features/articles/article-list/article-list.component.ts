import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ArticlesService } from '../services/articles.service';
import { Article } from '../models/article.model';
import { PERM_CREATE, PERM_DELETE } from '../../../shared/models/permission-constants';

@Component({
  standalone: false,
  selector: 'app-article-list',
  templateUrl: './article-list.component.html',
  styleUrls: ['./article-list.component.scss']
})
export class ArticleListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private svc = inject(ArticlesService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  displayedColumns = ['appNo', 'periodicalName', 'year', 'volume', 'articleNo', 'date', 'lang', 'actions'];
  items = signal<Article[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterTitle = signal('');
  filterPerNo = signal<number | null>(null);
  filterYear = signal<number | null>(null);
  filterLang = signal('');

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);
    this.svc.getAll(
      this.pageIndex(),
      this.pageSize(),
      this.filterPerNo() ?? undefined,
      this.filterYear() ?? undefined,
      this.filterLang() || undefined
    ).subscribe({
      next: r => { this.items.set(r.data.content); this.totalElements.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.loadData(); }
  applyFilter(): void { this.pageIndex.set(0); this.loadData(); }

  clearFilter(): void {
    this.filterTitle.set('');
    this.filterPerNo.set(null);
    this.filterYear.set(null);
    this.filterLang.set('');
    this.pageIndex.set(0);
    this.loadData();
  }

  viewDetail(appNo: string): void { this.router.navigate(['/articles', appNo]); }
  addNew(): void { this.router.navigate(['/articles', 'new']); }

  onDelete(appNo: string): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.delete(appNo).subscribe({
      next: () => { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.loadData(); }
    });
  }
}
