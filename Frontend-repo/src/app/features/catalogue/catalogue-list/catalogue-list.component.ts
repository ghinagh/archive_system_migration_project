import { Component, OnInit, ViewChild, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { CatalogueService } from '../services/catalogue.service';
import { CatalogueItem } from '../models/catalogue.models';
import { PERM_CREATE, PERM_DELETE } from '../../../shared/models/permission-constants';
import { SearchCondition, SearchFieldDef } from '../../../shared/models/search-condition.model';

@Component({
  standalone: false,
  selector: 'app-catalogue-list',
  templateUrl: './catalogue-list.component.html',
  styleUrls: ['./catalogue-list.component.scss']
})
export class CatalogueListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private catalogueService = inject(CatalogueService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['appNo', 'activeTitleAr', 'type', 'entryDate', 'actions'];

  items = signal<CatalogueItem[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  filterType = signal<string>('');
  filterTitle = signal<string>('');
  filterDateFrom = signal<string>('');
  filterDateTo = signal<string>('');

  advancedSearchFields: SearchFieldDef[] = [
    { value: 'title', labelKey: 'CATALOGUE.ACTIVE_TITLE', type: 'STRING' },
    { value: 'additionalTitle', labelKey: 'CATALOGUE.ADDITIONAL_TITLE', type: 'STRING' },
    { value: 'type', labelKey: 'CATALOGUE.TYPE', type: 'STRING' },
    { value: 'appDoc', labelKey: 'CATALOGUE.APP_DOC', type: 'STRING' },
    { value: 'entryDate', labelKey: 'CATALOGUE.ENTRY_DATE', type: 'DATE' }
  ];
  private advancedConditions = signal<SearchCondition[]>([]);

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.isLoading.set(true);

    if (this.advancedConditions().length > 0) {
      this.catalogueService.advancedSearch(this.advancedConditions(), this.pageIndex(), this.pageSize()).subscribe({
        next: (res) => {
          this.items.set(res.data.content);
          this.totalElements.set(res.data.totalElements);
          this.isLoading.set(false);
        },
        error: () => this.isLoading.set(false)
      });
      return;
    }

    const type = this.filterType() || undefined;
    const dateFrom = this.filterDateFrom() || undefined;
    const dateTo = this.filterDateTo() || undefined;

    this.catalogueService.getAll(this.pageIndex(), this.pageSize(), type, dateFrom, dateTo).subscribe({
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
    this.filterType.set('');
    this.filterTitle.set('');
    this.filterDateFrom.set('');
    this.filterDateTo.set('');
    this.pageIndex.set(0);
    this.loadData();
  }

  viewDetail(appNo: string): void {
    this.router.navigate(['/catalogue', appNo]);
  }

  addNew(): void {
    this.router.navigate(['/catalogue', 'new']);
  }

  onDelete(appNo: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;

    this.catalogueService.delete(appNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.loadData();
      }
    });
  }
}
