import { Component, OnInit, ViewChild, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { NewsService } from '../services/news.service';
import { NewsItem } from '../models/news.model';
import { PERM_CREATE, PERM_DELETE } from '../../../shared/models/permission-constants';
import { SearchCondition, SearchFieldDef } from '../../../shared/models/search-condition.model';

@Component({
  standalone: false,
  selector: 'app-news-list',
  templateUrl: './news-list.component.html',
  styleUrls: ['./news-list.component.scss']
})
export class NewsListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private newsService = inject(NewsService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['newsNo', 'newsDoc', 'newsTit1', 'newsTit2', 'newsDte', 'newsPub', 'actions'];

  items = signal<NewsItem[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  filterTitle = signal('');
  filterDocType = signal('');
  filterDateFrom = signal('');
  filterDateTo = signal('');
  filterPublication = signal('');

  advancedSearchFields: SearchFieldDef[] = [
    { value: 'title', labelKey: 'NEWS.ARABIC_TITLE', type: 'STRING' },
    { value: 'additionalTitle', labelKey: 'NEWS.SECOND_TITLE', type: 'STRING' },
    { value: 'docType', labelKey: 'NEWS.DOC_TYPE', type: 'STRING' },
    { value: 'date', labelKey: 'NEWS.DATE', type: 'DATE' },
    { value: 'publication', labelKey: 'NEWS.PUBLICATION', type: 'NUMBER' }
  ];
  private advancedConditions = signal<SearchCondition[]>([]);

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.isLoading.set(true);

    if (this.advancedConditions().length > 0) {
      this.newsService.advancedSearch(this.advancedConditions(), this.pageIndex(), this.pageSize()).subscribe({
        next: (res) => {
          this.items.set(res.data.content);
          this.totalElements.set(res.data.totalElements);
          this.isLoading.set(false);
        },
        error: () => this.isLoading.set(false)
      });
      return;
    }

    const title = this.filterTitle() || undefined;
    const docType = this.filterDocType() || undefined;
    const dateFrom = this.filterDateFrom() || undefined;
    const dateTo = this.filterDateTo() || undefined;
    const pub = this.filterPublication() ? Number(this.filterPublication()) : undefined;

    this.newsService.getAll(this.pageIndex(), this.pageSize(), docType, dateFrom, dateTo, pub, title).subscribe({
      next: (res) => {
        this.items.set(res.data.content);
        this.totalElements.set(res.data.totalElements);
        this.isLoading.set(false);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onAdvancedSearch(conditions: SearchCondition[]): void {
    this.advancedConditions.set(conditions);
    this.pageIndex.set(0);
    this.loadData();
  }

  onAdvancedSearchCleared(): void {
    this.advancedConditions.set([]);
    this.pageIndex.set(0);
    this.loadData();
  }

  onPageChange(event: PageEvent): void {
    this.pageIndex.set(event.pageIndex);
    this.pageSize.set(event.pageSize);
    this.loadData();
  }

  applyFilter(): void {
    this.pageIndex.set(0);
    this.loadData();
  }

  clearFilter(): void {
    this.filterTitle.set('');
    this.filterDocType.set('');
    this.filterDateFrom.set('');
    this.filterDateTo.set('');
    this.filterPublication.set('');
    this.pageIndex.set(0);
    this.loadData();
  }

  viewDetail(newsNo: string): void {
    this.router.navigate(['/news', newsNo]);
  }

  addNew(): void {
    this.router.navigate(['/news', 'new']);
  }

  onDelete(newsNo: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;

    this.newsService.delete(newsNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.loadData();
      }
    });
  }
}
